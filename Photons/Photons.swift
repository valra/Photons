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

// MARK: Photon

public protocol Photon {
    associatedtype `PhotonType`
    
    var id: String { get }
    var data: Data { get }
    var size: Size { get }
    var type: PhotonType { get }
    var creationDate: Date { get }
    var modificationDate: Date { get }
    var locationCoordinate: LocationCoordinate? { get }
}

public extension Photon {
    
    static func filter(_ isIncluded: (Self) -> Bool) -> Result<[Self], PhotonError> {
        return PhotonHelper<Self>.filter(isIncluded)
    }
    
    static func fetch(type: PhotonType? = nil, onQueue queue: DispatchQueue = DispatchQueue.global(), size: Size? = nil, limit: UInt = 0) -> Result<[Self], PhotonError> {
        return PhotonHelper.fetch(type: type, onQueue: queue, size: size, limit: limit)
    }
    
    func save(onQueue queue: DispatchQueue = DispatchQueue.global()) throws {
        try PhotonHelper.savePhoton(self, onQueue: queue)
    }
}

// MARK: Photo

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
    public let locationCoordinate: LocationCoordinate?
    
    public init(id: String, data: Data, size: Size, type: PhotonType, creationDate: Date, modificationDate: Date, locationCoordinate: LocationCoordinate? = nil) {
        self.id = id
        self.data = data
        self.size = size
        self.type = type
        self.creationDate = creationDate
        self.modificationDate = modificationDate
        self.locationCoordinate = locationCoordinate
    }
}

// MARK: Video

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
    public let locationCoordinate: LocationCoordinate?
    public let duration: TimeInterval
    
    public init(id: String, data: Data, size: Size, type: PhotonType, creationDate: Date, modificationDate: Date, locationCoordinate: LocationCoordinate? = nil, duration: TimeInterval) {
        self.id = id
        self.data = data
        self.size = size
        self.type = type
        self.creationDate = creationDate
        self.modificationDate = modificationDate
        self.locationCoordinate = locationCoordinate
        self.duration = duration
    }
}

// MARK: PhotonContainer

public protocol PhotonContainer {
    associatedtype Photon
    
    var id: String { get }
    var name: String { get }
    var data: [Photon] { get }
}

// MARK: Album

public struct Album<PhotonType: Photon>: PhotonContainer {
    public let id: String
    public let name: String
    public let data: [PhotonType]
    
    public init(id: String, name: String, data: [PhotonType]) {
        self.id = id
        self.name = name
        self.data = data
    }
    
    public func save(onQueue queue: DispatchQueue = DispatchQueue.global()) throws {
        try data.save(onQueue: queue)
    }
}

// Album that contains many burst photos
//struct BurstAlbum: PhotonContainer {
//    let id: String
//    let name: String
//    let data: [Photon]
//}

// MARK: Result Extensions

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

// MARK: Array Extensions

public extension Array where Element: Photon {
    
    func save(onQueue queue: DispatchQueue = DispatchQueue.global()) throws {
        try forEach { try $0.save() }
    }
    
}
