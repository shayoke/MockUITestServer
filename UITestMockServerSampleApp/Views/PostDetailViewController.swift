//
//  PostDetailViewController.swift
//  UITestMockServerSampleApp
//
//  Created by Shayoke Mukherjee on 31/07/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import UIKit

final class PostDetailsViewController: UIViewController {
    
    typealias ViewModel = Post
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var footerLabel: UILabel!
    
    public var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = viewModel.title
        idLabel.text = String(viewModel.id)
        bodyLabel.text = viewModel.body
    }
    
}
