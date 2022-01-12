//
//  LocationViewCell.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 12/01/2022.
//

import UIKit

final class LocationViewCell: UICollectionViewCell, NibInstantiatable {

    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var locationLabel: UILabel?

    var viewModel: LocationViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            nameLabel?.text = viewModel.name
            locationLabel?.text = viewModel.coordinate
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutSetup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSetup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel?.text = nil
        locationLabel?.text = nil
    }
    
    private func layoutSetup() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}
