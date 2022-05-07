//
//  ListContactsViewModelProtocol.swift
//  Interview
//
//  Created by Wagner Coleta on 06/05/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

protocol ListContactsViewModelProtocol {
    var delegate: AlertView? { get set }
    var contacts: Observable<[Contact]> { get }
    func loadContacts()
}
