//
//  CategoryItemViewModel.swift
//  myboncoin
//
//  Created by James Tapping on 05/04/2023.
//

import Foundation

class CategoryItemViewModel {
    private var categoryItem: Filter
    var isSelected = false
    var title: String {
        return categoryItem.title
    }
    var categoryID: Int {
        return categoryItem.categoryID
    }
    init(categoryItem: Filter) {
        self.categoryItem = categoryItem
    }
}
