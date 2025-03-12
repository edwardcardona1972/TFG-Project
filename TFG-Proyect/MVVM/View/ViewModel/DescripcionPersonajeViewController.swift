//
//  DescripcionPersonajeViewController.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 11/3/25.
//

import UIKit

class DescripcionPersonajeViewController: UIViewController {

    @IBOutlet weak var DescripcionLabel: UILabel!
    
    
    var personaje: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DescripcionLabel.text = personaje ?? ""
       
    }
    

    
}
