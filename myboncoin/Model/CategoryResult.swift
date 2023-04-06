//
//  CatagoriesResult.swift
//  myboncoin
//
//  Created by James Tapping on 03/04/2023.
//

struct Category: Decodable {
    let id: Int
    let name: String?
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    static func buildCategories(from categories: [Category]) -> [String] {
        return categories.compactMap { $0.name }
    }
}

