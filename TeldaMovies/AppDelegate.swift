//
//  AppDelegate.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 23/11/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureMainWindow()
        
        return true
    }
}

// MARK: Private Handlers
//
private extension AppDelegate {
    
    func configureMainWindow() {
        let viewController = MoviesListViewController(viewModel: MoviesListViewModel())
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let window = UIWindow()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}
