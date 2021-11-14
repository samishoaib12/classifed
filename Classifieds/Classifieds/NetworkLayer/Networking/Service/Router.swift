//
//  NetworkService.swift
//  NetworkLayer

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, isShouldLog: Bool, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

final class Router<EndPoint: EndPointType>: NetworkRouter {
    public var task: URLSessionTask?
    
    // MARK: - isShouldLog this variable handle printing request/response to console
    func request(_ route: EndPoint, isShouldLog: Bool = true, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            if isShouldLog {
                NetworkLogger.logRequest(request: request, options: LogOption.defaultOptions, printer: NativePrinter())
            }
            let startDateOfResponse = Date()
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                let requestDurationTime = Date().timeIntervalSince(startDateOfResponse)
                if let response = response as? HTTPURLResponse, isShouldLog == true {
                        NetworkLogger.logResponse(request: request, data: data, response: response, error: error, requestDuration: requestDurationTime, options: LogOption.defaultOptions, printer: NativePrinter())
                }
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 60.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                if let additionalHeaders = additionalHeaders {
                    self.addAdditionalHeaders(additionalHeaders, request: &request)
                }
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: HTTPParameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: HTTPParameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}
