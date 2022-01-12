//
//  ErrorViewController.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import UIKit

final class ErrorViewController: UIViewController {
    
    @IBOutlet private weak var messageLabel: UILabel?
    
    private(set) var viewModel: ErrorViewModel?
    
    init(viewModel: ErrorViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        viewModel = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.title
        messageLabel?.text = viewModel?.message
    }
}
