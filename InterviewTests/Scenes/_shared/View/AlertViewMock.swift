//
//  AlertViewMock.swift
//  InterviewTests
//
//  Created by Wagner Coleta on 23/04/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation
@testable import Interview

class AlertViewMock: AlertView {
    
    var title: String?
    var message: String?
    
    func showMessage(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
