//
//  DescripcionPersonajeViewController.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 11/3/25.
//

import UIKit

class DescripcionPersonajeViewController: UIViewController {
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var resourceSelector: UISegmentedControl!
    @IBOutlet weak var goToList: UIButton!
    @IBOutlet weak var descriptionPersonaje: UIStackView!
    @IBOutlet weak var itemListings: UIStackView!
    
    var character: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: (character?.thumbnail.path)!+"."+(character?.thumbnail.extension)!) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Error handling...
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.characterImageView.image = UIImage(data: imageData)
                }
            }.resume()
        }
    }
}
        
