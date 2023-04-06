//
//  FilterViewModel.swift
//  myboncoin
//
//  Created by James Tapping on 05/04/2023.
//

import Foundation

class FilterViewModel {
    static let shared = FilterViewModel()
    var categoryItems = [CategoryItemViewModel]()
    var selectedItems: [CategoryItemViewModel] {
        return categoryItems.filter { return $0.isSelected }
    }
}
