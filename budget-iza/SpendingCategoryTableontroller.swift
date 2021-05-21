//
//  CategoryTableControllerTableViewController.swift
//  budget-iza
//
//  Created by Matej Soroka on 20.05.2021.
//

import UIKit

class CategoryTableController: UITableViewController {
    
    var categoryList = ["Category1", "Category2"]
    
    override func viewDidLoad() {
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for:indexPath)
        
        cell.textLabel?.text = categoryList[indexPath.row]
        return cell
    }

}
