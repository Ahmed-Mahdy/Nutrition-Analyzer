//
//  IngredientTableViewCell.swift
//  Nutrition Analyzer
//
//  Created by Ahmed Mahdy on 10/07/2021.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientTitle: UILabel!
    
    func configure(with ingredient:String) {
        ingredientTitle.text = ingredient
    }

}
