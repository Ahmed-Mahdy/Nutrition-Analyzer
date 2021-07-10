//
//  AddReciepe.swift
//  Nutrition Analyzer
//
//  Created by Ahmed Mahdy on 10/07/2021.
//

import UIKit
import RxSwift
import RxRelay
class AddReciepeViewController: UIViewController {

    var recipeString: BehaviorRelay<String>!
    
    @IBOutlet weak var receipeTextField: UITextField!
    @IBOutlet weak var addRecipeButton: UIButton!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRecipeButton.isEnabled = false
        addRecipeButton.alpha = 0.5
        receipeTextField.rx.controlEvent([.editingChanged]).asObservable().subscribe { [weak self] (_) in
            guard let self = self , let text = self.receipeTextField.text else { return }
            self.addRecipeButton.isEnabled = (!text.isEmpty)
            self.addRecipeButton.alpha = (text.isEmpty ? 0.5 : 1.0)
            self.recipeString.accept(text)
        }.disposed(by: disposeBag)
    }
    
    @IBAction func addRecipeAction(_ sender: UIButton) {
        if let text = receipeTextField.text {
            recipeString.accept(text)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
