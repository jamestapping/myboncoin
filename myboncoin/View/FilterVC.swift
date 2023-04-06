//
//  FilterVCViewController.swift
//  myboncoin
//
//  Created by James Tapping on 05/04/2023.
//

import UIKit

class FilterVC: UIViewController {
    let filterVM = FilterViewModel.shared
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Filtrer par categorie"
        
        let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
        let barHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))

        tableView.register(FilterCell.self, forCellReuseIdentifier: "FilterCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        self.view.backgroundColor = .white
        
        tableView.reloadData()
    }
}

extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath as IndexPath) as! FilterCell
        cell.item = filterVM.categoryItems[indexPath.row]
        cell.textLabel?.text = filterVM.categoryItems[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterVM.categoryItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        for item in filterVM.categoryItems { item.isSelected = false }
        filterVM.categoryItems[indexPath.row].isSelected = true
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let currentIndexPath = tableView.indexPathForSelectedRow {
            self.tableView.cellForRow(at: currentIndexPath)?.accessoryType = .none
            for item in filterVM.categoryItems { item.isSelected = false }
            filterVM.categoryItems[indexPath.row].isSelected = false
        }
        return indexPath
    }
}
