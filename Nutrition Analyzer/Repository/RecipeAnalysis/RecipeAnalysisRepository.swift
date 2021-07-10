//
//  RecipeAnalysisRepository.swift
//  Nutrition Analyzer
//
//  Created by Ahmed Mahdy on 10/07/2021.
//

import Foundation
import RxSwift
import Moya

class RecipeAnalysisRepository: Repository {
    var cachingPolicy: CachingPolicy
    var provider = MoyaProvider<NutritionTarget>(plugins: [ NetworkLoggerPlugin() ])
    
    public init(cachingPolicy: CachingPolicy = .NetworkOnly) {
        self.cachingPolicy = cachingPolicy
    }
    func analyzeRecipe(receipeName: String, recipeIngredients: [String]) -> Observable<NutritionAnalysisResponse> {
        return getData(.analyze(receipeName: receipeName, recipeIngredients: recipeIngredients), decodingType: NutritionAnalysisResponse.self)
    }
}
