//
//  Reactive+Error.swift
//  Nutrition Analyzer
//
//  Created by Ahmed Mahdy on 10/07/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Moya

extension UIViewController: errorViewable {}

extension Reactive where Base: UIViewController {

    /// Bindable sink for isError() method.
    public var isError: Binder<Error> {
        return Binder(self.base, binding: { (viewController, error) in
            //            viewController.showError(with: error)
            
            let error = error as? NutritionException
            switch error?.code {
            case 401:
                // logout
                print("invalid user")
//                observer.onError(<#T##error: Error##Error#>)
            default:
                base.showError(with: error)
                break
            }
        })
    }
}

protocol errorViewable {
    func showError(with: NutritionException?)
}
extension errorViewable where Self: UIViewController {
    func showError(with: NutritionException?) {
        let alertController =
            UIAlertController(title: with?.title, message: with?.message, preferredStyle: UIAlertController.Style.alert)
        let okAction =
            UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {(action) in
            if let action = with?.action {
                action()
            }
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
