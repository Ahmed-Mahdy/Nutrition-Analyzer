//
//  BaseCoordinator.swift
//  Nutrition Analyzer
//
//  Created by Ahmed Mahdy on 10/07/2021.
//

import Foundation
import UIKit
protocol BaseCoordinator {
    associatedtype Destination
    var rootViewController: UIViewController { get set }
    func makeViewController(for destination: Destination) -> UIViewController
}
