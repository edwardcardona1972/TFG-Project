//
//  DescripcionPersonajeViewController.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 11/3/25.
//

import UIKit

class DescripcionPersonajeViewController: UIViewController {

    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var character: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // transform int to string
        // vista con imagen, descripción y listado con comics, historias, eventos y series.
        descriptionLabel.text = character?.description
        
        
    }
}
