//
//  ViewController+loadNib.swift
//  Nutrition Analyzer
//
//  Created by Ahmed Mahdy on 10/07/2021.
//

import UIKit

extension UIViewController {
    static func instantiateFromNib() -> Self? {
        func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T? {
            return Bundle.main.loadNibNamed(String(describing: T.self),
                                     owner: nil, options: nil)?.first
            as? T
        }

        return instantiateFromNib(self)
    }
}
extension UIView {
    class func loadFromNib<T: UIView>(named: String) -> T {
        return Bundle.main.loadNibNamed(named, owner: nil, options: nil)![0] as! T
    }
}
