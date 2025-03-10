//
//  UserViewModel.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 5/3/25.
//

import Foundation
import Combine


struct ComicData: Decodable {
    let data: ComicResults
}

struct ComicResults: Decodable {
    let results: [Comic]
}

struct Comic: Decodable {
    let title: String?
    let thumbnail: Thumbnail?
}

struct Thumbnail: Decodable {
    let path: String?
    let `extension`: String?  // Usamos comillas invertidas porque 'extension' es una palabra clave en Swift
}
