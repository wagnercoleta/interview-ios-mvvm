//
//  NetworkManager.swift
//  Interview
//
//  Created by Wagner Coleta on 06/05/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

class NetworkManager {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    private func callFetch<T: Decodable>(to urlString: String, completion: @escaping ([T]?, HttpError?) -> Void) {
        httpClient.get(to: urlString) { result in
            switch result {
                case .success(let data):
                    do {
                        guard let jsonData = data else {
                            completion(nil, .noData)
                            return
                        }
                        
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode([T].self, from: jsonData)
                        completion(decoded, nil)
                    } catch {
                        completion(nil, .errorWithDecodable)
                    }
                case .failure(let httpError):
                    completion(nil, httpError)
            }
        }
    }
}

extension NetworkManager: NetworkManagerProtocol {
    func fetchNetwork<T: Decodable>(url: String, completion: @escaping ([T]?, Error?) -> Void) {
        callFetch(to: url, completion: completion)
    }
}
