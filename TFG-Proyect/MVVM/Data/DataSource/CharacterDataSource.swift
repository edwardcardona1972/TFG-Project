//
//  CharacterDataSource.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 9/3/25.
//

import Foundation
import Alamofire
import Combine
import CommonCrypto


class CharacterDataSource: NSObject, ObservableObject {
    static let shared = CharacterDataSource()
    
    private let kStatusOk = 200...299
    private static let publicKey = Bundle.main.infoDictionary?["API_KEY"] as! String
    private static let privateApiKey = Bundle.main.infoDictionary?["PRIVATE_API_KEY"] as! String
    private static let baseUrl = "https://gateway.marvel.com/v1/public/"
    
    
    func getCharacters(name: String, completed: @escaping ([CharacterModel]?, NetworError?) -> Void) {
        
        let charactersUrl = "characters"
        let characterParameters = "&nameStartsWith="
        
        let url = URL(string: CharacterDataSource.baseUrl + charactersUrl + getBaseParameters() + characterParameters + name)!
        print(url.absoluteString)
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable(of: CharactersBaseResponse.self) { response in
            
            if let characters = response.value?.data.results {
                print("Correctly")
                completed(characters, nil)
            }else {
                completed([],NetworError(rawValue: ""))
                print(response.error?.responseCode ?? "No error")
            }
        }
    }
  
    func getComics(chararcterId: String, completed: @escaping ([ComicModel]?) -> Void){
        let comicsUrl = "comics"
        let comicsParameters = "&characters="
        
        let url = URL(string: CharacterDataSource.baseUrl + comicsUrl + getBaseParameters() + comicsParameters + chararcterId)!
        
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
        
        let url = URL(string: CharacterDataSource.baseUrl + storyesUrl + getBaseParameters() + storiesParameters + chararcterId)
        
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
        
        let url = URL(string: CharacterDataSource.baseUrl + eventsUrl + getBaseParameters() + eventsParameters + chararcterId)
        
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
        
        let url = URL(string: CharacterDataSource.baseUrl + seriesUrl + getBaseParameters() + seriesParameters + chararcterId)
        
        AF.request(url!, method: .get).validate(statusCode: kStatusOk).responseDecodable(of: SeriesBaseResponse.self) { response in
            if let Series = response.value?.data.results {
                print("Correctly")
                completed(Series)
            }else {
                print(response.error?.responseCode ?? "No error")
            }
        }
    }
    
   private func getBaseParameters() -> String{
        let timeStamp = getTimeStamp()
        let hashValue = getHash(timeStamp: timeStamp)
        return "?ts=\(timeStamp)&apikey=\(CharacterDataSource.publicKey)&hash=\(hashValue)"
    }
    
    private func getHash(timeStamp: String) -> String{
        let preHash = timeStamp + CharacterDataSource.privateApiKey + CharacterDataSource.publicKey
        return toMD5(preHash)
    }
    
    private func getTimeStamp() -> String{
        let timestamp = NSDate().timeIntervalSince1970
        return String(format: "%.0f", timestamp)
    }
    
    private func toMD5(_ string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using: .utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory.assumingMemoryBound(to: UInt8.self))
                }
                return 0 // irrelevant return value
            }
        }

        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}

