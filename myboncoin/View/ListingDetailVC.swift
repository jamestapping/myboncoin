//
//  ListingDetailVC.swift
//  myboncoin
//
//  Created by James Tapping on 05/04/2023.
//

import UIKit

class ListingDetailVC: UIViewController {

    var selectedListing: Listing?
    
    private var tableView: UITableView!
    
    var contentView = UIView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let descriptionLabel = UILabel()
    let descriptionTextView = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
     
        let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
        let barHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(DetailCell.self, forCellReuseIdentifier: "DetailCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
}

extension ListingDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        
        cell.image.fetchImage(from: selectedListing?.imagesURL.small ?? "")
        cell.title.text = selectedListing?.title
        cell.title.numberOfLines = 0
        cell.title.font = UIFont.boldSystemFont(ofSize: 17)
        cell.descriptionLabel.text = selectedListing?.description
        cell.descriptionLabel.numberOfLines = 0
        cell.price.text = selectedListing?.price.euroCurrencyString
        cell.date.text = selectedListing?.formattedDate
        return cell
    }
}




