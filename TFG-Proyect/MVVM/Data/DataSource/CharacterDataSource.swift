//
//  CharacterDataSource.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 9/3/25.
//

import Foundation
import Alamofire
import Combine

class CharacterDataSource: NSObject, ObservableObject {
    static let shared = CharacterDataSource()

    
    private let kStatusOk = 200...299
    private static let hash = "5fb4d927a8cb3c4acb3026981f37651b"
    private static let timeStamp = 80
    private static let apiKey = Bundle.main.infoDictionary?["API_KEY"] as! String
    static let baseUrl =  "https://gateway.marvel.com/v1/public/characters?apikey=\(apiKey)&ts=\(timeStamp)&hash=\(hash)&nameStartsWith="
    
    func getCharacters(name: String, completed: @escaping ([CharacterModel]?) -> Void) {
        let url = URL(string: CharacterDataSource.baseUrl + name)!
    
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable(of: BaseResponse.self) { response in
            if let characters = response.value?.data.results {
                print("Correctly")
                completed(characters)
            }else {
                print(response.error?.responseCode ?? "No error")
            }
                     
        }
    }
    
}
