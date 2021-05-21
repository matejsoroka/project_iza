//
//  Settings.swift
//  budget-iza
//
//  Created by Matej Soroka on 18.05.2021.
//

import Foundation
import UIKit
import CoreData

//func MOC() -> NSManagedObjectContext {
//    return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//}
//
//func APP() -> AppDelegate {
//    return (UIApplication.shared.delegate as! AppDelegate)
//}

class TransactionCategoryController : UICollectionViewController {

    var dataSource: [String] = ["Foo", "Bar"]
//    var FRC: NSFetchedResultsController<Category>!

    override func viewDidLoad() {
        super.viewDidLoad()
//        let _fr = NSFetchRequest<Category>(entityName: "Category")
//        try! FRC.performFetch()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()

        if let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CategoryCell {
            
            categoryCell.configure(with: dataSource[indexPath.row])
            cell = categoryCell

        }

        return cell
    }
    
}
