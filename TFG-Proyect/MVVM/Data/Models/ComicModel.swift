//
//  ComicModel.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 12/3/25.
//


struct ComicBaseResponse: Decodable {
    let data: ComicDataResponse
    let code: Int
}

struct ComicDataResponse: Decodable {
    let results: [ComicModel]
}

struct ComicModel: Decodable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: ThumbnailModel
}

