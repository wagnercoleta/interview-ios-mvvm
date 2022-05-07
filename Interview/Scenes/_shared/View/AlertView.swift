//
//  AlertView.swift
//  Interview
//
//  Created by Wagner Coleta on 23/04/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

protocol AlertView: AnyObject {
    func showMessage(title: String, message: String)
}
