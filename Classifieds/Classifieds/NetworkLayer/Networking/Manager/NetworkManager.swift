//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Eugene
//

import Foundation
import AVFoundation

enum NetworkResult {
    case success
    case failure(NetworkResponseError)
}

open class NetworkManager: NetworkManagerProtocol {
    
    
    public static let shared = NetworkManager()
    
    public var retryManagerDelegate: NetworkLayerRetryManager!
    
    public var timeoutManagerDelegate: NetworkLayerTimeoutManager!
    
    public var environment: NetworkEnvironment = .PROD {
        didSet {
    
        }
    }
    

    
    public var serverErrorPerformLogoutClosure: (()->())?
    public var voipTokenChangedPerformLogoutClosure: (()->())?
    
    let router = Router<GoingStoreEndPoint>()
    
    
    private init() {
       self.environment = .PROD
    }
    
    
    
    enum ResponseEncoding {
        case windows1256
    }
    
    func handleNetworkResponse(data: Data?, response: URLResponse?, error: Error?) -> NetworkResult {
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 200...299:
                return .success
            default:
                return .failure(ErrorProcessing.processError(data: data, response: response, error: error))
            }
        } else {
            return .failure(ErrorProcessing.processError(data: data, response: response, error: error))
        }
    }
    
    func responseDataProcessingGeneric<ResponseGenericModel: Decodable>(data: Data?, response: URLResponse?, error: Error?, encoding: ResponseEncoding? = nil, completion: @escaping(_ modelForMapping: ResponseGenericModel?, _ networkError: NetworkResponseError?) -> Void) {
        
        let result = self.handleNetworkResponse(data: data, response: response, error: error)
        switch result {
        case .success:
            guard let responseData = data else {
                completion(nil, .alert(message: ErrorMessages.sorryTryAgainLater))
                return
            }
            do {
                if let encoding = encoding, encoding == .windows1256 {
                    guard let responseDataConverted = String(data: responseData, encoding: String.windows1256)?.data(using: String.Encoding.utf8) else {
                        return completion(nil, NetworkResponseError.alert(message: ErrorMessages.sorryTryAgainLater))
                    }
                    let apiResponse = try JSONDecoder().decode(ResponseGenericModel.self, from: responseDataConverted)
                    completion(apiResponse, nil)
                } else {
                     print(responseData)
                    //  let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                      
                    let apiResponse = try? JSONDecoder().decode(ResponseGenericModel.self, from: responseData)
                    
                    completion(apiResponse, nil)
                }
                
            } catch {
                print(error)
                completion(nil, .alert(message: ErrorMessages.sorryTryAgainLater))
            }
        case .failure(let networkFailureError):
            //            if networkFailureError == .signedInOnOtherDeviceShouldLogOut { return }
            completion(nil, networkFailureError)
        }
    }
    
    func responseDataProcessingWithoutMapping(data: Data?, response: URLResponse?, error: Error?, encoding: ResponseEncoding? = nil, completion: @escaping(_ networkError: NetworkResponseError?) -> Void) {
        
        let result = self.handleNetworkResponse(data: data, response: response, error: error)
        switch result {
        case .success:
            guard let _ = data else {
                completion(.alert(message: ErrorMessages.sorryTryAgainLater))
                return
            }
            completion(nil)
        case .failure(let networkFailureError):
            //            if networkFailureError == .signedInOnOtherDeviceShouldLogOut { return }
            completion(networkFailureError)
        }
    }
    
}
