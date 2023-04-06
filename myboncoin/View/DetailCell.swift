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
    let date = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        image.backgroundColor = UIColor.gray
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        price.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.gray
        self.selectedBackgroundView = backgroundView
        self.selectionStyle = .none
        
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(title)
        contentView.addSubview(price)
        contentView.addSubview(image)
        contentView.addSubview(date)
        
        let viewsDict = [
            "image" : image,
            "description" : descriptionLabel,
            "title" : title,
            "price" : price,
            "date" : date
        ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[image(320)]-8-[title]-4-[description]-8-[price]-[date]-16-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-32-[image(320)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[title]-16-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[description]-16-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[price]-16-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[date]-16-|", options: [], metrics: nil, views: viewsDict))
    }
    
    func setUpCell(listing: Listing) {
        self.image.image = nil
        self.image.fetchImage(from: listing.imagesURL.small ?? "")
        self.title.text = listing.title
        self.title.numberOfLines = 0
        self.title.font = UIFont.boldSystemFont(ofSize: 17)
        self.price.text = listing.price.euroCurrencyString
        self.date.text = "Publié le \(listing.formattedDate)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
