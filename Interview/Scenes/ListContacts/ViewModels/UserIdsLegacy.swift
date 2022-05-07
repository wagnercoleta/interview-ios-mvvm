//
//  UserIdsLegacy.swift
//  Interview
//
//  Created by Wagner Coleta on 23/04/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

final class UserIdsLegacy {
    private let legacyIds = [10, 11, 12, 13]
    
    private func isLegacyInternal(id: Int) -> Bool {
        return legacyIds.contains(id)
    }
}

extension UserIdsLegacy: UserIdsLegacyProtocol {
    func isLegacy(id: Int) -> Bool {
        return isLegacyInternal(id: id)
    }
}
