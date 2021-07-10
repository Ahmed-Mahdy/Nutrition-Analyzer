//
//  NutritionAnalysisResponse.swift
//  Nutrition Analyzer
//
//  Created by Ahmed Mahdy on 10/07/2021.
//

import Foundation
struct NutritionAnalysisResponse : Codable {
    let uri: String?
    let calories: Int?
    let yield, totalWeight: Double?
    let dietLabels, healthLabels: [String]?
    let cautions: [String]?
    let totalNutrients, totalDaily: [String: TotalDaily]?
    let totalNutrientsKCal: TotalNutrientsKCal?

    enum CodingKeys: String, CodingKey {

        case uri = "uri"
        case yield = "yield"
        case calories = "calories"
        case totalWeight = "totalWeight"
        case dietLabels = "dietLabels"
        case healthLabels = "healthLabels"
        case cautions = "cautions"
        case totalNutrients = "totalNutrients"
        case totalDaily = "totalDaily"
        case totalNutrientsKCal = "totalNutrientsKCal"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uri = try values.decodeIfPresent(String.self, forKey: .uri) ?? nil
        yield = try values.decodeIfPresent(Double.self, forKey: .yield) ?? nil
        calories = try values.decodeIfPresent(Int.self, forKey: .calories) ?? nil
        totalWeight = try values.decodeIfPresent(Double.self, forKey: .totalWeight) ?? nil
        dietLabels = try values.decodeIfPresent([String].self, forKey: .dietLabels) ?? nil
        healthLabels = try values.decodeIfPresent([String].self, forKey: .healthLabels) ?? nil
        cautions = try values.decodeIfPresent([String].self, forKey: .cautions) ?? nil
        totalNutrients = try values.decodeIfPresent([String: TotalDaily].self, forKey: .totalNutrients) ?? nil
        totalDaily = try values.decodeIfPresent([String: TotalDaily].self, forKey: .totalDaily) ?? nil
        totalNutrientsKCal = try values.decodeIfPresent(TotalNutrientsKCal.self, forKey: .totalNutrientsKCal) ?? nil
    }

}

// MARK: - TotalDaily
struct TotalDaily: Codable {
    let label: String
    let quantity: Double
    let unit: Unit
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

// MARK: - TotalNutrientsKCal
struct TotalNutrientsKCal: Codable {
    let enercKcal, procntKcal, fatKcal, chocdfKcal: TotalDaily

    enum CodingKeys: String, CodingKey {
        case enercKcal = "ENERC_KCAL"
        case procntKcal = "PROCNT_KCAL"
        case fatKcal = "FAT_KCAL"
        case chocdfKcal = "CHOCDF_KCAL"
    }
}
