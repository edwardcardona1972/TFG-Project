//
//  BuscadorViewController.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 9/3/25.
//

import UIKit
import Combine

class BuscadorViewController: UIViewController {
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var tv: UITableView!
    
    @IBOutlet weak var personajeView: UITableView!
    
    var viewModel = BuscadorViewModel()
    var anyCancellable : [AnyCancellable] = []
    var character : Character?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptions()
        viewModel.fetchCharacters()
        mySearchBar.delegate = self
               
        tv.register(UINib(nibName: "CharacterListItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterListItemTableViewCell")

        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.translatesAutoresizingMaskIntoConstraints = false
    }
    func subscriptions(){
        viewModel.reloadData.sink { _ in} receiveValue: { _ in
            self.tv.reloadData()
        }.store(in: &anyCancellable)
    }
    
}

extension BuscadorViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = viewModel.characters[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterListItemTableViewCell", for: indexPath) as! CharacterListItemTableViewCell
        cell.characterName.text = character.name
        cell.characterDescription.text = character.description
        
        
        
        if let url = URL(string: character.thumbnail.path+"."+character.thumbnail.extension) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Error handling...
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    cell.characterImage.image = UIImage(data: imageData)
                }
            }.resume()
        }
        return cell
        
        
        
        
    }
}
    
    extension BuscadorViewController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            viewModel.searchValue = searchBar.text ?? ""
            viewModel.fetchCharacters()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            viewModel.searchValue = ""
            searchBar.endEditing(true)
        }
        
    }

