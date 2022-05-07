//
//  ListContactServiceProtocol.swift
//  Interview
//
//  Created by Wagner Coleta on 06/05/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

protocol ListContactsServiceProtocol {
    func fetchContacts(completion: @escaping ([ContactDTO]?, Error?) -> Void)
}
