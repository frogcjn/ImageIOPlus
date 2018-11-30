//
//  CGImageSourceDestination.swift
//  CoreVideoPlus
//
//  Created by Cao, Jiannan on 2018/11/15.
//

import ImageIO
import struct Foundation.URL
import struct Foundation.Data
import struct ImageIOPlusBase.UTI

public extension CGImageDestination {
    
    // typeID
    class var typeID: CFTypeID {
        return CGImageDestinationGetTypeID()
    }
    
    // create
    class func `init`(url: URL, type: UTI, count: Int) -> CGImageDestination? {
        return CGImageDestinationCreateWithURL(url as CFURL, type.rawValue as CFString, count, nil)
    }
    
    class func `init`(data: Data, type: UTI, count: Int) -> CGImageDestination? {
        return CGImageDestinationCreateWithData(data as! CFMutableData, type.rawValue as CFString, count, nil)
    }
    
    class func `init`(dataConsumer: CGDataConsumer, type: UTI, count: Int) -> CGImageDestination? {
        return CGImageDestinationCreateWithDataConsumer(dataConsumer, type.rawValue as CFString, count, nil)
    }
    
    // add image
    public func addImage(_ image: CGImage, properties: Properties? = nil) {
        CGImageDestinationAddImage(self, image, properties?.rawValue as CFDictionary?)
    }
    
    public func addImage(imageSource: CGImageSource, index: Int, properties: Properties? = nil) {
        CGImageDestinationAddImageFromSource(self, imageSource, index, properties?.rawValue as CFDictionary?)
    }
    
    // add image and metadata
    public func addImage(_ image: CGImage, metadata: CGImageMetadata?, properties: Properties? = nil) {
        CGImageDestinationAddImageAndMetadata(self, image, metadata, properties?.rawValue as CFDictionary?)
    }
    
    // add aux
    #if os(watchOS)
    #else
    @available(macOS 10.13, iOS 11, tvOS 11, *)
    public func addAux(_ aux: CGImageAux) {
        CGImageDestinationAddAuxiliaryDataInfo(self, aux.type.rawValue as CFString, aux.info.rawValue as CFDictionary)
    }
    #endif
    
    // supported UTI
    public static var supportedUTIs: [UTI] {
        return (CGImageDestinationCopyTypeIdentifiers() as [AnyObject] as! [CFString] as [String]).map(UTI.init(rawValue:))
    }
    
    public static func supportsUTI(_ type: UTI) -> Bool {
        return supportedUTIs.contains(type)
    }
    
    // Settings Properties
    public func setProperties(_ properties: Properties) {
        CGImageDestinationSetProperties(self, properties.rawValue as CFDictionary)
    }
    
    // finalize
    public func finalize() -> Bool {
        return CGImageDestinationFinalize(self)
    }
}
