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
        (title: "Second Video", image: UIImage(systemName: "heart.fill")),
        (title: "Third Video", image: UIImage(systemName: "video.fill")),
        (title: "Fourth Video", image: UIImage(systemName: "heart.fill")),
        (title: "Fifth Video", image: UIImage(systemName: "video.fill"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        setTableDelegate()
        tableView.rowHeight = 100
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
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
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let item = data[indexPath.row]
        cell.configure(image: item.image, title: item.title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(data[indexPath.row].title)")
    }
}
