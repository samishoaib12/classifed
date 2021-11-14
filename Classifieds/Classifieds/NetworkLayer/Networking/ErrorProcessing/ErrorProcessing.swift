//
//  ErrorProcessing.swift
//  NetworkLayer
//
import Foundation
import UIKit

public struct ErrorMessages {
    public static let sorryTryAgainLater = "SORRY_TRY_AGAIN_LATER"
    static let noInternetConnection = "PLEASE_CHECK_YOUR_INTERNET_CONNECTION"
    static let noResults = "THERE_ARE_NO_RESULTS"
    static let requestTimedOut = "REQUEST_TIMED_OUT"
}

public enum NetworkResponseError: Equatable {
    case unKnownError
    case alert(message: String)
}

class ErrorProcessing: NSObject {
    
    static func processError(data: Data?, response: URLResponse?, error: Error?) -> NetworkResponseError {
        
        if let data = data, let response = response as? HTTPURLResponse {
            return ErrorProcessing.codeToErrorProcessed(code: response.statusCode, data: data)
        } else if let error = error as NSError? {
            return ErrorProcessing.codeToErrorProcessed(code: error.code, data: data)
        } else {
            return .unKnownError
        }
    }
    
    internal static func codeToErrorProcessed(code: Int, data: Data?) -> NetworkResponseError {
        
        let errorMessage = ErrorMessages.sorryTryAgainLater
        switch code {
        case 400:
            return .unKnownError
        default:
            return .alert(message: errorMessage)
        }
    }
}
