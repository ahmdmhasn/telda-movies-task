//
//  UICollectionView+Helpers.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 25/11/2022.
//

import UIKit

public extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            let message = "⚠️ Unable to dequeue cell type: \(T.self) at indexPath: \(indexPath)"
            Logger.fatal(message)
        }
        return cell
    }

    func register(_ klass: AnyClass, identifier: String? = nil) {
        let nibName = String(describing: klass.self)
        let identifier = identifier ?? nibName
        let nib = UINib(nibName: nibName, bundle: .init(for: klass))
        register(nib, forCellWithReuseIdentifier: identifier)
    }
}
