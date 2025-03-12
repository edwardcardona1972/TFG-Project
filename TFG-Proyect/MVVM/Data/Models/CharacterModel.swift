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
    let description: String
    let thumbnail: ThumbnailModel
}
