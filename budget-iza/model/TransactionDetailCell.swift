//
//  TransactionDetailCell.swift
//  budget-iza
//
//  Created by Matej Soroka on 21.05.2021.
//

import Foundation
import UIKit

class TransactionDetailCell: UITableViewCell {
    
    var delegate: (([String]) -> ())?
    
    @IBOutlet weak var value: UITextField!
    @IBOutlet weak var title: UILabel!

    
    @IBAction func textChange(_ sender: Any) {
        delegate?([title.text ?? "empty", value.text ?? "value"])
    }
    
}
