//
//  LoadingViewable.swift
//  NearBy-Places
//
//  Created by ahmed mahdy on 11/2/19.
//  Copyright © 2019 Mahdy. All rights reserved.
//

import Foundation
import UIKit

protocol loadingViewable {
    func startAnimating()
    func stopAnimating()
}
extension loadingViewable where Self: UIViewController {
    static var window : UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
    func startAnimating() {
        let animateLoading = LoadingView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        guard let window = Self.window else {return}
        view.addSubview(animateLoading)
        view.bringSubviewToFront(animateLoading)
        animateLoading.restorationIdentifier = "loadingView"
        animateLoading.center = view.center
        animateLoading.loadingViewMessage = "Loading"
        animateLoading.layer.cornerRadius = 15
        animateLoading.clipsToBounds = true
        animateLoading.startAnimation()
        window.isUserInteractionEnabled = false
        
    }
    func stopAnimating() {
        guard let window = Self.window else {return}
        window.isUserInteractionEnabled = true
        for item in view.subviews
            where item.restorationIdentifier == "loadingView" {
                let animation = {item.alpha = 0 }
                UIView.animate(withDuration: 0.3, animations: animation) { (_) in
                    item.removeFromSuperview()
                }
        }
    }
}
