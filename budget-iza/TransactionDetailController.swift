//
//  TransactionDetailController.swift
//  budget-iza
//
//  Created by Matej Soroka on 20.05.2021.
//

import UIKit

class TransactionDetailController: UITableViewController {

    @IBOutlet weak var datepicker: UIDatePicker!
    
    var transaction: Transaction!
    var nameCell: UITableViewCell!
    var valueCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datepicker.setDate(transaction.date!, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    @IBAction func changeDate(_ sender: Any) {
        transaction.setValue(datepicker.date, forKey: "date")
        try! MOC().save()
        APP().saveContext()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let _cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell") as? TransactionDetailCell else {
            abort()
        }
        
        if (indexPath.row == 0) {
            _cell.title.text = "Name"
            _cell.value?.text = transaction.name
        }

        if (indexPath.row == 1) {
            _cell.title?.text = "Value"
            _cell.value?.text = String(format: "%.2f", transaction.value)
            valueCell = _cell
        }
        
        // update values in DB and views on cell change
        _cell.delegate = { cont in
            if cont[0] == "Name" {
                self.transaction.name = cont[1]
            }
            if cont[0] == "Value" {
                self.transaction.value = Double(cont[1])!
            }
            try! MOC().save()
            APP().saveContext()
        }
        
        return _cell
        
    }
    
    
    
    @IBAction func deleteTransactionButton(_ sender: Any) {
        
        // delete transaction with alert modal

        let alert = UIAlertController(title: "Transaction delete", message: "Are you sure you want to delete this?", preferredStyle: .alert)
        
        // if agreed to delete
        alert.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: "Forward action"), style: .destructive, handler: { _ in
            MOC().delete(self.transaction)
            try! MOC().save()

            // go to home view and delete view stack
            self.performSegue(withIdentifier: "goHome", sender: "self.")
        }))
        
        // if canceled
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel action"), style: .default, handler: { _ in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
