//
//  MuseumCell.swift
//  Pocket_Museum
//
//  Created by Emmanuel Desprez on 23/02/2017.
//  Copyright © 2017 Emmanuel Desprez. All rights reserved.
//

import Foundation
import UIKit

class MuseumCell: UITableViewCell {
    
       @IBOutlet weak var museumNameLabel: UILabel!
    
    func display(museum:Museum) {
        museumNameLabel.text = museum.museumName
    }

    
}
