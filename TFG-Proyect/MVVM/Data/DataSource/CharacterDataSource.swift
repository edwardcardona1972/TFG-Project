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
    private static let baseUrl = "https://gateway.marvel.com/v1/public/"
    private static let baseParameters = "?ts=\(timeStamp)&hash=\(hash)&apikey=\(apiKey)"
    
    
    func getCharacters(name: String, completed: @escaping ([CharacterModel]?) -> Void) {
        
        let charactersUrl = "characters"
        let characterParameters = "&nameStartsWith="
        
        let url = URL(string: CharacterDataSource.baseUrl + charactersUrl + CharacterDataSource.baseParameters + characterParameters + name)!
    
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable(of: CharactersBaseResponse.self) { response in
            if let characters = response.value?.data.results {
                print("Correctly")
                completed(characters)
            }else {
                print(response.error?.responseCode ?? "No error")
            }
        }
    }
    
    func getComics(chararcterId: String, completed: @escaping ([ComicModel]?) -> Void){
        let comicsUrl = "comics"
        let comicsParameters = "&characters="
        
        let url = URL(string: CharacterDataSource.baseUrl + comicsUrl + CharacterDataSource.baseParameters + comicsParameters + chararcterId)!
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable(of: ComicBaseResponse.self) { response in
            if let comics = response.value?.data.results {
                print("Correctly")
                completed(comics)
            }else {
                print(response.error?.responseCode ?? "No error")
            }
        }
    }
    func getStories(chararcterId: String, completed: @escaping ([StoryModel]?) -> Void){
        let storyesUrl = "storyes"
        let storiesParameters = "&characters="
        
        let url = URL(string: CharacterDataSource.baseUrl + storyesUrl + CharacterDataSource.baseParameters + storiesParameters + chararcterId)
        
        AF.request(url!, method: .get).validate(statusCode: kStatusOk).responseDecodable(of: StoryesBaseResponse.self) { response in
            if let Storyes = response.value?.data.results {
                print("Correctly")
                completed(Storyes)
            }else {
                print(response.error?.responseCode ?? "No error")
            }
        }
    }
    func getEvents(chararcterId: String, completed: @escaping ([EventsModel]?) -> Void){
        let eventsUrl = "events"
        let eventsParameters = "&characters="
        
        let url = URL(string: CharacterDataSource.baseUrl + eventsUrl + CharacterDataSource.baseParameters + eventsParameters + chararcterId)
        
        AF.request(url!, method: .get).validate(statusCode: kStatusOk).responseDecodable(of: EventsBaseResponse.self) { response in
            if let Events = response.value?.data.results {
                print("Correctly")
                completed(Events)
            }else {
                print(response.error?.responseCode ?? "No error")
            }
        }
    }
    func getSeries(chararcterId: String, completed: @escaping ([SeriesModel]?) -> Void){
        let seriesUrl = "series"
        let seriesParameters = "&characters="
        
        let url = URL(string: CharacterDataSource.baseUrl + seriesUrl + CharacterDataSource.baseParameters + seriesParameters + chararcterId)
        
        AF.request(url!, method: .get).validate(statusCode: kStatusOk).responseDecodable(of: SeriesBaseResponse.self) { response in
            if let Series = response.value?.data.results {
                print("Correctly")
                completed(Series)
            }else {
                print(response.error?.responseCode ?? "No error")
            }
        }
    }
}
