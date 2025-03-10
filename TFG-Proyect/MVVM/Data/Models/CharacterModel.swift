//
//  CharacterModel.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 9/3/25.
//

/*
 {
     "code": 200,
     "status": "Ok",
     "copyright": "© 2025 MARVEL",
     "attributionText": "Data provided by Marvel. © 2025 MARVEL",
     "attributionHTML": "<a href=\"http://marvel.com\">Data provided by Marvel. © 2025 MARVEL</a>",
     "etag": "567894581b2b0fb3559bf2d2ad146bc86e81c58d",
     "data": {
         "offset": 0,
         "limit": 20,
         "total": 201,
         "count": 20,
         "results": [
             {
                 "id": 1009552,
                 "name": "S.H.I.E.L.D.",
                 "description": "",
                 "modified": "2017-05-04T14:41:42-0400",
                 "thumbnail": {
                     "path": "http://i.annihil.us/u/prod/marvel/i/mg/6/20/51097abb8e306",
                     "extension": "jpg"
                 },
                 "resourceURI": "http://gateway.marvel.com/v1/public/characters/1009552",
                 "comics": {
                     "available": 178,
 */

struct BaseResponse: Decodable{
    let code: Int
    let status: String
    let data: DataResponse
}

struct DataResponse: Decodable{
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
    let thumbnail: Thumbnail
}

struct Thumbnail: Decodable{
    let path: String
    let `extension`: String
}
