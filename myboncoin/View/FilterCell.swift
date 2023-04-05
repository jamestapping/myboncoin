//
//  FilterCell.swift
//  myboncoin
//
//  Created by James Tapping on 05/04/2023.
//

import Foundation
import UIKit

class FilterCell: UITableViewCell {
    
    let categoryLabel = UILabel()
  
    var item: CategoryItemViewModel? {
       didSet {
           categoryLabel.text = item?.title
       }
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)
       accessoryType = selected ? .checkmark : .none
       selectionStyle = .none
    }
    
   override func awakeFromNib() {
      super.awakeFromNib()
      selectionStyle = .none
   }
}
