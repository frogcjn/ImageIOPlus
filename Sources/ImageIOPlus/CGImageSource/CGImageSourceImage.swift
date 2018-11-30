//
//  CGImageSourceImage.swift
//  CoreVideoPlus
//
//  Created by Cao, Jiannan on 2018/11/15.
//

import ImageIO

// MARK: - ImageSourceImage

public struct CGImageSourceImage  {
    public let index: Int
    public unowned let imageSource: CGImageSource
    public init(index: Int, imageSource: CGImageSource) {
        assert(0..<CGImageSourceGetCount(imageSource) ~= index, "index out of range for CGImageSource.")
        self.index = index
        self.imageSource = imageSource
    }
}

// MARK: - Status of ImageSourceImage

extension CGImageSourceImage : CGImageSourceImageStatusProtocol {
    // status
    public var status: CGImageSourceStatus {
        return CGImageSourceGetStatusAtIndex(imageSource, index)
    }
    
    // properties
    public func properties(options: Options?) -> [String: Any]? { // CGImageProperties
        return CGImageSourceCopyPropertiesAtIndex(imageSource, index, options?.rawValue as CFDictionary?) as! [String: Any]?
    }
    
    // metadata
    public func metadata(options: Options?) -> CGImageMetadata? {
        return CGImageSourceCopyMetadataAtIndex(imageSource, index, options?.rawValue as CFDictionary?)
    }
    
    // thumbnail
    public func thumbnail(options: Options?) -> CGImage? {
        return CGImageSourceCreateThumbnailAtIndex(imageSource, index, options?.rawValue as CFDictionary?)
    }
    
    // cgImage
    public func cgImage(options: Options?) -> CGImage? {
        return CGImageSourceCreateImageAtIndex(imageSource, index, options?.rawValue as CFDictionary?)
    }
    
    // removeCache
    public func removeCache() {
        CGImageSourceRemoveCacheAtIndex(imageSource, index)
    }
}

// MARK: - Aux of ImageSourceImage
#if os(watchOS)
#else
@available(macOS 10.13, iOS 11, tvOS 11, *)
extension CGImageSourceImage : CGImageSourceImageAuxProtocol {
    public func aux(type: CGImageAuxType) -> CGImageAux? {
        return (CGImageSourceCopyAuxiliaryDataInfoAtIndex(imageSource, index, type.rawValue as CFString) as! [String: Any]?).map { CGImageAux.init(rawValue: $0, type: type)! }
    }
}
#endif
/*
 //extension CGImageSourceImage : AuxProtocol {
 
 /*public func aux(type: CGImageAuxType) -> CGImageAux? {
 return (CGImageSourceCopyAuxiliaryDataInfoAtIndex(imageSource, index, type.rawValue as CFString) as! [String: Any]?).map { CGImageAux.init(rawValue: $0, type: type)! }
 }*/
 
 /*public func rawAux(cgType: CGImageAuxType) -> CFDictionary? {
 return CGImageSourceCopyAuxAtIndex(imageSource, index, cgType.rawValue as CFString)
 }
 
 public func rawAux(type: CGImageSource.AuxType) -> CFDictionary? {
 switch type {
 case .disparityOrDepth:
 return rawAux(cgType: .disparity) ?? rawAux(cgType: .depth)
 case .matte:
 return rawAux(cgType: .portraitEffectsMatte)
 }
 }*/
 //}
 
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
 */
