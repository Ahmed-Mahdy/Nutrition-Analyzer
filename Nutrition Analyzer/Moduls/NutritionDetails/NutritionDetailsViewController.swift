//
//  NutritionDetailsViewController.swift
//  Nutrition Analyzer
//
//  Created by Ahmed Mahdy on 11/07/2021.
//

import UIKit

class NutritionDetailsViewController: UIViewController {

    @IBOutlet weak var detailsStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
 
    var model: IngredientModel!
    var type: NutritionDetailsType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        switch type {
        case .Recipe:
            recipeDetailsLayout()
            break
        case .Ingredient:
            ingredientDetailsLayout()
            break
        case .none:
           break
        }
    }

    @IBAction func backAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    private func ingredientDetailsLayout() {
        titleLabel.text = model.title
        if let view = DetailsView.loadFromNib(named: "DetailsView") as? DetailsView {
            view.configure(with: "Quantity", value: "\(model.quantity)")
            detailsStackView.addArrangedSubview(view)
        }
        if let view = DetailsView.loadFromNib(named: "DetailsView") as? DetailsView {
            view.configure(with: "Unit", value: model.unit)
            detailsStackView.addArrangedSubview(view)
        }
        if let view = DetailsView.loadFromNib(named: "DetailsView") as? DetailsView {
            view.configure(with: "Calories", value:"\(model.response?.calories ?? 0)")
            detailsStackView.addArrangedSubview(view)
        }
        if let view = DetailsView.loadFromNib(named: "DetailsView") as? DetailsView {
            view.configure(with: "Weight", value: "\(model.response?.totalWeight ?? 0.0)")
            detailsStackView.addArrangedSubview(view)
        }
    }
    
    private func recipeDetailsLayout() {
        titleLabel.text = model.title

        if let view = DetailsView.loadFromNib(named: "DetailsView") as? DetailsView {
            view.configure(with: "Calories", value:"\(model.response?.calories ?? 0)")
            detailsStackView.addArrangedSubview(view)
        }
        if let view = DetailsView.loadFromNib(named: "DetailsView") as? DetailsView {
            view.configure(with: "Weight", value: "\(model.response?.totalWeight ?? 0.0)")
            detailsStackView.addArrangedSubview(view)
        }

        if let view = DetailsView.loadFromNib(named: "DetailsView") as? DetailsView , let model = model.response?.totalNutrientsKCal?.chocdfKcal {
            view.configure(with: model.label , value: "\( model.quantity )")
            detailsStackView.addArrangedSubview(view)
        }

        if let view = DetailsView.loadFromNib(named: "DetailsView") as? DetailsView , let model = model.response?.totalNutrientsKCal?.enercKcal {
            view.configure(with: model.label, value: "\( model.quantity)")
            detailsStackView.addArrangedSubview(view)
        }

        if let view = DetailsView.loadFromNib(named: "DetailsView") as? DetailsView , let model = model.response?.totalNutrientsKCal?.fatKcal {
            view.configure(with: model.label, value: "\( model.quantity)")
            detailsStackView.addArrangedSubview(view)
        }

        if let view = DetailsView.loadFromNib(named: "DetailsView") as? DetailsView , let model = model.response?.totalNutrientsKCal?.procntKcal {
            view.configure(with: model.label, value: "\( model.quantity)")
            detailsStackView.addArrangedSubview(view)
        }
    }

}
