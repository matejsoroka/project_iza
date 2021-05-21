//
//  AddSpendingController.swift
//  budget-iza
//
//  Created by Matej Soroka on 18.05.2021.
//

import UIKit

class AddSpendingController: UIViewController {

    @IBOutlet weak var spendingSlider: UISlider!
    @IBOutlet weak var spendingField: UITextField!
    @IBOutlet weak var spendingName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spendingField.text = String(format: "%.2f", spendingSlider.value * 1000)
    }
    
    @IBAction func addSpending() {
        guard let name = spendingName.text else { return }
        
        // spendings are with negative sign
        
        let value = -(Double(spendingField.text!)!)
        
        _ = Transaction.addNewTransaction(name: name, value: value, date: Date(), MOC: MOC())
        
        try! MOC().save()
        
        // go to home view and delete view stack
        performSegue(withIdentifier: "goHome", sender: self)
        
    }
    
    
    @IBAction func spendingSliderChange(_ sender: Any) {
        spendingField.text = String(format: "%.2f", spendingSlider.value * 1000)
    }
    

}
