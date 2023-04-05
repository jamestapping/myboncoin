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
    let vm = FilterViewModel.shared
    
    private var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
          
        let selectedCategoryIDArray = self.vm.selectedItems.map {$0.categoryID }
        let selectedCategoryID = selectedCategoryIDArray.first
        filteredListings = listings.filter({$0.categoryID == selectedCategoryID})
        tableView.reloadData()
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.title = "myBonCoin"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filter))
        
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
                let selectedCategoryIDArray = self.vm.selectedItems.map {$0.categoryID}
                let selectedCategoryID = selectedCategoryIDArray.first
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
        
                var items: [ViewModelItem] = []
                
                let categoryNames = Category.categoryNames(from: self.categories)
                for (i, categoryName) in categoryNames.enumerated() {
                    let item = ViewModelItem(item: Filter(categoryID: i + 1, title: categoryName))
                    items.append(item)
                }
                self.vm.items = items
                
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
        let selectedCategoryIDArray = self.vm.selectedItems.map {$0.categoryID}
        let selectedCategoryID = selectedCategoryIDArray.first
        return selectedCategoryID == nil ? listings.count : filteredListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listing: Listing
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell
        let selectedCategoryIDArray = self.vm.selectedItems.map {$0.categoryID}
        let selectedCategoryID = selectedCategoryIDArray.first
        listing = selectedCategoryID == nil ? listings[indexPath.row] : filteredListings[indexPath.row]
        let categoryNames = Category.categoryNames(from: categories)
        cell.category.font = UIFont.boldSystemFont(ofSize: 17)
        cell.category.text = categoryNames[listing.categoryID - 1]
        cell.title.text = listing.title
        cell.image.downloadImage(from: listing.imagesURL.small ?? "")
        cell.price.text = listing.price.euroCurrencyString
        return cell
    }
}

