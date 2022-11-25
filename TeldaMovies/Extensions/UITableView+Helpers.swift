//
//  UITableView+Helpers.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 25/11/2022.
//

import UIKit

public extension UITableView {
    func dequeueCell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            let message = "⚠️ Unable to dequeue cell type: \(T.self) at indexPath: \(indexPath)"
            Logger.fatal(message)
        }

        return cell
    }
    
    func register<T: UITableViewCell>(_ klass: T.Type, identifier: String? = nil) {
        let nibName = T.reuseIdentifier
        let identifier = identifier ?? nibName
        let nib = UINib(nibName: nibName, bundle: Bundle(for: klass))

        register(nib, forCellReuseIdentifier: identifier)
    }
}
