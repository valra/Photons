//
//  PhotonHelper.swift
//  Photons
//
//  Created by Siddarth Kalra on 2019-02-03.
//  Copyright © 2019 Valra. All rights reserved.
//

import Foundation

class PhotonHelper<A: Photon> {
    
    static func sorted(by areInIncreasingOrder: (A, A) -> Bool) -> Result<[A], PhotonError> {
        return .success([])
    }
    
    static func fetch<PhotonType>(type: PhotonType? = nil, onQueue queue: DispatchQueue = DispatchQueue.global(), size: Size? = nil, limit: UInt = 0) -> Result<[A], PhotonError> {
        return .success([])
    }
    
    static func filter(_ isIncluded: (A) -> Bool) -> Result<[A], PhotonError> {
        return .success([])
    }
    
    static func sizedTo(_ size: Size) -> Result<[A], PhotonError> {
        return .success([])
    }
}
