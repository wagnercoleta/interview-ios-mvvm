//
//  HttpError.swift
//  Interview
//
//  Created by Wagner Coleta on 23/04/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

enum HttpError: Error {
    case InvalidURL
    case request
    case noData
    case errorWithDecodable
    
    var text: String {
        switch self {
        case .InvalidURL:
            return "URL inválida"
        case .request:
            return "Erro de requisição"
        case .noData:
            return "Nenhum dado retornado"
        case .errorWithDecodable:
            return "Erro na decodificação do objeto (Decodable)"
        }
    }
}
