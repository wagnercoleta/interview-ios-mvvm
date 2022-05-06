//
//  NetworkManagerProtocol.swift
//  Interview
//
//  Created by Wagner Coleta on 06/05/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchNetwork<T: Decodable>(url: String, completion: @escaping ([T]?, Error?) -> Void)
}
