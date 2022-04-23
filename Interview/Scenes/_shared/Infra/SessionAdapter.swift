//
//  SessionAdapter.swift
//  Interview
//
//  Created by Wagner Coleta on 23/04/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

final class SessionAdapter: HttpClient {
    private let session: URLSession
    
    init() {
        var config: URLSessionConfiguration
        config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        self.session = URLSession(configuration: config)
    }
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(to urlString: String, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.InvalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let _ = error {
                completion(.failure(.request))
            } else {
                if let jsonData = data {
                    completion(.success(jsonData))
                } else {
                    completion(.failure(.request))
                }
            }
        }
        task.resume()
    }
}
