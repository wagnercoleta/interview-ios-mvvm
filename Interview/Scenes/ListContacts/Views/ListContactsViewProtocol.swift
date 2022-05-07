//
//  ListContactsViewProtocol.swift
//  Interview
//
//  Created by Wagner Coleta on 06/05/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation
import UIKit

protocol ListContactsViewProtocol: UIView {
    var delegate: AlertView? { get set }
    
    func setData(data: [Contact]?)
}
