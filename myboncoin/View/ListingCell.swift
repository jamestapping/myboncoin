//
//  ListingCell.swift
//  myboncoin
//
//  Created by James Tapping on 04/04/2023.
//

import Foundation
import UIKit

class ListingCell: UITableViewCell {
    var image = UIImageView()
    var title = UILabel()
    var category = UILabel()
    var price = UILabel()
    var urgent = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        category.translatesAutoresizingMaskIntoConstraints = false
        price.translatesAutoresizingMaskIntoConstraints = false
        urgent.translatesAutoresizingMaskIntoConstraints = false
        image.sizeToFit()
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = backgroundView
        
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none

        contentView.addSubview(category)
        contentView.addSubview(title)
        contentView.addSubview(price)
        contentView.addSubview(image)
        contentView.addSubview(urgent)

        let viewsDict = [
            "image" : image,
            "category" : category,
            "title" : title,
            "price" : price,
            "urgent": urgent
            ] as [String : Any]

        contentView.addConstraint(NSLayoutConstraint(item: viewsDict["image"]!, attribute: .height, relatedBy: .equal, toItem: viewsDict["image"]!, attribute: .width, multiplier: 1.0, constant: 0))

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[category]-0-[title]-0-[price]-|", options: [.alignAllLeading], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-[category]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[image]-[title]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[image(75)]-[price]-[urgent]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    func setUpCell(vm: ListingCellViewModel) {
        self.image.image = vm.image
        self.title.text = vm.title
        self.price.text = vm.price
        self.category.text = vm.categoryString
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
