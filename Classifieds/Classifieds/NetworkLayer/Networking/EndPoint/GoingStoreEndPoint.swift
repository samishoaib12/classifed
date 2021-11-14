//  GoingStoreEndPoint.swift

import Foundation

public enum NetworkEnvironment: String, CaseIterable {
    case SIT
    case STAGING
    case DEMO
    case PROD
    case CSI
    case REG
    case DEV
}

public enum GoingStoreEndPoint {
    case getAmazonItems
}

extension GoingStoreEndPoint: EndPointType {
    
    var baseURL : URL {
        get {
            switch self {
            default:
                guard let url = URL(string: Constants.BaseURL.environmentBaseURL) else { fatalError("baseURL could not be configured.")}
                return url
            }
        }
    }
    var path: String {
        switch self {
        
        case .getAmazonItems:
            return Constants.PathURL.itemLink()
        default:
            return ""
        }
        
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAmazonItems:
            return .get
        default:
            return .post
        }
    }
    
}
