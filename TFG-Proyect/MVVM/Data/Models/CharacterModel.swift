//
//  CharacterModel.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 9/3/25.
//

struct CharactersBaseResponse: Decodable{
    let code: Int
    let status: String
    let data: CharactersDataResponse
}

struct CharactersDataResponse: Decodable{
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [CharacterModel]
}

struct CharacterModel: Decodable{
    let id: Int
    let name: String
    let description: String?
    let thumbnail: ThumbnailModel
    let comics: CharacterComicsModel?
    let series: CharacterSeriesModel?
    let stories: ChracterStoriesModel?
    let events: CharacterEventsModel?
}
struct CharacterComicsModel: Decodable{
    let items: [CharacterComicModel?]
}

struct CharacterComicModel: Decodable{
    let resourceURI: String?
    let name: String
}

struct CharacterSeriesModel: Decodable{
    let items: [CharacterSerieModel?]
}

struct CharacterSerieModel: Decodable{
    let resourceURI: String?
    let name: String
}

struct ChracterStoriesModel: Decodable{
    let items: [CharacterStoryModel?]
}

struct CharacterStoryModel: Decodable{
    let resourceURI: String?
    let name: String
}

struct CharacterEventsModel: Decodable{
    let items: [CharacterEventModel?]
}
 
struct CharacterEventModel: Decodable{
    let resurceURI: String?
    let name: String
}
