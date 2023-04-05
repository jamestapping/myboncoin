//
//  ViewController.swift
//  myboncoin
//
//  Created by James Tapping on 03/04/2023.
//

import UIKit

class ListingVC: UIViewController {
    
    var listings: [Listing] = []
    var filteredListings: [Listing] = []
    var categories: [Category] = []
    let filterVM = FilterViewModel.shared
    
    private var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
          
        let selectedCategoryIDArray = self.filterVM.selectedItems.map {$0.categoryID }
        let selectedCategoryID = selectedCategoryIDArray.first
        filteredListings = listings.filter({$0.categoryID == selectedCategoryID})
        tableView.reloadData()
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.title = "myBonCoin"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filtrer", style: .plain, target: self, action: #selector(filter))
        
        let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
        let barHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(ListingCell.self, forCellReuseIdentifier: "ListingCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        let apiVM = APIViewModel()
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        apiVM.fetch(url: .listings, type: Listing.self) { res in
            switch res {
            case .success(let data):
                self.listings = data
            case .failure(let error):
                print (error)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        apiVM.fetch(url: .categories, type: Category.self) { res in
            switch res {
            case .success(let data):
                self.categories = data
                // var items: [CategoryItemViewModel] = []
                let categoryNames = Category.categoryNames(from: self.categories)
                let items = categoryNames.enumerated().map { index, categoryName in
                    CategoryItemViewModel(categoryItem: Filter(categoryID: index + 1, title: categoryName))
                }
                self.filterVM.items = items
            case .failure(let error):
                print (error)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    @objc func filter() {
        let filterVC = FilterVC()
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
}

extension ListingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedCategoryIDArray = self.filterVM.selectedItems.map {$0.categoryID}
        let selectedCategoryID = selectedCategoryIDArray.first
        return selectedCategoryID == nil ? listings.count : filteredListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listing: Listing
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell
        cell.image.image = nil
        let selectedCategoryIDArray = self.filterVM.selectedItems.map {$0.categoryID}
        let selectedCategoryID = selectedCategoryIDArray.first
        listing = selectedCategoryID == nil ? listings[indexPath.row] : filteredListings[indexPath.row]
        let categoryNames = Category.categoryNames(from: categories)
        cell.category.font = UIFont.boldSystemFont(ofSize: 16)
        cell.category.text = categoryNames[listing.categoryID - 1]
        cell.title.text = listing.title
        cell.title.font = UIFont.systemFont(ofSize: 14)
        cell.title.numberOfLines = 2
        cell.image.fetchImage(from: listing.imagesURL.thumb ?? "")
        cell.price.text = listing.price.euroCurrencyString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ListingDetailVC()
        let selectedCategoryIDArray = self.filterVM.selectedItems.map {$0.categoryID}
        let selectedCategoryID = selectedCategoryIDArray.first
        
        detailVC.selectedListing = selectedCategoryID == nil ? listings[indexPath.item] : filteredListings[indexPath.item]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

