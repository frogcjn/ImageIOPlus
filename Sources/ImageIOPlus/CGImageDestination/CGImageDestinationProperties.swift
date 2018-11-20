//
//  Properties.swift
//  get-aux
//
//  Created by Cao, Jiannan on 2018/11/5.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import ImageIO
import ImageIOPlusBase
import class CoreGraphics.CGColor

/*
let kCGImageSourceTypeIdentifierHint: CFString // Source
let kCGImageSourceShouldAllowFloat: CFString
let kCGImageSourceShouldCache: CFString
 
let kCGImageSourceCreateThumbnailFromImageIfAbsent: CFString
let kCGImageSourceCreateThumbnailFromImageAlways: CFString
let kCGImageSourceThumbnailMaxPixelSize: CFString
let kCGImageSourceCreateThumbnailWithTransform: CFString
*/

/* Destination Properties, or CGImageProperties */
public extension CGImageDestination {
    struct Properties : RawKeyDictionaryWrapper {
        // CGImageSourceCopyPropertiesAtIndex
        // CGImageSourceCreateImageAtIndex
        public enum Key : String, CaseIterable {
            case lossyCompressionQuality = "kCGImageDestinationLossyCompressionQuality"
            case backgroundColor = "kCGImageDestinationBackgroundColor"
            // case CGImageProperty(String)
        }
        
        public let lossyCompressionQuality: Float?
        public let backgroundColor: CGColor?
        
        public let imageProperties: /*CGImageProperties*/[String: Any]
        
        public let rawValue: RawKeyDict
        public init(dict: Dict, rawKeyDict: RawKeyDict) {
            rawValue = rawKeyDict
            lossyCompressionQuality = dict[.lossyCompressionQuality].map(cfFloat)
            backgroundColor         = dict[.backgroundColor]        .map(cgColor)
            
            // imageProperties
            var imageProperties = rawKeyDict
            _ = imageProperties.index(forKey: Key.lossyCompressionQuality.rawValue).map{ imageProperties.remove(at: $0) }
            _ = imageProperties.index(forKey: Key.backgroundColor.rawValue).map{ imageProperties.remove(at: $0) }
            self.imageProperties = imageProperties
        }
    }
}


