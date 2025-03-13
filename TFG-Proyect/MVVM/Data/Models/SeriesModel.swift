//
//  SeriesModel.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 13/3/25.
//

struct SeriesBaseResponse: Decodable{
    let data: SeriesDataResponse
    let code: Int
}

struct SeriesDataResponse: Decodable{
    let results: [SeriesModel]
}

struct SeriesModel: Decodable {
    let id: Int
    let title: String
    let description: String
}
