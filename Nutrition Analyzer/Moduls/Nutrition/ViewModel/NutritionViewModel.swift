//
//  NutritionViewModel.swift
//  Nutrition Analyzer
//
//  Created by Ahmed Mahdy on 10/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

class NutritionViewModel: BaseViewModel {
    
    private var repository: RecipeAnalysisRepository
    private var coordinator: NutritionCoordinator!
    var isLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var isError: PublishSubject<Error> = PublishSubject()
    var disposeBag: DisposeBag = DisposeBag()
    
    var ingredients = BehaviorRelay(value: [IngredientModel]())
    private var currentIngredient = BehaviorRelay(value: IngredientModel())
    var recipeName: BehaviorRelay<String>!
    
    init (_ repo: RecipeAnalysisRepository = RecipeAnalysisRepository(), coordinator: NutritionCoordinator, recipeName: BehaviorRelay<String>) {
        repository = repo
        self.coordinator = coordinator
        self.recipeName = recipeName
        self.currentIngredient.subscribe { [weak self ](event) in
            guard let self = self else { return }
            if let ing = event.element , !ing.title.isEmpty {
                let filtered = self.ingredients.value.filter({ !$0.title.isEmpty})
                self.ingredients.accept( filtered + [ing])
                
            }
        }.disposed(by: disposeBag)
    }
    
    func addNewRecipe()  {
        coordinator.present(to: .AddRecipe(recipeString: recipeName))
    }
    func addIngredient()  {
        self.coordinator.present(to: .AddIngredient(bindable: currentIngredient))
    }
    private func stringObject(objects: [IngredientModel]) -> [String] {
        return objects.map({
            "\($0.quantity) \($0.unit) \($0.title)"
        })
    }
    
    func analyzeIngredients(for index: Int) {
        self.isLoading.onNext(true)
        var model = ingredients.value[index]
        let ingredient = ["\(model.quantity) \(model.unit) \(model.title)"]
        let observable = repository.analyzeRecipe(receipeName: recipeName.value, recipeIngredients: ingredient)
        getData(observable, decodingType: NutritionAnalysisResponse.self).observeOn(MainScheduler.instance)
            .subscribe { [weak self] result in
                model.response = result
                self?.coordinator.navigate(to: .openDetails(model: model, type: NutritionDetailsType.Ingredient))
            } onError: { error in
                
            }.disposed(by: disposeBag)
    }
    func analyzeIngredients() {
        self.isLoading.onNext(true)
        let observable = repository.analyzeRecipe(receipeName: recipeName.value, recipeIngredients: stringObject(objects: ingredients.value))
        getData(observable, decodingType: NutritionAnalysisResponse.self).observeOn(MainScheduler.instance).subscribe { [weak self] result in
            var model = IngredientModel()
            model.response = result
            self?.coordinator.navigate(to: .openDetails(model: model , type: NutritionDetailsType.Recipe))
        } onError: { error in
            
        }.disposed(by: disposeBag)
    }
    
}
