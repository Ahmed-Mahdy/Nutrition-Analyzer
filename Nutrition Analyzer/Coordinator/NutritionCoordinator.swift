//
//  NutritionCoordinator.swift
//  Nutrition Analyzer
//
//  Created by Ahmed Mahdy on 10/07/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import FittedSheets

class NutritionCoordinator: BaseCoordinator {
    
    enum Destination {
        case openDetails(model: IngredientModel, type: NutritionDetailsType)
        case AddRecipe(recipeString: BehaviorRelay<String>)
        case AddIngredient(bindable: BehaviorRelay<IngredientModel>)
    }
    
    var rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .openDetails(let model , let type):
            return openDetails(model: model, type: type)
        case .AddRecipe(let recipeString):
            return AddRecipe(recipeString: recipeString)
        case .AddIngredient(let bindable):
            return AddIngredient(bindable: bindable)
        }
    }
    func navigate(to destination: NutritionCoordinator.Destination) {
        let viewController = makeViewController(for: destination)
        rootViewController.show(viewController, sender: rootViewController)
    }
    
    func present(to destination: NutritionCoordinator.Destination) {
        let viewController = makeViewController(for: destination)
        rootViewController.present(viewController, animated: true)
    }
    
}
private extension NutritionCoordinator {
    func AddRecipe(recipeString: BehaviorRelay<String>) -> UIViewController {
        guard let viewController = AddReciepeViewController.instantiateFromNib() else { return UIViewController() }
        viewController.recipeString = recipeString
        let sheet = SheetViewController(controller: viewController, sizes: [.fixed(400), .fixed(400)])
        
        return sheet
    }
    func AddIngredient(bindable: BehaviorRelay<IngredientModel>) -> UIViewController {
        guard let viewController = AddIngredientViewController.instantiateFromNib() else { return UIViewController() }
        viewController.ingredient = bindable
        let sheet = SheetViewController(controller: viewController, sizes: [.fixed(400), .fixed(400)])
        
        return sheet
    }
    func openDetails(model: IngredientModel, type: NutritionDetailsType)  -> UIViewController {
        guard let viewController = NutritionDetailsViewController.instantiateFromNib() else { return UIViewController() }
        viewController.type = type
        viewController.model = model
        return viewController
    }
}
enum NutritionDetailsType {
    case Recipe, Ingredient
}
