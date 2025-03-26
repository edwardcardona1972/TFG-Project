//
//  NetworError.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 21/3/25.
//

import Foundation
import Alamofire

enum NetworError: String, Error {
    case invalidURL
    case generic
    case couldNotConnectData
    case httpResponseError
    case statusCodeError = "Ocurrio un error al tratar de consultar la API: satus code"
    case jsonDecoder = "Error en intentar enttrar datos en el JSON"    
}

extension NetworError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("La URL es invalida", comment: "")
        case .generic:
            return NSLocalizedString("La app falló popr un error desconocido, validar API-KEY", comment: "")
        case .couldNotConnectData:
            return NSLocalizedString("No se pudo hacer el code de la data", comment: "")
        case .httpResponseError:
            return NSLocalizedString("Imposible obtener el HTTPURLResponse", comment: "")
        case .statusCodeError:
            return NSLocalizedString("El status code es diferente a 200", comment: "")
        case .jsonDecoder:
            return NSLocalizedString("Falló cuando leyó el JSON ", comment: "")
        }
    }
}
