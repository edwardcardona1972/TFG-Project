//
//  StoriesModel.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 12/3/25.
//

import Foundation
struct StoriesBaseResponse: Decodable {
    let data: [StoryDataResponse]
    let code: Int
}
struct StoryDataResponse: Decodable {
    let results: [StoryResultResponse]
}
struct StoryResultResponse: Decodable {
    let id: Int
    let title: String
    let description: String
    let thumbnail: ThumbnailModel
}
