//
//  ViewController.swift
//  myboncoin
//
//  Created by James Tapping on 03/04/2023.
//

import UIKit

class ListingVC: UIViewController {
    
    var listings: [Listing] = []
    var categories: [Category] = []
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        navigationItem.title = "myBonCoin"
        
        let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
        let barHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(ListingCell.self, forCellReuseIdentifier: "ListingCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        let dispatchGroup = DispatchGroup()
        
        let vm = ViewModel()
        
        dispatchGroup.enter()
        vm.fetch(url: .listings, type: Listing.self) { res in
            switch res {
            case .success(let data):
                self.listings = data
            case .failure(let error):
                print (error)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        vm.fetch(url: .categories, type: Category.self) { res in
            switch res {
            case .success(let data):
                self.categories = data
            case .failure(let error):
                print (error)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
}

extension ListingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell
        let listing = listings[indexPath.row]
        let categoryNames = Category.categoryNames(from: categories)
        cell.category.font = UIFont.boldSystemFont(ofSize: 17)
        cell.category.text = categoryNames[listing.categoryID - 1]
        cell.title.text = listing.title
        cell.image.downloadImage(from: listing.imagesURL.small ?? "")
        cell.price.text = listing.price.euroCurrencyString
        return cell
    }
}

