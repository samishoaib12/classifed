//
//  GoingStoreEndPoint + Headers.swift

import Foundation

extension GoingStoreEndPoint {
    
    var headers: HTTPHeaders? {
        switch self {
        case .getAmazonItems:
            return [Constants.Headers.contentType: Constants.Headers.applicationJson]
        }
    }
    
}
