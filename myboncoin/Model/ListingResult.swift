//
//  annoncesResult.swift
//  myboncoin
//
//  Created by James Tapping on 03/04/2023.
//

import Foundation

struct Listing: Decodable {
    let id: Int
    let categoryID: Int
    let title, description: String
    let price: Double
    let imagesURL: ImagesURL
    let creationDate: String
    let isUrgent: Bool
    let siret: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title, description, price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let newDate = dateFormatter.date(from: creationDate )
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM d, yyyy")
        return dateFormatter.string(from: newDate ?? Date())
    }
}

struct ImagesURL: Codable {
    let small, thumb: String?
}
