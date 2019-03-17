//
//  PhotonHelper.swift
//  Photons
//
//  Created by Siddarth Kalra on 2019-02-03.
//  Copyright © 2019 Valra. All rights reserved.
//

import Foundation

class PhotonHelper<A: Photon> {

    typealias FetchCompletionBlock = (Result<[A], PhotonError>) -> ()

    static func sorted(by areInIncreasingOrder: (A, A) -> Bool) -> Result<[A], PhotonError> {
        return .success([])
    }

    static func fetch<PhotonType>(type: PhotonType? = nil, onQueue queue: DispatchQueue, size: Size? = nil, limit: UInt = 0, _ completionBlock: FetchCompletionBlock) where PhotonType == A.PhotonType {
        completionBlock(.success([]))
    }

    static func filter(_ isIncluded: (A) -> Bool) -> Result<[A], PhotonError> {
        return .success([])
    }

    static func sizedTo(_ size: Size) -> Result<[A], PhotonError> {
        return .success([])
    }

    static func savePhoton(_ photon: A, onQueue queue: DispatchQueue, _ completionBlock: Photon.SaveCompletionBlock) {
    }
}

// MARK: PhotonContainer Helper methods

extension PhotonHelper {

    static func fetchContainer(name: String, onQueue queue: DispatchQueue, _ completionBlock: FetchCompletionBlock) {
        completionBlock(.success([]))
    }

    static func saveContainer<Container: PhotonContainer>(_ container: Container, onQueue queue: DispatchQueue, _ completionBlock: PhotonContainer.SaveCompletionBlock) where Container.Photon == A {

    }
}
