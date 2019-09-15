//
//  VC_SetFilter.swift
//  RandomUser
//
//  Created by Jun Jung on 9/16/19.
//  Copyright © 2019 JunJung. All rights reserved.
//

import UIKit

class VC_SetFilter: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var supportedCountries : [String] = [String]()
    var selectedCountries : [String] = [String]()
    
    var applyFilter : (()->Void)?
    
    @IBOutlet var genderSelectSegCtrl: UISegmentedControl!
    @IBOutlet var nationalitiesFilterSwitch: UISwitch!
    @IBOutlet var countryListTableV: UITableView!
    
    // MARK: - ViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        supportedCountries = APIManager.shared.getSupportedNationalities()
        selectedCountries.append(contentsOf: supportedCountries)

        countryListTableV.dataSource = self
        countryListTableV.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        applyFilter!()
    }
    
    // MARK: - TableView Data Sources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supportedCountries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! TV_CountryCell
        
        // cell.countryNameLabel.text = Locale.current.localizedString(forLanguageCode: supportedCountries[indexPath.row])
        cell.countryNameLabel.text = supportedCountries[indexPath.row]
        cell.checkedLabel.isHidden = !selectedCountries.contains(supportedCountries[indexPath.row])
        
        return cell
    }
    
    // MARK: - TableView Delegates
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (selectedCountries.contains(supportedCountries[indexPath.row])) {
            selectedCountries.remove(at: selectedCountries.firstIndex(of: supportedCountries[indexPath.row])!)
        } else {
            selectedCountries.append(supportedCountries[indexPath.row])
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    // MARK: - Button Actions
    @IBAction func countrySwichValueChanged(_ sender: UISwitch) {
        if(sender.isOn) {
            APIManager.shared.setNationalitiesFilter(nationalities: [])
            countryListTableV.isHidden = true
        } else {
            APIManager.shared.setNationalitiesFilter(nationalities: selectedCountries)
            countryListTableV.isHidden = false
        }
    }
    
    @IBAction func genderSegCtrlValueChanged(_ sender: UISegmentedControl) {
        var selected = Gender.other
        
        if(sender.selectedSegmentIndex == 1) {
            selected = Gender.male
        }
        else if (sender.selectedSegmentIndex == 2) {
            selected = Gender.female
        }
        
        APIManager.shared.setGenderFilter(gender: selected)
    }
}
