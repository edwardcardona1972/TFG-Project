//
//  DescripcionPersonajeViewController.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 11/3/25.
//
import UIKit
protocol BuscadorViewControllerDelegate: AnyObject, ObservableObject {
    func showError(_error : String, callbarck : (()->Void)?)
}
class DescripcionPersonajeViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var resourceSelector: UISegmentedControl!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    
    var character: CharacterModel?
    let listType: [String] = ["Cómics", "Historias", "Eventos", "Series"]
    var selectedTypeIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tv.delegate = self
        tv.dataSource = self
        if let url = URL(string: (character?.thumbnail.path)!+"."+(character?.thumbnail.extension)!) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let imageData = data else { return }
                DispatchQueue.main.async {
                    self.characterImage.image = UIImage(data: imageData)
                }
            }.resume()
        }
        //segmentedControl
        for (index, value) in listType.enumerated() {
            mySegmentedControl.setTitle(value, forSegmentAt: index)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemListView" {
            let viewController = segue.destination as! ItemTableList
            viewController.numeroDeFilas = 5
        }
    }
    
    // MARK: - Action
    @IBAction func ButtonGoList(_ sender: Any) {
        performSegue(withIdentifier: "itemListView", sender: nil)
    }
    @IBAction func mySegmentControlAction(_ sender: Any) {
        
        selectedTypeIndex = mySegmentedControl.selectedSegmentIndex
        tv.reloadData()
    }
}

extension DescripcionPersonajeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedTypeIndex {
        case 1 :
            return character?.stories?.items.count ?? 0
        case 2 :
            return character?.events?.items.count ?? 0
        case 3 :
            return character?.series?.items.count ?? 0
        default:
            return character?.comics?.items.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personaje = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        
        switch selectedTypeIndex {
        case 1 :
            personaje.textLabel?.text = character?.stories?.items[indexPath.row]?.name
            personaje.detailTextLabel?.text = character?.stories?.items[indexPath.row]?.resourceURI
        case 2 :
            personaje.textLabel?.text = character?.events?.items[indexPath.row]?.name
            personaje.detailTextLabel?.text = character?.events?.items[indexPath.row]?.resourceURI
        case 3 :
            personaje.textLabel?.text = character?.series?.items[indexPath.row]?.name
            personaje.detailTextLabel?.text = character?.series?.items[indexPath.row]?.resourceURI
        default:
            personaje.textLabel?.text = character?.comics?.items[indexPath.row]?.name
            personaje.detailTextLabel?.text = character?.comics?.items[indexPath.row]?.resourceURI
        }
        return personaje
    }
}
