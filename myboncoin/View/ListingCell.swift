//
//  ListingCell.swift
//  myboncoin
//
//  Created by James Tapping on 04/04/2023.
//

import Foundation
import UIKit

class ListingCell: UITableViewCell {
    let image = UIImageView()
    let title = UILabel()
    let category = UILabel()
    let price = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        image.backgroundColor = UIColor.blue
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        category.translatesAutoresizingMaskIntoConstraints = false
        price.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.orange
        self.selectedBackgroundView = backgroundView
        
        self.accessoryType = .disclosureIndicator

        contentView.addSubview(category)
        contentView.addSubview(title)
        contentView.addSubview(price)
        contentView.addSubview(image)

        let viewsDict = [
            "image" : image,
            "category" : category,
            "title" : title,
            "price" : price,
            ] as [String : Any]

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(75)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[category]-[title]-[price]-|", options: [.alignAllLeading], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(75)]-[category]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[image]-[title]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[image]-[price]-|", options: [], metrics: nil, views: viewsDict))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
