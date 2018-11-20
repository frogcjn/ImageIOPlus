//
//  CVPixelFormatDescription.swift
//  ImageIOExtension
//
//  Created by Cao, Jiannan on 2018/11/2.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import CoreFoundation
import CoreVideo
import ImageIOPlusBase

// description API
public extension CVPixelFormat {
    var description: Description {
        return description(allocator: nil)
    }
    
    func description(allocator: CFAllocator?) -> Description {
        let dict = CVPixelFormatDescriptionCreateWithPixelFormatType(allocator, self.rawValue) as [NSObject: AnyObject]? as! [String: Any]
        return Description(rawValue: dict)!
    }
    
    static var allCases: [CVPixelFormat] {
        return allCases(allocator: nil)
    }
    
    static func allCases(allocator: CFAllocator?) -> [CVPixelFormat] {
        return (CVPixelFormatDescriptionArrayCreateWithAllPixelFormatTypes(allocator) as [AnyObject]? as! [OSType]).compactMap(CVPixelFormat.init)
    }
    
    static func register(pixelFormat: OSType, description: Description) {
        CVPixelFormatDescriptionRegisterDescriptionWithPixelFormatType(description.rawValue as CFDictionary, pixelFormat)
    }
}

public extension CVPixelFormat {
    struct Description : RawKeyDictionaryWrapper {
        public enum Key : String, CaseIterable {
            
            /*
             kCVPixelBufferMetalCompatibilityKey
             let kCVPixelBufferIOSurfaceOpenGLFBOCompatibilityKey: CFString
             let kCVPixelBufferIOSurfaceOpenGLTextureCompatibilityKey: CFString
             let kCVPixelBufferIOSurfaceOpenGLESFBOCompatibilityKey: CFString
             let kCVPixelBufferIOSurfaceOpenGLESTextureCompatibilityKey: CFString
             let kCVPixelBufferOpenGLTextureCacheCompatibilityKey: CFString
             */
            case pixelFormat                           = "PixelFormat"                 // kCVPixelFormatConstant

            case cgBitmapContextCompatibility          = "CGBitmapContextCompatibility"
            case cgImageCompatibility                  = "CGImageCompatibility"
            case ioSurfaceOpenGLTextureCompatibility   = "IOSurfaceOpenGLTextureCompatibility"
            case ioSurfaceOpenGLFBOCompatibility       = "IOSurfaceOpenGLFBOCompatibility"
            case ioSurfaceCoreAnimationCompatibility   = "IOSurfaceCoreAnimationCompatibility"
            case ioSurfaceOpenGLESTextureCompatibility = "IOSurfaceOpenGLESTextureCompatibility"
            case ioSurfaceOpenGLESFBOCompatibility     = "IOSurfaceOpenGLESFBOCompatibility"
            case openGLCompatibility                   = "OpenGLCompatibility"
            case openGLESCompatibility                 = "PpenGLESCompatibility"
            case openGLESTextureCacheCompatibility     = "OpenGLESTextureCacheCompatibility"
            case metalCompatibility                    = "MetalCompatibility"
            case qdCompatibility                       = "QDCompatibility"
            
            case containsAlpha              = "ContainsAlpha"               // kCVPixelFormatContainsAlpha
            case containsRGB                = "ContainsRGB"                 // kCVPixelFormatContainsRGB
            case containsGrayscale          = "ContainsGrayscale"           // kCVPixelFormatContainsGrayscale
            case containsYCbCr              = "ContainsYCbCr"               // kCVPixelFormatContainsYCbCr
            
            case componentRange             = "ComponentRange"              // kCVPixelFormatComponentRange

            case bitsPerBlock               = "BitsPerBlock"                // kCVPixelFormatBitsPerBlock
            case bitsPerComponent           = "BitsPerComponent"            // kCVPixelFormatBitsPerComponent // cannot find
            case exactRatioBetweenBytesPerRowOfPlanes = "ExactRatioBetweenBytesPerRowOfPlanes" // kCVPixelFormatExactRatioBetweenBytesPerRowOfPlanes // cannot find

            case blockWidth                 = "BlockWidth"                  // kCVPixelFormatBlockWidth
            case blockHeight                = "BlockHeight"                 // kCVPixelFormatBlockHeight
            case blockHorizontalAlignment   = "BlockHorizontalAlignment"    // kCVPixelFormatBlockHorizontalAlignment
            case blockVerticalAlignment     = "blockVerticalAlignment"      // kCVPixelFormatBlockVerticalAlignment
            
            case planes                     = "Planes"                      // kCVPixelFormatPlanes
            case components                 = "Components"                  // kCVPixelFormatComponents // cannot find
            case horizontalSubsampling      = "HorizontalSubsampling"       // kCVPixelFormatHorizontalSubsampling
            case verticalSubsampling        = "VerticalSubsampling"         // kCVPixelFormatVerticalSubsampling
            case blackBlock                 = "BlackBlock"                  // kCVPixelFormatBlackBlock
            case fillExtendedPixelsCallback = "FillExtendedPixelsCallback"  // kCVPixelFormatFillExtendedPixelsCallback

            case cgBitmapInfo               = "CGBitmapInfo"                // kCVPixelFormatCGBitmapInfo
            
            case openGLFormat               = "OpenGLFormat"                // kCVPixelFormatOpenGLFormat
            case openGLInternalFormat       = "OpenGLInternalFormat"        // kCVPixelFormatOpenGLInternalFormat
            case openGLType                 = "OpenGLType"                  // kCVPixelFormatOpenGLType
            
            case name                       = "Name"                        // kCVPixelFormatName
            case codecType                  = "CodecType"                   // kCVPixelFormatCodecType
            case fourCC                     = "FourCC"                      // kCVPixelFormatFourCC
            
            case compressionType            = "CompressionType"             // kCVPixelFormatCompressionType // cannot find
            case compressedTileWidth        = "CompressedTileWidth"         // kCVPixelFormatCompressionTileWidth // cannot find
            case compressedTileHeight       = "CompressedTileHeight"        // kCVPixelFormatCompressedTileHeight // cannot find
        }
        
        public let pixelFormat: CVPixelFormat
        
        public let cgBitmapContextCompatibility         : Bool?
        public let cgImageCompatibility                 : Bool?
        public let ioSurfaceOpenGLTextureCompatibility  : Bool?
        public let ioSurfaceOpenGLFBOCompatibility      : Bool?
        public let ioSurfaceCoreAnimationCompatibility  : Bool?
        public let ioSurfaceOpenGLESTextureCompatibility: Bool?
        public let ioSurfaceOpenGLESFBOCompatibility    : Bool?
        public let openGLCompatibility                  : Bool?
        public let openGLESCompatibility                : Bool?
        public let openGLESTextureCacheCompatibility    : Bool?
        public let metalCompatibility                   : Bool?
        public let qdCompatibility                      : Bool?
        
        public let containsAlpha    : Bool?
        public let containsRGB      : Bool?
        public let containsGrayscale: Bool?
        public let containsYCbCr    : Bool?

        public let componentRange: ComponentRange?

        public let bitsPerBlock     : Int?
        public let bitsPerComponent : Int?
        public let exactRatioBetweenBytesPerRowOfPlanes: Float?
        
        public let blockWidth              : Int?
        public let blockHeight             : Int?
        public let blockHorizontalAlignment: Int?
        public let blockVerticalAlignment  : Int?
        
        public let planes                    : Int?
        public let components                : Int?
        public let horizontalSubsampling     : Int?
        public let verticalSubsampling       : Int?
        
        public let blackBlock                : Data?
        public let fillExtendedPixelsCallback: Data?
        
        public let bitmapInfo              : CGBitmapInfo?
        
        public let openGLFormat              : String?
        public let openGLInternalFormat      : String?
        public let openGLType                : String?
        
        public let name      : String?
        public let codecType : String?
        public let fourCC    : String?
        
        public let compressionType     : String?
        public let compressedTileWidth : String?
        public let compressedTileHeight: String?
        
        
        public let rawValue: RawKeyDict
        
        public init(dict: Dict, rawKeyDict: RawKeyDict) {
            rawValue = rawKeyDict

            pixelFormat = dict[.pixelFormat].map(cfUInt32)
                .map { CVPixelFormat(rawValue: $0)! }!
            
            cgBitmapContextCompatibility          = dict[.cgBitmapContextCompatibility]         .map(cfBoolean)
            cgImageCompatibility                  = dict[.cgImageCompatibility]                 .map(cfBoolean)
            ioSurfaceOpenGLTextureCompatibility   = dict[.ioSurfaceOpenGLTextureCompatibility]  .map(cfBoolean)
            ioSurfaceOpenGLFBOCompatibility       = dict[.ioSurfaceOpenGLFBOCompatibility]      .map(cfBoolean)
            ioSurfaceCoreAnimationCompatibility   = dict[.ioSurfaceCoreAnimationCompatibility]  .map(cfBoolean)
            ioSurfaceOpenGLESTextureCompatibility = dict[.ioSurfaceOpenGLESTextureCompatibility].map(cfBoolean)
            ioSurfaceOpenGLESFBOCompatibility     = dict[.ioSurfaceOpenGLESFBOCompatibility]    .map(cfBoolean)
            openGLCompatibility                   = dict[.openGLCompatibility]                  .map(cfBoolean)
            openGLESCompatibility                 = dict[.openGLESCompatibility]                .map(cfBoolean)
            openGLESTextureCacheCompatibility     = dict[.openGLESTextureCacheCompatibility]    .map(cfBoolean)
            metalCompatibility                    = dict[.metalCompatibility]                   .map(cfBoolean)
            qdCompatibility                       = dict[.qdCompatibility]                      .map(cfBoolean)
            
            componentRange = dict[.componentRange]
                .map(cfString)
                .map { ComponentRange(rawValue: $0)! }
            
            containsAlpha     = dict[.containsAlpha]    .map(cfBoolean)
            containsRGB       = dict[.containsRGB]      .map(cfBoolean)
            containsGrayscale = dict[.containsGrayscale].map(cfBoolean)
            containsYCbCr     = dict[.containsYCbCr]    .map(cfBoolean)
            
            bitsPerBlock      = dict[.bitsPerBlock]     .map(cfInt)
            bitsPerComponent  = dict[.bitsPerComponent] .map(cfInt)

            exactRatioBetweenBytesPerRowOfPlanes = dict[.exactRatioBetweenBytesPerRowOfPlanes].map(cfFloat)
            
            blockWidth                 = dict[.blockWidth]              .map(cfInt)
            blockHeight                = dict[.blockHeight]             .map(cfInt)
            blockHorizontalAlignment   = dict[.blockHorizontalAlignment].map(cfInt)
            blockVerticalAlignment     = dict[.blockVerticalAlignment]  .map(cfInt)
            
            // TODO: 2018-11-02
            planes                     = dict[.planes]               .map(cfInt)
            components                 = dict[.components]           .map(cfInt)
            horizontalSubsampling      = dict[.horizontalSubsampling].map(cfInt)
            verticalSubsampling        = dict[.verticalSubsampling]  .map(cfInt)
            
            blackBlock                 = dict[.blackBlock]                .map(cfData)
            fillExtendedPixelsCallback = dict[.fillExtendedPixelsCallback].map(cfData)
            
            bitmapInfo                 =  dict[.cgBitmapInfo].map(cgBitmapInfo)
            
            openGLFormat         = dict[.openGLFormat]        .map(cfString)
            openGLInternalFormat = dict[.openGLInternalFormat].map(cfString)
            openGLType           = dict[.openGLType]          .map(cfString)
            
            name      = dict[.name]     .map(cfString)
            codecType = dict[.codecType].map(cfString)
            fourCC    = dict[.fourCC]   .map(cfString)
            
            compressionType      = dict[.compressionType]     .map(cfString)
            compressedTileWidth  = dict[.compressedTileWidth] .map(cfString)
            compressedTileHeight = dict[.compressedTileHeight].map(cfString)
        }
    }
}

public extension CVPixelFormat.Description {
    enum ComponentRange : String {
        case video = "VideoRange"
        case full = "FullRange"
        case wide = "WideRange"
    }
}

/*
 https://github.com/keith/Xcode.app-strings/blob/2cff6cba843d486750d7eda261d57f1e6cefea8f/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/Library/CoreSimulator/Profiles/Runtimes/watchOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/CoreVideo.framework/CoreVideo
 AlphaChannelIsOpaque
 MasteringDisplayColorVolume
 ContentLightLevelInfo
 PixelFormatType
 MemoryAllocator
 ExtendedPixelsLeft
 ExtendedPixelsTop
 ExtendedPixelsRight
 ExtendedPixelsBottom
 BytesPerRowAlignment
 CGBitmapContextCompatibility
 CGImageCompatibility
 OpenGLCompatibility
 PlaneAlignment
 IOSurfaceProperties
 IOSurfaceOpenGLTextureCompatibility
 IOSurfaceOpenGLFBOCompatibility
 IOSurfaceCoreAnimationCompatibility
 IOSurfaceOpenGLESTextureCompatibility
 IOSurfaceOpenGLESFBOCompatibility
 OpenGLESCompatibility
 OpenGLESTextureCacheCompatibility
 MetalCompatibility
 QDCompatibility
 PixelFormatDescription
 CustomMemoryLayoutCallBacks
 ExactBytesPerRow
 ExactHeight
 CacheMode
 AdjustableBaseAddressGranularity
 WorstCaseBytesPerRow
 BaseAddressAdjustment
 BytesPerRow
 BufferPoolAllocationThreshold
 BufferPoolFreeBufferNotification
 PixelBufferPoolNameKey
 FixedPointOffset
 Rotation
 ExtendedPixelsFilledKey
 FixedPointInvalidValue
 MinimumBufferCount
 MaximumBufferAge
 Name
 PixelFormat
 CodecType
 FourCC
 ContainsAlpha
 Planes
 BlockWidth
 BlockHeight
 BlockHorizontalAlignment
 BlockVerticalAlignment
 BitsPerBlock
 BlackBlock
 HorizontalSubsampling
 VerticalSubsampling
 OpenGLFormat
 OpenGLType
 OpenGLInternalFormat
 CGBitmapInfo
 BitsPerComponent
 ContainsYCbCr
 ContainsRGB
 ContainsGrayscale
 ExactRatioBetweenBytesPerRowOfPlanes
 ComponentRange
 VideoRange
 FullRange
 WideRange
 ComponentLayout
 FillExtendedPixelsCallback
 MaximumMetalTextureAge
 MaximumTextureAge
 
 PropagatedAttachments
 NonPropagatedAttachments
 QTMovieTime
 TimeValue
 TimeScale
 BufferBackingWillDeallocate
 CGColorSpace
 CVCleanAperture
 CVPreferredCleanAperture
 Width
 Height
 HorizontalOffset
 VerticalOffset
 CVFieldCount
 CVFieldDetail
 TemporalTopFirst
 TemporalBottomFirst
 SpatialFirstLineEarly
 SpatialFirstLineLate
 CVPixelAspectRatio
 HorizontalSpacing
 VerticalSpacing
 CVDisplayDimensions
 CVImageBufferGammaLevel
 CVImageBufferICCProfile
 CVImageBufferYCbCrMatrix
 ITU_R_709_2
 ITU_R_601_4
 SMPTE_240M_1995
 DCI_P3
 P3_D65
 ITU_R_2020
 CVImageBufferColorPrimaries
 EBU_3213
 SMPTE_C
 CVImageBufferTransferFunction
 Linear
 IEC_sRGB
 SMPTE_ST_428_1
 SMPTE_ST_2084_PQ
 ITU_R_2100_HLG
 aYCC
 UseGamma
 YCbCrMatrix#
 ColorPrimaries#
 TransferFunction#
 CVImageBufferChromaLocationTopField
 CVImageBufferChromaLocationBottomField
 Left
 Center
 TopLeft
 BottomLeft
 Bottom
 DV 4:2:0
 CVImageBufferChromaSubsampling
 4:2:0
 4:2:2
 4:1:1
 AlphaChannelIsOpaque
 MasteringDisplayColorVolume
 ContentLightLevelInfo
 PixelFormatType
 MemoryAllocator
 ExtendedPixelsLeft
 ExtendedPixelsTop
 ExtendedPixelsRight
 ExtendedPixelsBottom
 BytesPerRowAlignment
 CGBitmapContextCompatibility
 CGImageCompatibility
 OpenGLCompatibility
 PlaneAlignment
 IOSurfaceProperties
 IOSurfaceOpenGLTextureCompatibility
 IOSurfaceOpenGLFBOCompatibility
 IOSurfaceCoreAnimationCompatibility
 IOSurfaceOpenGLESTextureCompatibility
 IOSurfaceOpenGLESFBOCompatibility
 OpenGLESCompatibility
 OpenGLESTextureCacheCompatibility
 MetalCompatibility
 QDCompatibility
 PixelFormatDescription
 CustomMemoryLayoutCallBacks
 ExactBytesPerRow
 ExactHeight
 CacheMode
 AdjustableBaseAddressGranularity
 WorstCaseBytesPerRow
 BaseAddressAdjustment
 BytesPerRow
 BufferPoolAllocationThreshold
 BufferPoolFreeBufferNotification
 PixelBufferPoolNameKey
 FixedPointOffset
 Rotation
 ExtendedPixelsFilledKey
 FixedPointInvalidValue
 MinimumBufferCount
 MaximumBufferAge
 Name
 PixelFormat
 CodecType
 FourCC
 ContainsAlpha
 Planes
 BlockWidth
 BlockHeight
 BlockHorizontalAlignment
 BlockVerticalAlignment
 BitsPerBlock
 BlackBlock
 HorizontalSubsampling
 VerticalSubsampling
 OpenGLFormat
 OpenGLType
 OpenGLInternalFormat
 CGBitmapInfo
 BitsPerComponent
 ContainsYCbCr
 ContainsRGB
 ContainsGrayscale
 ExactRatioBetweenBytesPerRowOfPlanes
 ComponentRange
 VideoRange
 FullRange
 WideRange
 ComponentLayout
 FillExtendedPixelsCallback
 MaximumMetalTextureAge
 MaximumTextureAge
 */

/*
 0x00000001a9fbdd38 (     0x8) kCVPixelFormatName [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd40 (     0x8) kCVPixelFormatConstant [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd48 (     0x8) kCVPixelFormatCodecType [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd50 (     0x8) kCVPixelFormatFourCC [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd58 (     0x8) kCVPixelFormatContainsAlpha [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd60 (     0x8) kCVPixelFormatPlanes [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd68 (     0x8) kCVPixelFormatBlockWidth [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd70 (     0x8) kCVPixelFormatBlockHeight [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd78 (     0x8) kCVPixelFormatBlockHorizontalAlignment [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd80 (     0x8) kCVPixelFormatBlockVerticalAlignment [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd88 (     0x8) kCVPixelFormatBitsPerBlock [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd90 (     0x8) kCVPixelFormatBlackBlock [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd98 (     0x8) kCVPixelFormatHorizontalSubsampling [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdda0 (     0x8) kCVPixelFormatVerticalSubsampling [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdda8 (     0x8) kCVPixelFormatOpenGLFormat [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbddb0 (     0x8) kCVPixelFormatOpenGLType [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbddb8 (     0x8) kCVPixelFormatOpenGLInternalFormat [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbddc0 (     0x8) kCVPixelFormatQDCompatibility [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbddc8 (     0x8) kCVPixelFormatCGBitmapContextCompatibility [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbddd0 (     0x8) kCVPixelFormatCGImageCompatibility [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbddd8 (     0x8) kCVPixelFormatOpenGLCompatibility [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdde0 (     0x8) kCVPixelFormatCGBitmapInfo [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdde8 (     0x8) kCVPixelFormatBitsPerComponent [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbddf0 (     0x8) kCVPixelFormatOpenGLESCompatibility [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbddf8 (     0x8) kCVPixelFormatContainsYCbCr [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbde00 (     0x8) kCVPixelFormatContainsRGB [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbde08 (     0x8) kCVPixelFormatExactRatioBetweenBytesPerRowOfPlanes [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbde10 (     0x8) kCVPixelFormatComponentRange [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbde18 (     0x8) kCVPixelFormatComponentRange_VideoRange [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbde20 (     0x8) kCVPixelFormatComponentRange_FullRange [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbde28 (     0x8) kCVPixelFormatComponentRange_WideRange [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbde30 (     0x8) kCVPixelFormatCompressionType [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbde38 (     0x8) kCVPixelFormatCompressedTileWidth [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbde40 (     0x8) kCVPixelFormatCompressedTileHeight [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbde48 (     0x8) kCVPixelFormatComponents [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbde50 (     0x8) kCVPixelFormatFillExtendedPixelsCallback [EXT, NameNList, MangledNameNList, NList]
 */


/*
 let kCVPixelFormatContainsGrayscale: CFString
 let kCVPixelFormatComponentRange: CFString
 let kCVPixelFormatComponentRange_FullRange: CFString
 let kCVPixelFormatComponentRange_VideoRange: CFString
 let kCVPixelFormatComponentRange_WideRange: CFString
 let kCVPixelFormatContainsRGB: CFString
 let kCVPixelFormatContainsYCbCr: CFString
 let kCVPixelFormatName: CFString
 let kCVPixelFormatConstant: CFString
 let kCVPixelFormatCodecType: CFString
 let kCVPixelFormatFourCC: CFString
 let kCVPixelFormatContainsAlpha: CFString
 let kCVPixelFormatPlanes: CFString
 let kCVPixelFormatBlockWidth: CFString
 let kCVPixelFormatBlockHeight: CFString
 let kCVPixelFormatBitsPerBlock: CFString
 let kCVPixelFormatBlockHorizontalAlignment: CFString
 let kCVPixelFormatBlockVerticalAlignment: CFString
 let kCVPixelFormatBlackBlock: CFString
 let kCVPixelFormatHorizontalSubsampling: CFString
 let kCVPixelFormatVerticalSubsampling: CFString
 let kCVPixelFormatOpenGLFormat: CFString
 let kCVPixelFormatOpenGLType: CFString
 let kCVPixelFormatOpenGLInternalFormat: CFString
 let kCVPixelFormatCGBitmapInfo: CFString
 let kCVPixelFormatQDCompatibility: CFString
 let kCVPixelFormatCGBitmapContextCompatibility: CFString
 let kCVPixelFormatCGImageCompatibility: CFString
 let kCVPixelFormatOpenGLCompatibility: CFString
 let kCVPixelFormatOpenGLESCompatibility: CFString
 let kCVPixelFormatFillExtendedPixelsCallback: CFString
 */

/*
 0x00000001a9fbde58 (     0x8) kCVMetalTextureCacheMaximumTextureAgeKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbde60 (     0x8) kCVOpenGLESTextureCacheMaximumTextureAgeKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbde68 (     0x8) kCVMetalTextureUsage [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb58 (     0x8) kCVPrefixForUnrecognizedYCbCrMatrixCodePoint [PEXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb60 (     0x8) kCVPrefixForUnrecognizedColorPrimariesCodePoint [PEXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb68 (     0x8) kCVPrefixForUnrecognizedTransferFunctionCodePoint [PEXT, NameNList, MangledNameNList, NList]
 */

