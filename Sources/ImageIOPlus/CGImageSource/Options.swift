//
//  Properties.swift
//  get-aux
//
//  Created by Cao, Jiannan on 2018/11/5.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import ImageIO
import ImageIOPlusBase

/*
let kCGImageSourceTypeIdentifierHint: CFString // Source
let kCGImageSourceShouldAllowFloat: CFString
let kCGImageSourceShouldCache: CFString
 
let kCGImageSourceCreateThumbnailFromImageIfAbsent: CFString
let kCGImageSourceCreateThumbnailFromImageAlways: CFString
let kCGImageSourceThumbnailMaxPixelSize: CFString
let kCGImageSourceCreateThumbnailWithTransform: CFString
*/

public extension CGImageSource {
    struct Options : RawKeyDictionaryWrapper {
        // CGImageSourceCopyPropertiesAtIndex
        // CGImageSourceCreateImageAtIndex
        public enum Key : String {
            case typeIdentifierHint     = "kCGImageSourceTypeIdentifierHint"
            case shouldAllowFloat       = "kCGImageSourceShouldAllowFloat"
            case shouldCache            = "kCGImageSourceShouldCache"
            case shouldCacheImmediately = "kCGImageSourceShouldCacheImmediately"
            case subsampleFactor        = "kCGImageSourceSubsampleFactor" // must be an integer CFNumberRef (allowed values: 2, 4, and 8)
            case fromImageIfAbsent = "kCGImageSourceCreateThumbnailFromImageIfAbsent"  // CFBooleanRef, defult: kCFBooleanFalse
            case fromImageAlways   = "kCGImageSourceCreateThumbnailFromImageAlways" // CFBooleanRef, defult: kCFBooleanFalse
            case withTransform     = "kCGImageSourceCreateThumbnailWithTransform" // CFBooleanRef, defult: kCFBooleanFalse
            case maxPixelSize      = "kCGImageSourceThumbnailMaxPixelSize" // CFNumberRef
        }
        
        public let shouldCache: Bool?
        public let shouldCacheImmediately: Bool?
        public let shouldAllowFloat: Bool?
        public let subsampleFactor: SubsampleFactor?
        public let fromImageIfAbsent: Bool?
        public let fromImageAlways: Bool?
        public let withTransform: Bool?
        public let maxPixelSize: Int?
        
        public let rawValue: RawKeyDict
        public init(dict: Dict, rawKeyDict: RawKeyDict) {
            rawValue = rawKeyDict
            
            shouldCache            = dict[.shouldCache].map(cfBoolean)
            shouldCacheImmediately = dict[.shouldCacheImmediately].map(cfBoolean)
            shouldAllowFloat       = dict[.shouldAllowFloat].map(cfBoolean)
            subsampleFactor        = dict[.subsampleFactor].map(cfInt).map { SubsampleFactor(rawValue: $0)! }

            fromImageIfAbsent = dict[.fromImageIfAbsent].map(cfBoolean)
            fromImageAlways   = dict[.fromImageAlways].map(cfBoolean)
            withTransform     = dict[.withTransform].map(cfBoolean)
            maxPixelSize      = dict[.maxPixelSize].map(cfInt)
        }
    }
    
    enum SubsampleFactor: Int {
        case two = 2
        case four = 4
        case eight = 8
    }
}

public extension CGImageSourceImage {
    typealias Options = CGImageSource.Options
}

/* Specifies that, if possible, an image should be returned as scaled down (in height and width) by a specified factor.
 * The resulting image will be smaller and have reduced spatial quality but will otherwise have the same characteristics
 * as the full size normal image.
 * If the specified scaling factor is not supported, a larger or full size normal image will be returned.
 * Supported file formats are JPEG, HEIF, TIFF, and PNG.
 * The value of this key must be an integer CFNumberRef (allowed values: 2, 4, and 8).
 */
// public let kCGImageSourceSubsampleFactor: CFString
