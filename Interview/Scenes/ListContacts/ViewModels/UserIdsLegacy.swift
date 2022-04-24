//
//  UserIdsLegacy.swift
//  Interview
//
//  Created by Wagner Coleta on 23/04/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

class UserIdsLegacy {
    static let legacyIds = [10, 11, 12, 13]
    
    static func isLegacy(id: Int) -> Bool {
        return legacyIds.contains(id)
    }
}
