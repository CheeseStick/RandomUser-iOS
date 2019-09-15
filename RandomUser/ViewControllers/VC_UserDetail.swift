//
//  VC_UserDetail.swift
//  RandomUser
//
//  Created by Jun Jung on 9/16/19.
//  Copyright © 2019 JunJung. All rights reserved.
//

import UIKit
import MapKit

class VC_UserDetail: UIViewController {
    var user : User?
    
    @IBOutlet var profileImageV: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    @IBOutlet var locationMapV: MKMapView!
    
    @IBOutlet var mailLabel: UILabel!
    @IBOutlet var phoneNoLabel: UILabel!
    @IBOutlet var mobileNoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(user!.name.first.makeFirstCharUpper()) \(user!.name.last.makeFirstCharUpper())"
        
        // Thumbnail image
        ImageManager.shared.requestImage(url: user!.profilePic.original) { (image) in
            self.profileImageV.image = image
        }
        
        profileImageV.layer.cornerRadius = self.profileImageV.frame.width / 2.0
        profileImageV.layer.masksToBounds = true
        
        // Set date format
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        // fetch data
        nameLabel.text = self.title
        locationLabel.text = "\(user!.location.city), \(user!.location.state)"
        detailLabel.text = "\(user!.gender.rawValue.lowercased().makeFirstCharUpper()) (\(user!.dob.age)) \(formatter.string(from: user!.dob.birthDate))"
        
        phoneNoLabel.text = user!.phoneNo
        mobileNoLabel.text = user!.cellNo
        mailLabel.text = user!.email
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Show pin on map
        let homeLoc = MKPointAnnotation()
        homeLoc.coordinate = CLLocationCoordinate2DMake(user!.location.coordinates.lat, user!.location.coordinates.lon)
        homeLoc.title = "Home"
        locationMapV.setCenter(homeLoc.coordinate, animated: true)
        locationMapV.showAnnotations([homeLoc,], animated: true)
    }
}
