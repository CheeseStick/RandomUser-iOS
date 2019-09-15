//
//  TV_UserCell.swift
//  RandomUser
//
//  Created by Jun Jung on 9/15/19.
//  Copyright © 2019 JunJung. All rights reserved.
//

import UIKit

class TV_UserCell: UITableViewCell {

    @IBOutlet var profileImageV: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(user : User) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        // Reset Profile picture (Prevent showing up prev profile image when loading)
        self.profileImageV.image = UIImage(named: "img_user_profile_blank")
        
        // Make profile picture circle
        self.profileImageV.layer.cornerRadius = self.profileImageV.frame.width / 2.0
        self.profileImageV.layer.masksToBounds = true
        
        // Set text data
        self.nameLabel.text = "\(user.name.first.makeFirstCharUpper()) \(user.name.last.makeFirstCharUpper())"
        self.infoLabel.text = "\(user.gender.rawValue.lowercased().makeFirstCharUpper()) (\(user.dob.age)) \(formatter.string(from: user.dob.birthDate))"
        
        // And set image
        ImageManager.shared.requestImage(url: user.profilePic.thumbnail) { (image) in
            self.profileImageV.image = image
        }
    }
}
