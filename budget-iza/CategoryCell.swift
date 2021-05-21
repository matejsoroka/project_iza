//
//  CategoryCell.swift
//  budget-iza
//
//  Created by Matej Soroka on 20.05.2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {


    @IBOutlet weak var cellLabel: UILabel!
    
    func configure(with name: String) {
        cellLabel?.text = name
    }
    
}
