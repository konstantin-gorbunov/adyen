//
//  SectionHeader.swift
//  adyen
//
//  Created by Kostiantyn Gorbunov on 12/01/2022.
//

import UIKit

protocol SectionHeaderDelegate: AnyObject {
    func valueChanged(_ value: Int)
}

final class SectionHeader: UICollectionReusableView, NibInstantiatable {
    
    private enum Constants {
        static let defSliderValue: Float = 500
    }
    
    weak var delegate: SectionHeaderDelegate?
    
    var viewModel: SectionHeaderViewModel? {
        didSet {
            update(viewModel)
        }
    }
    
    @IBOutlet private weak var valueLabel: UILabel?
    @IBOutlet private weak var radiusSlider: UISlider?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        radiusSlider?.isContinuous = false
        radiusSlider?.addTarget(self, action: #selector(didValueChanged(_:)), for: .valueChanged)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetValue()
    }
    
    private func update(_ viewModel: SectionHeaderViewModel?) {
        guard let viewModel = viewModel else {
            resetValue()
            return
        }
        radiusSlider?.value = Float(viewModel.value)
        valueLabel?.text = viewModel.value.description
    }
    
    private func resetValue() {
        radiusSlider?.value = Constants.defSliderValue
        valueLabel?.text = Int(Constants.defSliderValue).description
    }
    
    @objc private func didValueChanged(_ sender: UISlider) {
        delegate?.valueChanged(Int(sender.value))
        valueLabel?.text = Int(sender.value).description
    }
}
