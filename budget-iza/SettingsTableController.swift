//
//  Settings.swift
//  budget-iza
//
//  Created by Matej Soroka on 18.05.2021.
//

import Foundation
import UIKit

class SettingsVC : UITableViewController {
    
    var optionList = [("App version", "1.0.0"), ("Author", "Matej Soroka")]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for:indexPath)
        
        cell.textLabel?.text = optionList[indexPath.row].0
        cell.detailTextLabel?.text = optionList[indexPath.row].1
        return cell
    }
    
}
