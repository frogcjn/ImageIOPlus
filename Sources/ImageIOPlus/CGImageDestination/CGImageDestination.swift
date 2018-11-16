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
    public func addImage(cgImage: CGImage, properties: [String : Any]? = nil) { // Destination Properties, or CGImageProperties
        CGImageDestinationAddImage(self, cgImage, properties as CFDictionary?)
    }
    
    public func addImage(imageSource: CGImageSource, index: Int, properties: [String : Any]? = nil) { // Destination Properties, or CGImageProperties
        CGImageDestinationAddImageFromSource(self, imageSource, index, properties as CFDictionary?)
    }
    
    // add image and metadata
    public func addImage(cgImage: CGImage, metadata: CGImageMetadata?, options: [String : Any]? = nil) { // ??
        CGImageDestinationAddImageAndMetadata(self, cgImage, metadata, options as CFDictionary?)
    }
    
    // add aux
    public func addAux(type: CGImageAuxType, aux: CGImageAux) {
        CGImageDestinationAddAuxiliaryDataInfo(self, type.rawValue as CFString, aux.rawValue as CFDictionary)
    }
    
    // supported UTI
    public static var supportedUTIs: [UTI] {
        return (CGImageDestinationCopyTypeIdentifiers() as [AnyObject] as! [CFString] as [String]).map(UTI.init(rawValue:))
    }
    
    public static func supportsUTI(_ type: UTI) -> Bool {
        return supportedUTIs.contains(type)
    }
    
    // Settings Properties
    public func setProperties(_ properties: [String : Any]?) { // Destination Properties, or CGImageProperties
        CGImageDestinationSetProperties(self, properties as CFDictionary?)
    }
    
    // finalize
    public func finalize() -> Bool {
        return CGImageDestinationFinalize(self)
    }
}
