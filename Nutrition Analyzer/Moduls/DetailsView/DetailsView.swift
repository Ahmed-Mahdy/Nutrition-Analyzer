//
//  DetailsView.swift
//  Nutrition Analyzer
//
//  Created by Ahmed Mahdy on 11/07/2021.
//

import UIKit

class DetailsView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func configure(with title:String, value:String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}
