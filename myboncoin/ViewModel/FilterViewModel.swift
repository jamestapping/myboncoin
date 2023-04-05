//
//  FilterViewModel.swift
//  myboncoin
//
//  Created by James Tapping on 05/04/2023.
//

import Foundation

class FilterViewModel {
    static let shared = FilterViewModel()
    var items = [CategoryItemViewModel]()
    var selectedItems: [CategoryItemViewModel] {
        return items.filter { return $0.isSelected }
    }
}
