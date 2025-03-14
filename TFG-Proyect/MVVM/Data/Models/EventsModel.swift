//
//  EventsModel.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 13/3/25.
//

struct EventsBaseResponse: Decodable {
    let data: EventsDataResponse
    let code: Int
}

struct EventsDataResponse: Decodable {
    let  results: [EventsModel]
}

struct EventsModel: Decodable {
    let id: Int
    let title: String
    let description: String   
}
