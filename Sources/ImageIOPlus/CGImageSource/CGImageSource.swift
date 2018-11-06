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

// MARK: - Image of CGImageSource

public extension CGImageSource {
    struct Image  {
        public let index: Int
        public unowned let imageSource: CGImageSource
        public init(index: Int, imageSource: CGImageSource) {
            assert(0..<imageSource.count ~= index, "index out of range for imageSource.")
            self.index = index
            self.imageSource = imageSource
        }
    }
}

// MARK: - Collection

extension CGImageSource : CGImageSourceImageCollectionProtocol {
    public var count: Int {
        return CGImageSourceGetCount(self)
    }
    
    public subscript(_ index: Int) -> Image {
        return Image(index: index, imageSource: self)
    }
}

// MARK: - Collection with PrimaryImage

extension CGImageSource : CGImageSourceImageCollectionWithPrimaryImageProtocol {
    @available(OSX 10.14, *)
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
    public var properties: [String: Any]? {
        return properties(options: nil)
    }
    public func properties(options: Options?) -> [String: Any]? {
        return CGImageSourceCopyProperties(self, options?.rawValue as CFDictionary?) as! [String: Any]?
    }
}

// MARK: - Image with Status

extension CGImageSource.Image : CGImageSourceImageWithStatusProtocol {
    
    public var status: CGImageSourceStatus {
        return CGImageSourceGetStatusAtIndex(imageSource, index)
    }
    
    // properties
    public var properties: [String: Any]? {
        return properties(options: nil)
    }
    public func properties(options: Options?) -> [String: Any]? {
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


// MARK: - Collection with AuxiliaryImage

extension CGImageSource : CGImageSourceImageCollectionWithAuxiliaryImageProtocol {
    
}

// MARK: - Image with AuxiliaryData

@available(OSX 10.13, *)
extension CGImageSource.Image : CGImageSourceImageWithAuxiliaryDataProtocol {
    public func rawAuxiliaryData(cgType: CGImageAuxiliaryDataType) -> CFDictionary? {
        return CGImageSourceCopyAuxiliaryDataInfoAtIndex(imageSource, index, cgType.rawValue as CFString)
    }
    
    public func auxiliaryData(cgType: CGImageAuxiliaryDataType) -> AuxiliaryDataInfo? {
        let info = CGImageSourceCopyAuxiliaryDataInfoAtIndex(imageSource, index, cgType.rawValue as CFString) as! [String: Any]?
        return info.map{ AuxiliaryDataInfo(rawValue: $0)! }
    }
    
    public func rawAuxiliaryData(type: CGImageSource.AuxiliaryType) -> CFDictionary? {
        switch type {
        case .disparityOrDepth:
            return rawAuxiliaryData(cgType: .disparity) ?? rawAuxiliaryData(cgType: .depth)
        case .matte:
            return rawAuxiliaryData(cgType: .portraitEffectsMatte)
        }
    }
    
    public func auxiliaryData(type: CGImageSource.AuxiliaryType) -> AuxiliaryDataInfo? {
        switch type {
        case .disparityOrDepth:
            return auxiliaryData(cgType: .disparity) ?? auxiliaryData(cgType: .depth)
        case .matte:
            return auxiliaryData(cgType: .portraitEffectsMatte)
        }
    }
}
