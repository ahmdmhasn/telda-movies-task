//
//  CastsTableViewCell.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 25/11/2022.
//

import UIKit

class CastsTableViewCell: UITableViewCell {
    typealias Element = CastCollectionViewCell.ViewModel
    typealias ViewModel = [Element]

    // MARK: Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private var elements: [Element] = []
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CastCollectionViewCell.self)
    }

    // MARK: Configuration
    
    func configure(_ viewModel: ViewModel) {
        self.elements = viewModel
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
//
extension CastsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(at: indexPath) as CastCollectionViewCell
        cell.configure(elements[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
//
extension CastsTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        return CGSize(width: height * 0.7, height: height - 2 * Metrics.padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Metrics.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Metrics.padding, left: Metrics.padding, bottom: Metrics.padding, right: Metrics.padding)
    }
}


// MARK: - Metrics
//
extension CastsTableViewCell {
    
    enum Metrics {
        static let spacing: CGFloat = 8.0
        static let padding: CGFloat = 8.0
    }
}
