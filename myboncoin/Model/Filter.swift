//
//  Filter.swift
//  myboncoin
//
//  Created by James Tapping on 05/04/2023.
//

import Foundation

struct Filter {
    var categoryID: Int
    var title: String
}

class ViewModelItem {
    private var item: Filter
    var isSelected = false
    var title: String {
        return item.title
    }
    var categoryID: Int {
        return item.categoryID
    }
    init(item: Filter) {
        self.item = item
    }
}

class FilterViewModel {
    static let shared = FilterViewModel()
    var items = [ViewModelItem]()
    
    var selectedItems: [ViewModelItem] {
         return items.filter { return $0.isSelected }
      }
}



