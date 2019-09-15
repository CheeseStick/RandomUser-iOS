//
//  TV_CountryCell.swift
//  RandomUser
//
//  Created by Jun Jung on 9/16/19.
//  Copyright © 2019 JunJung. All rights reserved.
//

import UIKit

class TV_CountryCell: UITableViewCell {

    @IBOutlet var countryNameLabel: UILabel!
    @IBOutlet var checkedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
