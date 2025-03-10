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
    
    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    var viewModel = BuscadorViewModel() //UserViewModel()
    var anyCancellable : [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptions()
        configTableView()
        viewModel.fetchCharacters()
   
    }
    func subscriptions(){
        viewModel.reloadData.sink { _ in} receiveValue: { _ in
            self.tableView.reloadData()
        }.store(in: &anyCancellable)
    }
    
    private func configTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.widthAnchor.constraint(equalToConstant: view.frame.width),
            tableView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
    }
}
  extension BuscadorViewController: UISearchBarDelegate {
        func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
            mySearchBar.resignFirstResponder()
            return
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
   /*extension BuscadorViewController: UISearchResultsUpdating {
        func updateSearchResults(for searchController: UISearchController) {
            viewModel.searchValue = searchController.searchBar.text ?? ""
            viewModel.fetchCharacters()
        }
    }*/


