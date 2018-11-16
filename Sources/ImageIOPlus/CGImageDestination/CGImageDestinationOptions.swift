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

public extension CGImageDestination {
    struct Options : RawKeyDictionaryWrapper {
        // CGImageSourceCopyPropertiesAtIndex
        // CGImageSourceCreateImageAtIndex
        public enum Key : String {
            case lossyCompressionQuality = "kCGImageDestinationLossyCompressionQuality"
            case backgroundColor = "kCGImageDestinationBackgroundColor"
            // case CGImageProperty(String)
        }
        
        public let lossyCompressionQuality: Float?
        public let backgroundColor: CGColor?
        
        public let imageProperties: [String: Any]
        
        public let rawValue: RawKeyDict
        public init(dict: Dict, rawKeyDict: RawKeyDict) {
            rawValue = rawKeyDict
            lossyCompressionQuality = dict[.lossyCompressionQuality].map(cfFloat)
            backgroundColor = dict[.backgroundColor].map { $0 as! CGColor }
            
            imageProperties = rawKeyDict
        }
    }
}


