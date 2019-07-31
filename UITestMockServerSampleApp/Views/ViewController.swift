//
//  ViewController.swift
//  UITestMockServerSampleApp
//
//  Created by Shayoke Mukherjee on 28/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import UIKit
import Mockingjay

class ViewController: UIViewController {
    @IBOutlet private weak var environmentChooser: UISegmentedControl!
    @IBOutlet private weak var debuggingLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    private func setupTableView() {
        tableView.layer.cornerRadius = 4.0
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    @IBAction private func didTapReload(_ sender: UIButton) {
        NetworkManager.shared.fetchPosts { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
                
            case .failure(let error):
                dump(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        
        if let cell = cell as? PostCell {
            let post = posts[indexPath.row]
            
            cell.titleLabel.text = post.title
            cell.bodyLabel.text = post.body
            cell.idLabel.text = "\(post.id)"
        }
        
        return cell
    }
}

class PostCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
}
