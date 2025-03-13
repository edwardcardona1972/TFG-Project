//
//  StoriesModel.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 12/3/25.
//


struct StoryesBaseResponse: Decodable {
    let data: StoryesDataResponse
    let code: Int
}

struct StoryesDataResponse: Decodable {
    let results: [StoryModel]
}

struct StoryModel: Decodable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: ThumbnailModel
}
