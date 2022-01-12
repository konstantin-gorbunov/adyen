//
//  LoadingViewController.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 11/01/2022.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    @IBOutlet private weak var messageLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel?.text = NSLocalizedString("Loading...", comment: "Loading text")
    }
}
