//
//  ViewController.swift
//  budget-iza
//
//  Created by Matej Soroka on 18.05.2021.
//

import UIKit
import CoreData

func MOC() -> NSManagedObjectContext {
    return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

func APP() -> AppDelegate {
    return (UIApplication.shared.delegate as! AppDelegate)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var budgetStatus: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func unwind( _ seg: UIStoryboardSegue) {}
    
    var FRC: NSFetchedResultsController<Transaction>!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FRC.fetchedObjects!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "expense", for:indexPath)
        
        let _transaction = FRC.object(at: indexPath)
        
        cell.textLabel?.text = _transaction.name
        cell.detailTextLabel?.text = String(format: "%.2f €", _transaction.value)
        
        if _transaction.value > 0 {
            cell.detailTextLabel?.textColor = UIColor.systemGreen
        } else {
            cell.detailTextLabel?.textColor = UIColor.systemRed
        }


        return cell
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        default:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        }
        
        
        try! FRC.performFetch()
        
        // Format budget related views
        budgetStatus.text = String(format: "%.2f €", calculateBudget())
        progressBar.progress = Float(calculateRatio())

    }
    
    func calculateBudget() -> Double {
        // Sum of income transactions - sum of spending transactions
        var count = 0.0
        for transaction in FRC.fetchedObjects! {
            count = count + transaction.value
        }
        return count
    }
    
    func calculateRatio() -> Double {
        // Ratio respresents balance between income and spendigns, if 1:1, ratio is 0.5
        // so that slider is balanced
        var count = 0.0
        var count_negative = 0.0

        for transaction in FRC.fetchedObjects! {
            if transaction.value > 0 {
                count = count + transaction.value
            } else {
                count_negative = count_negative + (-transaction.value)
            }
        }
        let ratio = count / count_negative
        return ratio / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let _fr = NSFetchRequest<Transaction>(entityName: "Transaction")
        
        _fr.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]

        FRC = NSFetchedResultsController(fetchRequest: _fr, managedObjectContext: MOC(), sectionNameKeyPath: nil, cacheName: nil)
        
        FRC.delegate = self
        try! FRC.performFetch()
        
        let budget = calculateBudget()
        budgetStatus.text = String(format: "%.2f €", budget)
        let ratio = calculateRatio()
        
        // if ratio is below 0.5, put red warning slider
        // background indicating negative budget
        if ratio < 0.5 {
            progressBar.backgroundColor = UIColor.systemRed
        }
        
        progressBar.progress = Float(ratio)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // create TransitionDetail view with transatction DB object
        
        let _transaction = FRC.object(at: indexPath)
        let _sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let _vc = _sb.instantiateViewController(identifier: "TransactionDetailController") as? TransactionDetailController else {
            abort()
        }
        
        _vc.transaction = _transaction
        
        self.navigationController?.pushViewController(_vc, animated: true)
    }

    
}

