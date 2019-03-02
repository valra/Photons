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
        fetchPhotons()
        savePhotons()
    }

}

private extension ViewController {
    
    func fetchPhotons() {
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
    
    func savePhotons() {
        let photo1 = Photo(id: "1", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date())
        let photo2 = Photo(id: "2", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date())
        
        try! [photo1, photo2].save()
        
        let video1 = Video(id: "1", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date(), duration: 40)
        let video2 = Video(id: "1", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date(), duration: 40)
        
        try! [video1, video2].save()
    }
    
    func saveAlbum() {
        let photo1 = Photo(id: "1", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date())
        let photo2 = Photo(id: "2", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date())

        let photoAlbum = Album(id: "1", name: "photo album", data: [photo1, photo2])
        try! photoAlbum.save()
        
        let video1 = Video(id: "1", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date(), duration: 40)
        let video2 = Video(id: "1", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date(), duration: 40)

        let videoAlbum = Album(id: "2", name: "video album", data: [video1, video2])
        try! videoAlbum.save()

    }
    
}
