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
            .fetch { result in
                print(result)
        }
        
        _ = Photo
            .filter { $0.id == "" }
            .sorted(by: {$0.id < $1.id})
            .fetch { result in
                print(result)
        }
        
        _ = Video
            .filter { $0.id == "" }
            .sorted(by: {$0.id < $1.id})
            .fetch { result in
                print(result)
        }
    }
    
    func savePhotons() {
        let photo1 = Photo(id: "1", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date())
        let photo2 = Photo(id: "2", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date())
        
        [photo1, photo2].save { result in
            print(result)
        }
        
        let video1 = Video(id: "1", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date(), duration: 40)
        let video2 = Video(id: "1", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date(), duration: 40)
        
        [video1, video2].save { result in
            print(result)
        }
    }
    
    func fetchAlbum() {
        Album<Photo>.fetch(name: "test") { result in
            print(result)
        }
        
        Album<Video>.fetch(name: "test") { result in
            print(result)
        }

    }
    
    func saveAlbum() {
        let photo1 = Photo(id: "1", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date())
        let photo2 = Photo(id: "2", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date())

        let photoAlbum = Album(id: "1", name: "photo album", data: [photo1, photo2])
        photoAlbum.save { result in
            print(result)
        }
        
        let video1 = Video(id: "1", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date(), duration: 40)
        let video2 = Video(id: "1", data: Data(), size: (width: 100, height: 100), type: .standard, creationDate: Date(), modificationDate: Date(), duration: 40)

        let videoAlbum = Album(id: "2", name: "video album", data: [video1, video2])
        videoAlbum.save { result in
            print(result)
        }

    }
    
}
