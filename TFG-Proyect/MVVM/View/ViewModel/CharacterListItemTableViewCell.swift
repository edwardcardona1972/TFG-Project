//
//  CharacterListItemTableViewCell.swift
//  TFG-Proyect
//
//  Created by Eduard Alexis Cardona Grajales on 10/3/25.
//

import UIKit

class CharacterListItemTableViewCell: UITableViewCell {

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
