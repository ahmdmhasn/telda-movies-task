//
//  ViewController.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 23/11/2022.
//

import UIKit

class ViewController: UIViewController {

    let networking = TMDBNetworking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networking.similarMovies(id: "15015") { result in
            print(result)
        }
    }


}

