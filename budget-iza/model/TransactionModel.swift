//
//  TransactionModel.swift
//  budget-iza
//
//  Created by Matej Soroka on 20.05.2021.
//

import Foundation
import CoreData

extension Transaction {
    
    static func addNewTransaction(name: String, value: Double, date: Date, MOC: NSManagedObjectContext) -> Transaction {
        
        let _tr = Transaction(context: MOC)
        _tr.name = name
        _tr.value = value
        _tr.date = date
        return _tr
    }

}
