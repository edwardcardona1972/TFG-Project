//
//  ViewController.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 5/3/25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func getAction(_ sender: Any) {
        MarvelProvider.shared.getComics()
    }

}



