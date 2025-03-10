//
//  BuscadorViewController.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 9/3/25.
//

import UIKit
import Combine

class BuscadorViewController: UIViewController{
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var tv: UITableView!
    
    var viewModel = BuscadorViewModel() //UserViewModel()
    var anyCancellable : [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptions()
        viewModel.fetchCharacters()
        
        mySearchBar.delegate = self

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
        let user = viewModel.characters[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = user.name
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
