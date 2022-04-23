//
//  HttpClientGet.swift
//  Interview
//
//  Created by Wagner Coleta on 23/04/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

protocol HttpClient {
    func get(to urlString: String, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
