//
//  HttpClientMock.swift
//  InterviewTests
//
//  Created by Wagner Coleta on 23/04/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation
@testable import Interview

class HttpClientMock: HttpClient {
    
    var urls = [String]()
    var completion: ((Result<Data?, HttpError>) -> Void)?
    
    func get(to urlString: String, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urls.append(urlString)
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError){
        completion?(.failure(error))
    }
    
    func completeWithData(_ data: Data){
        completion?(.success(data))
    }
}
