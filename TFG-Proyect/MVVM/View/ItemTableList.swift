//
//  ItemTableList.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 14/3/25.
//

import UIKit

class ItemTableList: UIViewController {
  
    @IBOutlet weak var itemTable: UITableView!
    
    var numeroDeFilas: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTable.delegate = self
        itemTable.dataSource = self
    }
}
extension ItemTableList: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numeroDeFilas
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellItemList", for: indexPath)
        cell.textLabel?.text = "Item \(indexPath.row)"
        cell.detailTextLabel?.text = "Detalle Item \(indexPath.row)"
        return cell
    }
}
