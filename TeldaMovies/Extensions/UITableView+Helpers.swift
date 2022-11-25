//
//  UITableView+Helpers.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 25/11/2022.
//

import UIKit

public extension UITableView {
    func dequeueCell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            let message = "⚠️ Unable to dequeue cell type: \(T.self) at indexPath: \(indexPath)"
            Logger.fatal(message)
        }

        return cell
    }
    
    func register(_ klass: AnyClass, identifier: String? = nil) {
        let nibName = String(describing: klass.self)
        let identifier = identifier ?? nibName
        let nib = UINib(nibName: nibName, bundle: Bundle(for: klass))

        register(nib, forCellReuseIdentifier: identifier)
    }
}
