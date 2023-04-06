//
//  ViewController.swift
//  myboncoin
//
//  Created by James Tapping on 03/04/2023.
//

import UIKit

class ListingVC: UIViewController {
    
    var listings: [Listing] = []
    var tmpListings: [Listing] = []
    var tmpFilteredListings: [Listing] = []
    var nonUrgentListings: [Listing] = []
    var filteredListings: [Listing] = []
    var urgentListings: [Listing] = []
    
    var categories: [Category] = []
    let filterVM = FilterViewModel.shared
    let apiVM = APIViewModel()
    
    private var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
        
        let selectedCategoryID = self.filterVM.selectedItems.map {$0.categoryID }.first
        tmpFilteredListings = listings.filter({$0.categoryID == selectedCategoryID})
        self.urgentListings = self.tmpFilteredListings.filter{ $0.isUrgent }
        self.nonUrgentListings = self.tmpFilteredListings.filter{ $0.isUrgent == false }
        self.urgentListings.sort(by: { $0.date > $1.date })
        self.nonUrgentListings.sort(by: { $0.date > $1.date })
        self.filteredListings = self.urgentListings + self.nonUrgentListings
        
        if selectedCategoryID != nil { tableView.reloadData()}
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
      
        fetchData()
    }
    
    @objc func filter() {
        let filterVC = FilterVC()
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    
    func fetchData() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        apiVM.fetch(url: .listings, type: Listing.self) { res in
            switch res {
            case .success(let data):
                self.tmpListings = data
                self.urgentListings = self.tmpListings.filter{ $0.isUrgent }
                self.nonUrgentListings = self.tmpListings.filter{ $0.isUrgent == false }
                self.urgentListings.sort(by: { $0.date > $1.date })
                self.nonUrgentListings.sort(by: { $0.date > $1.date })
                self.listings = self.urgentListings + self.nonUrgentListings
                
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
                let categories = Category.buildCategories(from: self.categories)
                let categoryItems = categories.enumerated().map { index, categoryName in
                    CategoryItemViewModel(categoryItem: Filter(categoryID: index + 1, title: categoryName))
                }
                self.filterVM.categoryItems = categoryItems
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
        let selectedCategoryIDArray = self.filterVM.selectedItems.map {$0.categoryID}
        let selectedCategoryID = selectedCategoryIDArray.first
        return selectedCategoryID == nil ? listings.count : filteredListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listing: Listing
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell
        let selectedCategoryID = self.filterVM.selectedItems.map {$0.categoryID}.first
        listing = selectedCategoryID == nil ? listings[indexPath.row] : filteredListings[indexPath.row]
        cell.setUpCell(listing: listing, categories: categories)
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

