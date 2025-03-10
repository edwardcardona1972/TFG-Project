//
//  BuscadorViewController.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 9/3/25.
//

import UIKit

class BuscadorViewController: UIViewController {
    
    
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = BuscadorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mySearchBar.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
       
        
    }
}
           extension BuscadorViewController: UISearchBarDelegate {
               func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
                   mySearchBar.resignFirstResponder()
                   
    }
}
    
// MARK: - UITableViewDAtaSource

extension BuscadorViewController: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       cell.textLabel?.text = viewModel.characters[indexPath.row].name
       return cell
   }
    
    
}


extension BuscadorViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchValue = searchController.searchBar.text ?? ""
        viewModel.fetchCharacters()
    }
}
