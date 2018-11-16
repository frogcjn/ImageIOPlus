//
//  CGImageSource.swift
//  ImageIOExtension
//
//  Created by Cao, Jiannan on 2018/10/18.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import ImageIO
import struct Foundation.URL
import struct Foundation.Data

public extension CGImageSource {
    
    // typeID
    class var typeID: CFTypeID {
        return CGImageSourceGetTypeID()
    }
    
    // create
    class func `init`(url: URL, options: Options? = nil) -> CGImageSource? {
        return CGImageSourceCreateWithURL(url as CFURL, options?.rawValue as CFDictionary?)
    }
    class func `init`(data: Data, options: Options? = nil) -> CGImageSource? {
        return CGImageSourceCreateWithData(data as CFData, options?.rawValue as CFDictionary?)
    }
    class func `init`(dataProvider provider: CGDataProvider, options: Options? = nil) -> CGImageSource? {
        return CGImageSourceCreateWithDataProvider(provider, options?.rawValue as CFDictionary?)
    }
    class func `init`(incremental: Void, options: Options? = nil) -> CGImageSource {
        return CGImageSourceCreateIncremental(options?.rawValue as CFDictionary?)
    }
    
    // update
    func update(dataProvider: CGDataProvider, final: Bool) {
        CGImageSourceUpdateDataProvider(self, dataProvider as CGDataProvider, final)
    }
    func update(data: Data, final: Bool) {
        CGImageSourceUpdateData(self, data as CFData, final)
    }
    
    // type
    var type: String? {
        return CGImageSourceGetType(self) as String?
    }
    var typeIdentifiers : [String]? {
        return CGImageSourceCopyTypeIdentifiers() as? [String]
    }
}

// MARK: - Collection

extension CGImageSource : CGImageSourceImageCollectionProtocol {
    public var count: Int {
        return CGImageSourceGetCount(self)
    }
    
    public subscript(_ index: Int) -> CGImageSourceImage {
        return CGImageSourceImage(index: index, imageSource: self)
    }
}

// MARK: - Collection with PrimaryImage

extension CGImageSource : CGImageSourceImageCollectionWithPrimaryImageProtocol {
    public var primaryImageIndex: Int? {
        let primaryImageIndex = CGImageSourceGetPrimaryImageIndex(self)
        guard 0..<count ~= primaryImageIndex else { return nil }
        return primaryImageIndex
    }
}

// MARK: - Collection with Status

extension CGImageSource : CGImageSourceCollectionWithStatusProtocol {
    // status
    public var status: CGImageSourceStatus {
        return CGImageSourceGetStatus(self)
    }
    
    // properties
    public var properties: [String: Any]? { // CGImageProperties
        return properties(options: nil)
    }
    public func properties(options: Options?) -> [String: Any]? { // CGImageProperties
        return CGImageSourceCopyProperties(self, options?.rawValue as CFDictionary?) as! [String: Any]?
    }
}

// MARK: - Image with Status

extension CGImageSourceImage : CGImageSourceImageWithStatusProtocol {
    // status
    public var status: CGImageSourceStatus {
        return CGImageSourceGetStatusAtIndex(imageSource, index)
    }
    
    // properties
    public var properties: [String: Any]? { // CGImageProperties
        return properties(options: nil)
    }
    public func properties(options: Options?) -> [String: Any]? { // CGImageProperties
        return CGImageSourceCopyPropertiesAtIndex(imageSource, index, options?.rawValue as CFDictionary?) as! [String: Any]?
    }
    
    // metadata
    public var metadata: CGImageMetadata? {
        return metadata(options: nil)
    }
    public func metadata(options: Options?) -> CGImageMetadata? {
        return CGImageSourceCopyMetadataAtIndex(imageSource, index, options?.rawValue as CFDictionary?)
    }
    
    // thumbnail
    public var thumbnail: CGImage? {
        return thumbnail(options: nil)
    }
    public func thumbnail(options: Options?) -> CGImage? {
        return CGImageSourceCreateThumbnailAtIndex(imageSource, index, options?.rawValue as CFDictionary?)
    }
    
    // cgImage
    public var cgImage: CGImage? {
        return cgImage(options: nil)
    }
    public func cgImage(options: Options?) -> CGImage? {
        return CGImageSourceCreateImageAtIndex(imageSource, index, options?.rawValue as CFDictionary?)
    }
    
    public func removeCache() {
        CGImageSourceRemoveCacheAtIndex(imageSource, index)
    }
}


// MARK: - Collection with AuxImage

extension CGImageSource : CGImageSourceImageCollectionWithAuxImageProtocol {
    
}

// MARK: - Image with aux

extension CGImageSourceImage : CGImageSourceImageWithAuxProtocol {
    /*public func rawAux(cgType: CGImageAuxType) -> CFDictionary? {
        return CGImageSourceCopyAuxAtIndex(imageSource, index, cgType.rawValue as CFString)
    }*/
    
    public func aux(type: CGImageAuxType) -> CGImageAux? {
        return (CGImageSourceCopyAuxiliaryDataInfoAtIndex(imageSource, index, type.rawValue as CFString) as! [String: Any]?).map { CGImageAux.init(rawValue: $0)! }
    }
    
    /*public func rawAux(type: CGImageSource.AuxType) -> CFDictionary? {
        switch type {
        case .disparityOrDepth:
            return rawAux(cgType: .disparity) ?? rawAux(cgType: .depth)
        case .matte:
            return rawAux(cgType: .portraitEffectsMatte)
        }
    }*/
}

extension CGImageSourceImage {
    /*public func aux(at: AT) -> CGImageAux? {
        switch at {
        case .disparityOrDepth:
            return aux(type: .disparity) ?? aux(type: .depth)
        case .matte:
            return aux(type: .portraitEffectsMatte)
        }
    }*/
}
