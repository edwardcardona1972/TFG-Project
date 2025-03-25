//
//  BuscardorViewModel.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 9/3/25.
//

import Foundation
import Combine
class BuscadorViewModel: ObservableObject {

    var characters: [CharacterModel] = []
    var reloadData = PassthroughSubject<Void, Error>()
    var searchValue: String = "A"
    var networkError: NetworError?
    private let service = CharacterDataSource()
    
    func fetchCharacters(){
        service.getCharacters(name: searchValue){ listOfCharacters, error in
            self.characters = listOfCharacters ?? []
            self.reloadData.send(())
            self.networkError = error
            return
        }
    }
}
