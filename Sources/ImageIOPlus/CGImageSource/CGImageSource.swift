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

// MARK: - CGImageSource
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

// MARK: - Status of CGImageSource

extension CGImageSource : CGImageSourceStatusProtocol {
    // status
    public var status: CGImageSourceStatus {
        return CGImageSourceGetStatus(self)
    }
    
    public func properties(options: Options?) -> [String: Any]? { // CGImageProperties
        return CGImageSourceCopyProperties(self, options?.rawValue as CFDictionary?) as! [String: Any]?
    }
}

// MARK: - Collection of CGImageSource

extension CGImageSource : CGImageSourceCollectionProtocol {
    public var count: Int {
        return CGImageSourceGetCount(self)
    }
    
    public subscript(_ index: Int) -> CGImageSourceImage {
        return CGImageSourceImage(index: index, imageSource: self)
    }

    public var primaryImageIndex: Int? {
        let primaryImageIndex = CGImageSourceGetPrimaryImageIndex(self)
        guard 0..<count ~= primaryImageIndex else { return nil }
        return primaryImageIndex
    }
}

// MARK: - Aux of CGImageSource

extension CGImageSource : CGImageSourceAuxProtocol {

}
