//
//  ContactResponse.swift
//  Interview
//
//  Created by Wagner Coleta on 06/05/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

struct ContactDTO: Decodable {
    let id: Int
    let name: String
    let photoURL: String
    
    /*
    --> Utilizamos apenas se a PropertyName do JSON for diferente na struct
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case photoURL = "photoURL"
        case id = "id"
    }*/
}
