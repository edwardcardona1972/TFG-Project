//
//  BuscardorViewModel.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 9/3/25.
//

import Foundation
class BuscadorViewModel: ObservableObject {

    @Published var characters: [CharacterModel] = []
    var searchValue: String = ""
    
    private let service = CharacterDataSource()
    
    func fetchCharacters(){
        service.getCharacters(name: searchValue){ characters in
            if (characters != nil){
                self.characters = characters!
            }
        }
    }
    
}
