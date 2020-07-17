//
//  MenuViewController.swift
//  Example Test App
//
//  Created by Juan Andres Vasquez Ferrer on 7/17/20.
//  Copyright © 2020 Juan Andres Vasquez Ferrer. All rights reserved.
//

import Foundation
import THFeedView
import UIKit

class MenuViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    let examples: [Example] = Example.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupView() {
        navigationItem.title = "THFeedView Examples"
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.examples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let example = examples[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "identifier")
        cell.textLabel?.text = example.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let example = examples[indexPath.row]
        let exampleController = example.getController()
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(exampleController, animated: true)
    }
    
    
}
