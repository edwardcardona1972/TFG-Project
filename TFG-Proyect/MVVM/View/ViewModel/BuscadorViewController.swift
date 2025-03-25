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
   
    var viewModel = BuscadorViewModel()
    var anyCancellable : [AnyCancellable] = []
    var characterSelected : CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptions()
        viewModel.fetchCharacters()
        mySearchBar.delegate = self
        
        tv.register(UINib(nibName: "CharacterListItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterListItemTableViewCell")
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        if(viewModel.networkError != nil){
            networkError(_error: viewModel.networkError?.rawValue ?? "error", callbarck: nil)
        }
    }
    
    func subscriptions(){
        viewModel.reloadData.sink { _ in} receiveValue: { _ in
            self.tv.reloadData()
        }.store(in: &anyCancellable)
    }
    
    // MARK: - Navegar a otra pantalla
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "characterView" {
            let vc = segue.destination as! DescripcionPersonajeViewController
            vc.character = characterSelected
        }
    }
    
    func networkError(_error : String, callbarck : (()->Void)?){
        let alert = UIAlertController(title: "Error", message: "No se encontraron personajes", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: {action in
            if let callbarck = callbarck{
                callbarck()
            }
            print("retry button pressed")
        }))
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            if action.style == .cancel{
                print("ok button pressed")
            }
        }))
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        characterSelected = viewModel.characters[indexPath.row]
        performSegue(withIdentifier: "characterView", sender: self)
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
