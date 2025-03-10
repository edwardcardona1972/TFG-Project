//
//  UserModel.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 5/3/25.
//

import Foundation
import Alamofire

final class MarvelProvider {
    static let shared = MarvelProvider()
    
    private let md5 = "5fb4d927a8cb3c4acb3026981f37651b"
    private let kBaseUrl = "https://gateway.marvel.com/v1/public/comics?"
    private let apikey = "2dd73675a0935d5124da60e9fe89d9de"
    private let kStatusOk = 200...299
    private let timeStamp = 80

    
    func getComics(){
        
        let url = "\(kBaseUrl)limit=10&ts=\(timeStamp)&apikey=\(apikey)&hash=\(md5)"
        print(url)
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable(of: ComicData.self) { response in
    
            if let comics = response.value?.data.results {
                comics.forEach { comics in
                    print(comics)
                }
            }else {
                print(response.error?.responseCode ?? "No error")
            }
                     
        }
        
    }
}
