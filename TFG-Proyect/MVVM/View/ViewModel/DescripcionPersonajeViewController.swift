//
//  DescripcionPersonajeViewController.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 11/3/25.
//

import UIKit

class DescripcionPersonajeViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var resourceSelector: UISegmentedControl!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    
    var character: CharacterModel?

    let listType: [String] = ["Cómics", "Historias", "Eventos", "Series"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tv.delegate = self
        tv.dataSource = self
        if let url = URL(string: (character?.thumbnail.path)!+"."+(character?.thumbnail.extension)!) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Error handling...
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
        print("Gracias hijo por tu paciencia con el ser que tanto te ama")
    }
}

extension DescripcionPersonajeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.character?.comics?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personaje = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        personaje.textLabel?.text = character?.comics?.items[indexPath.row]?.name
        personaje.detailTextLabel?.text = character?.comics?.items[indexPath.row]?.resourceURI
        return personaje
    }
}
