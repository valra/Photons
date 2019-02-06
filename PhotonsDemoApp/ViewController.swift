//
//  ViewController.swift
//  PhotonsDemoApp
//
//  Created by Siddarth Kalra on 2019-02-03.
//  Copyright © 2019 Valra. All rights reserved.
//

import UIKit
import Photons

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        photons()
    }


}

private extension ViewController {
    
    func photons() {
        _ = Photo
            .filter { $0.id == "" }
            .sorted(by: {$0.id < $1.id})
            .fetch()
        
        _ = Photo
            .filter { $0.id == "" }
            .sorted(by: {$0.id < $1.id})
        
        _ = Video
            .filter { $0.id == "" }
            .sorted(by: {$0.id < $1.id})
            .fetch
    }
    
}
