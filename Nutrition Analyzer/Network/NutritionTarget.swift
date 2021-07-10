//
//  NutritionTarget.swift
//  Nutrition Analyzer
//
//  Created by Ahmed Mahdy on 10/07/2021.
//

import Foundation
import Moya

enum NutritionTarget {
    static private var appID = "e8ce7221"
    static private var appKey = "77a9af9c7005194d72f816a95c9240d9"
    case analyze(receipeName: String, recipeIngredients: [String])
}

extension NutritionTarget: TargetType {
    
    
    var baseURL: URL {
        return URL(string: "https://api.edamam.com/api/")!
    }
    
    var path: String {
        switch self {
        case .analyze:
            return "nutrition-details"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .analyze:
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data() // we only return Data() here as a fake response, it has to be changed for Unit Testing.
    }
    
    public var task: Task {
        switch self {
        case .analyze(let receipeName, let recipeIngredients):
            var parameters = [String:Any]()
            parameters = [
                "title":receipeName,
                "ingr":recipeIngredients
            ]
            var urlParams =  [String:Any]()
            urlParams = [
                "app_id": NutritionTarget.appID,
                "app_key": NutritionTarget.appKey
                
            ]
            return .requestCompositeParameters(bodyParameters: parameters, bodyEncoding: JSONEncoding.default, urlParameters: urlParams)
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
    
}
