//
//  NetworkManagerProtocol.swift
//  NetworkLayer
//

import Foundation

public protocol NetworkLayerRetryManager {
    func showRetryAndCancelAlert(message: String, retryCompletion: (() -> Void)?, cancelCompletion: (() -> Void)?)
}

public protocol NetworkLayerTimeoutManager {
  
}

protocol NetworkManagerProtocol {
    func getAmazonList(completion: @escaping (ItemListResponse?, NetworkResponseError?) -> Void)
}
