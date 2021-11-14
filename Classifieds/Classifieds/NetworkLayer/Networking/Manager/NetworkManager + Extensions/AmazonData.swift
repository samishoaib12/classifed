//  NetworkLayer

import Foundation

extension NetworkManager {
    
    // MARK: Authentication
    
    public func getAmazonList(completion: @escaping (ItemListResponse?, NetworkResponseError?) -> Void) {
        
        let endpoint: GoingStoreEndPoint = .getAmazonItems
        
        func performRequest() {
            router.request(endpoint, completion: { [weak self] data, response, error in
                guard let sSelf = self else { return }
                
                sSelf.responseDataProcessingGeneric(data: data, response: response, error: error) { (responseModel: ItemListResponse?, responseError) in
                    completion(responseModel, responseError)
                }
            })
        }
        
        performRequest()
        
    }
    
}
