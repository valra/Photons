//
//  Photons.swift
//  Photons
//
//  Created by Siddarth Kalra on 2019-02-03.
//  Copyright © 2019 Valra. All rights reserved.
//

import Foundation

public enum Result<Success, Failure: Error> {
    case success(Success), failure(Failure)
}

public struct PhotonError: Error {}
public typealias Size = (width: UInt, height: UInt)
public typealias LocationCoordinate = (latitude: Double, longitude: Double)

public protocol Photon {
    associatedtype `PhotonType`
    
    var id: String { get }
    var data: Data { get }
    var size: Size { get }
    var type: PhotonType { get }
    var creationDate: Date { get }
    var modificationDate: Date { get }
    var locaitonCoordinate: LocationCoordinate? { get }
}

public extension Photon {
    
    static func filter(_ isIncluded: (Self) -> Bool) -> Result<[Self], PhotonError> {
        return PhotonHelper<Self>.filter(isIncluded)
    }
    
    static func fetch(type: PhotonType? = nil, onQueue queue: DispatchQueue = DispatchQueue.global(), size: Size? = nil, limit: UInt = 0) -> Result<[Self], PhotonError> {
        return PhotonHelper.fetch(type: type, onQueue: queue, size: size, limit: limit)
    }
}

public enum PhotoType {
    case standard
    case panorama
    case hdr
    case screenshot
    case live
    case depthEffect
}

public struct Photo: Photon {
    
    public typealias PhotonType = PhotoType
    
    public let id: String
    public let data: Data
    public let size: Size
    public let type: PhotonType
    public let creationDate: Date
    public let modificationDate: Date
    public let locaitonCoordinate: LocationCoordinate?
}

public enum VideoType {
    case standard
    case streamed
    case highFrameRate
    case timelapse
    case slowMotion
}

public struct Video: Photon {
    
    public typealias PhotonType = VideoType
    
    public let id: String
    public let data: Data
    public let size: Size
    public let type: PhotonType
    public let creationDate: Date
    public let modificationDate: Date
    public let locaitonCoordinate: LocationCoordinate?
    public let duration: TimeInterval
}

public protocol PhotonContainer {
    associatedtype Photon
    
    var id: String { get }
    var name: String { get }
    var data: [Photon] { get }
}

public struct Album<Photon>: PhotonContainer {
    public let id: String
    public let name: String
    public let data: [Photon]
}


// Album that contains many burst photos
//struct BurstAlbum: PhotonContainer {
//    let id: String
//    let name: String
//    let data: [Photon]
//}

public extension Result where Success == [Photo], Failure == PhotonError {
    
    func sorted(by areInIncreasingOrder: (Photo, Photo) -> Bool) -> Result<[Photo], PhotonError> {
        return PhotonHelper<Photo>.sorted(by: areInIncreasingOrder)
    }
    
    func fetch(type: PhotoType? = nil, onQueue queue: DispatchQueue = DispatchQueue.global(), size: Size? = nil, limit: UInt = 0) -> Result<[Photo], PhotonError> {
        return PhotonHelper.fetch(type: type, onQueue: queue, size: size, limit: limit)
    }
    
}

public extension Result where Success == [Video], Failure == PhotonError {
    
    func sorted(by areInIncreasingOrder: (Video, Video) -> Bool) -> Result<[Video], PhotonError> {
        return PhotonHelper<Video>.sorted(by: areInIncreasingOrder)
    }
    
    func fetch(type: VideoType? = nil, onQueue queue: DispatchQueue = DispatchQueue.global(), size: Size? = nil, limit: UInt = 0) -> Result<[Video], PhotonError> {
        return PhotonHelper.fetch(type: type, onQueue: queue, size: size, limit: limit)
    }
    
}
