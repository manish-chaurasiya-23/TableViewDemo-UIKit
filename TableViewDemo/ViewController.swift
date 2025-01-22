//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Manish Kumar on 22/01/25.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    let data = [
        (title: "First Video", image: UIImage(systemName: "video.fill")),
        (title: "Second Video", image: UIImage(systemName: "video.fill")),
        (title: "Third Video", image: UIImage(systemName: "video.fill")),
        (title: "Fourth Video", image: UIImage(systemName: "video.fill")),
        (title: "Fifth Video", image: UIImage(systemName: "video.fill")),
        (title: "Sixth Video", image: UIImage(systemName: "video.fill")),
        (title: "Seventh Video", image: UIImage(systemName: "video.fill")),
        (title: "Eighth Video", image: UIImage(systemName: "video.fill")),
        (title: "Ninth Video", image: UIImage(systemName: "video.fill")),
        (title: "Tenth Video", image: UIImage(systemName: "video.fill"))
    ]
    
    var dataCopy: [(title: String, image: UIImage?)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        setTableDelegate()
//        tableView.rowHeight = 100  (static or fixed height)
        tableView.rowHeight = UITableView.automaticDimension // dynamic height for each row
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")

        dataCopy = data
        
        // Enable editing mode for reordering
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditing))
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func toggleEditing() {
        tableView.isEditing = !tableView.isEditing
    }

    func setTableDelegate() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshData() {
        print("Data refreshed")
        tableView.refreshControl?.endRefreshing() // stop the refresh Spinner when data is fetched
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCopy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let item = dataCopy[indexPath.row]
        cell.configure(image: item.image, title: item.title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(dataCopy[indexPath.row].title)")
    }
    
    // Swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataCopy.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Enable reordering of rows
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Handle reordering of rows
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = dataCopy[sourceIndexPath.row]
        dataCopy.remove(at: sourceIndexPath.row)
        dataCopy.insert(movedItem, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Videos"
    }
}
