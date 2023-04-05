//
//  ViewModel.swift
//  myboncoin
//
//  Created by James Tapping on 03/04/2023.
//

import Foundation

class ViewModel {
    func fetch<T: Decodable>(url: URLString, type: T.Type, completionHandler: @escaping (Result<[T], Error>) -> Void) {
        let service = APIService()
        service.fetch(url: URL(string: url.value), type: type) { result in
            switch result {
            case .success(let listings):
                completionHandler(.success(listings))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    enum URLString {
        case categories
        case listings
        
        var value: String {
            switch self {
            case .categories: return "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"
            case .listings: return "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
            }
        }
    }
}
