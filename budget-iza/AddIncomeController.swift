//
//  AddSpendingController.swift
//  budget-iza
//
//  Created by Matej Soroka on 18.05.2021.
//

import UIKit

class AddIncomeController: UIViewController {

    @IBOutlet weak var incomeFieldName: UITextField!
    @IBOutlet weak var incomeFieldValue: UITextField!
    @IBOutlet weak var incomeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        incomeFieldValue.text = String(format: "%.2f", incomeSlider.value * 1000)
    }
    
    @IBAction func addIncome() {
        guard let name = incomeFieldName.text else { return }
        
        let value = Double(incomeFieldValue.text!)
        
        _ = Transaction.addNewTransaction(name: name, value: value!, date: Date(), MOC: MOC())
        
        try! MOC().save()
        
        // go to home view and delete view stack
        performSegue(withIdentifier: "goHome", sender: self)
        
    }
    
    @IBAction func updateValue(_ sender: Any) {
        incomeFieldValue.text = String(format: "%.2f", incomeSlider.value * 1000)
    }
    


}
