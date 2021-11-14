//
//  GoingStoreEndPoint + HTTPTask.swift
//  NetworkLayer

//

import Foundation

extension GoingStoreEndPoint {
    
    var task: HTTPTask {
        switch self {
        case .getAmazonItems:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: nil, additionHeaders: headers)
        }
    }
    
}
