//
//  ViewController.swift
//  Nutrition Analyzer
//
//  Created by Ahmed Mahdy on 09/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

class NutritionViewController: UIViewController {
    @IBOutlet weak var reciepeName: UILabel!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addReciepeButton: UIButton!
    @IBOutlet weak var analyzeButton: UIButton!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    private var state: BehaviorSubject<HomeState> = BehaviorSubject(value: .AddRecipe)
    private var viewModel: NutritionViewModel!
    private var recipeObservable = BehaviorRelay(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NutritionViewModel(coordinator: NutritionCoordinator(rootViewController: self), recipeName: recipeObservable)
        setupObserable()
        registerCell()
    }
    private func registerCell() {
        tableView.register(UINib(nibName: "IngredientTableViewCell", bundle: nil), forCellReuseIdentifier: "IngredientTableViewCell")
    }
    func setupObserable() {
        viewModel.isLoading
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isError
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)
        recipeObservable.bind(to: reciepeName.rx.text ).disposed(by: disposeBag)
        state.subscribe { [weak self] (event) in
            if let state = event.element {
                switch state {
                case .AddRecipe:
                    self?.addReciepeButton.isHidden = false
                    self?.addIngredientButton.isHidden = true
                case .AddIngredients:
                    self?.addReciepeButton.isHidden = true
                    self?.addIngredientButton.isHidden = false
                }
            }
            
        }.disposed(by: disposeBag)
        
        reciepeName.rx.observe(String.self, "text").subscribe(onNext: { [weak self] text in
            if let text = text, !text.isEmpty {
                self?.state.asObserver().on(.next(.AddIngredients))
            } else {
                self?.state.asObserver().on(.next(.AddRecipe))
            }
        }).disposed(by: disposeBag)
        viewModel.ingredients.asDriver()
            .drive(tableView.rx.items(cellIdentifier: "IngredientTableViewCell", cellType: IngredientTableViewCell.self)) { (_, ing, cell) in
                cell.configure(with: "\(ing.quantity), \(ing.unit) of \(ing.title)")
            }
            .disposed(by: disposeBag)
        viewModel.ingredients.asObservable().subscribe({ [weak self] (event) in
            if let elements = event.element {
                self?.analyzeButton.isHidden = elements.isEmpty
                self?.addReciepeButton.isHidden = !elements.isEmpty
            }
        }).disposed(by: disposeBag)
        tableView.rx.itemSelected.bind(onNext: { [weak self] indexPath  in
            self?.viewModel?.analyzeIngredients(for: indexPath.row)
        }).disposed(by: disposeBag)
    }
    @IBAction func adddreciepe(_ sender: Any) {
        viewModel.addNewRecipe()
    }
    @IBAction func analyzeReciepe(_ sender: Any) {
        viewModel.analyzeIngredients()
    }
    @IBAction func addIngredient(_ sender: Any) {
        viewModel.addIngredient()
    }
}
enum HomeState {
    case AddRecipe, AddIngredients
}
