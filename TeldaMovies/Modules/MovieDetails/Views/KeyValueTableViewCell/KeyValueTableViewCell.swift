//
//  KeyValueTableViewCell.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 25/11/2022.
//

import UIKit

class KeyValueTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet private weak var keyLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        keyLabel.numberOfLines = 1
        keyLabel.textAlignment = .left
        keyLabel.font = .preferredFont(forTextStyle: .body)
        keyLabel.textColor = .darkGray
        
        valueLabel.numberOfLines = 3
        valueLabel.textAlignment = .right
        valueLabel.font = .preferredFont(forTextStyle: .body)
        valueLabel.textColor = .black
    }

    // MARK: Configurations
    
    func configure(_ viewModel: ViewModel) {
        keyLabel.text = viewModel.key
        valueLabel.text = viewModel.value
    }
}

extension KeyValueTableViewCell {
    struct ViewModel {
        let key: String
        let value: String
    }
}
