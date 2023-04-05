//
//  DetailCell.swift
//  myboncoin
//
//  Created by James Tapping on 05/04/2023.
//

import Foundation
import UIKit

class DetailCell: UITableViewCell {
    let image = UIImageView()
    let title = UILabel()
    let descriptionLabel = UILabel()
    let price = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        image.backgroundColor = UIColor.orange
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        price.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.orange
        self.selectedBackgroundView = backgroundView
        
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(title)
        contentView.addSubview(price)
        contentView.addSubview(image)
        
        let viewsDict = [
            "image" : image,
            "description" : descriptionLabel,
            "title" : title,
            "price" : price,
        ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[image(320)]-8-[title]-4-[description]-8-[price]-16-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-32-[image(320)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[title]-16-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[description]-16-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[price]-16-|", options: [], metrics: nil, views: viewsDict))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
