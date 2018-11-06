//
//  CVPixelBuffer.swift
//  ImageIOExtension
//
//  Created by Cao, Jiannan on 2018/11/2.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//
import CoreVideo
import ImageIOPlusBase

public extension CVBuffer {
    struct Attributes : RawKeyDictionaryWrapper {
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
        
        public let baseAddressAdjustment                : Int?
        public let width                                : Int?
        public let height                               : Int?
        public let bytesPerRow                          : Int?
        public let bytesPerRowAlignment                 : Int?
        
        public let exactWidth                           : Int?
        public let exactHeight                          : Int?
        public let exactBytesPerRow                     : Int?
        
        public let extendedPixelsLeft                   : Int?
        public let extendedPixelsTop                    : Int?
        public let extendedPixelsRight                  : Int?
        public let extendedPixelsBottom                 : Int?
        public let extendedPixelsFilled                 : Int?
        
        public let planeAlignment                       : Int?
        
        public let memoryAllocator                      : CFAllocator?
        public let customMemoryLayoutCallbacks          : Data?
        
        public let pixelFormatDescription               : String?
        
        public let cacheMode                            : String?
        
        public let fixedPointOffset                     : Int?
        public let fixedPointInvalidValue               : Int?
        public let rotation                             : String?
        
        public let ioSurfaceProperties                  : [IOSurfacePropertyKey: Any]?
        
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
            
            baseAddressAdjustment                = dict[.baseAddressAdjustment].map(cfInt)
            width                                = dict[.width].map(cfInt)
            height                               = dict[.height].map(cfInt)
            bytesPerRow                          = dict[.bytesPerRow].map(cfInt)
            bytesPerRowAlignment                 = dict[.bytesPerRowAlignment].map(cfInt)
            
            exactWidth                           = dict[.exactWidth].map(cfInt)
            exactHeight                          = dict[.exactHeight].map(cfInt)
            exactBytesPerRow                     = dict[.exactBytesPerRow].map(cfInt)
            
            extendedPixelsLeft                   = dict[.extendedPixelsLeft].map(cfInt)
            extendedPixelsTop                    = dict[.extendedPixelsTop].map(cfInt)
            extendedPixelsRight                  = dict[.extendedPixelsRight].map(cfInt)
            extendedPixelsBottom                 = dict[.extendedPixelsBottom].map(cfInt)
            extendedPixelsFilled                 = dict[.extendedPixelsFilled].map(cfInt)
            
            planeAlignment                       = dict[.planeAlignment].map(cfInt)
            
            memoryAllocator                      = dict[.memoryAllocator].map{ $0 as! CFAllocator }
            customMemoryLayoutCallbacks          = dict[.customMemoryLayoutCallbacks].map(cfData)
            
            pixelFormatDescription               = dict[.pixelFormatDescription].map(cfString)
            
            cacheMode                            = dict[.cacheMode].map(cfString)
            
            fixedPointOffset                     = dict[.fixedPointOffset].map(cfInt)
            fixedPointInvalidValue               = dict[.fixedPointInvalidValue].map(cfInt)
            rotation                             = dict[.rotation].map(cfString)
            
            ioSurfaceProperties                  = dict[.ioSurfaceProperties].map(cfDictWithStringKey).map { [IOSurfacePropertyKey: Any].init(rawKeyDict: $0) } //
        }
    }
}

public extension CVBuffer.Attributes {
    enum Key : String {
        
        // CVBuffer
        case propagatedAttachments                = "PropagatedAttachments" // kCVBufferPropagatedAttachmentsKey
        case nonPropagatedAttachments             = "NonPropagatedAttachments" // kCVBufferNonPropagatedAttachmentsKey
        
        // CVPixelBuffer
        case pixelFormat                           = "PixelFormatType" // kCVPixelBufferPixelFormatTypeKey, OSType, [OSType] [The value for this key may be a single CFNumber value or an array (CFArray) containing multiple CFNumber values.]
        
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

        case baseAddressAdjustment                = "BaseAddressAdjustment" // Int

        case width                                = "Width" // Int
        case height                               = "Height" // Int
        case bytesPerRow                          = "BytesPerRow" // Int
        case bytesPerRowAlignment                 = "BytesPerRowAlignment" // Int

        case exactWidth                           = "ExactWidth" // Int
        case exactHeight                          = "ExactHeight" // Int
        case exactBytesPerRow                     = "ExactBytesPerRow" // Int

        case extendedPixelsLeft                   = "ExtendedPixelsLeft" // Int
        case extendedPixelsTop                    = "ExtendedPixelsTop" // Int
        case extendedPixelsRight                  = "ExtendedPixelsRight" // Int
        case extendedPixelsBottom                 = "ExtendedPixelsBottom" // Int
        case extendedPixelsFilled                 = "ExtendedPixelsFilled" // Int
        
        case planeAlignment                       = "PlaneAlignment" // Int

        case memoryAllocator                      = "MemoryAllocator" // kCVPixelBufferMemoryAllocatorKey: CFAllocatorRef
        case customMemoryLayoutCallbacks          = "CustomMemoryLayoutCallbacks" // Data

        case pixelFormatDescription               = "PixelFormatDescription" // String

        case cacheMode                            = "CacheMode" // String

        case fixedPointOffset                     = "FixedPointOffset" // Int
        case fixedPointInvalidValue               = "FixedPointInvalidValue" // Int
        case rotation                             = "Rotation" // String

        case ioSurfaceProperties                  = "IOSurfaceProperties" // CFDictionary [IOSurfacePropertyKey: Any]
    }
}

/*
 /* The following two keys are useful with the CoreVideo pool and texture cache APIs so that you can specify
 an initial set of default buffer attachments to automatically be attached to the buffer when it is created. */
 @available(OSX 10.4, *)
 public let kCVBufferPropagatedAttachmentsKey: CFString
 @available(OSX 10.4, *)
 public let kCVBufferNonPropagatedAttachmentsKey: CFString
 
 */
/*
 https://ios.ddf.net/symbols/198C8BB3-7D7A-35D2-A02B-E30B4C908B99
 0x00000001a9fbd9d8 (     0x8) kCVImageBufferCGColorSpaceKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbd9e0 (     0x8) kCVImageBufferCleanApertureKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbd9e8 (     0x8) kCVImageBufferPreferredCleanApertureKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbd9f0 (     0x8) kCVImageBufferCleanApertureWidthKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbd9f8 (     0x8) kCVImageBufferCleanApertureHeightKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda00 (     0x8) kCVImageBufferCleanApertureHorizontalOffsetKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda08 (     0x8) kCVImageBufferCleanApertureVerticalOffsetKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda10 (     0x8) kCVImageBufferFieldCountKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda18 (     0x8) kCVImageBufferFieldDetailKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda20 (     0x8) kCVImageBufferFieldDetailTemporalTopFirst [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda28 (     0x8) kCVImageBufferFieldDetailTemporalBottomFirst [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda30 (     0x8) kCVImageBufferFieldDetailSpatialFirstLineEarly [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda38 (     0x8) kCVImageBufferFieldDetailSpatialFirstLineLate [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda40 (     0x8) kCVImageBufferPixelAspectRatioKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda48 (     0x8) kCVImageBufferPixelAspectRatioHorizontalSpacingKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda50 (     0x8) kCVImageBufferPixelAspectRatioVerticalSpacingKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda58 (     0x8) kCVImageBufferDisplayDimensionsKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda60 (     0x8) kCVImageBufferDisplayWidthKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda68 (     0x8) kCVImageBufferDisplayHeightKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda70 (     0x8) kCVImageBufferGammaLevelKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda78 (     0x8) kCVImageBufferICCProfileKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda80 (     0x8) kCVImageBufferYCbCrMatrixKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda88 (     0x8) kCVImageBufferYCbCrMatrix_ITU_R_709_2 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda90 (     0x8) kCVImageBufferYCbCrMatrix_ITU_R_601_4 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbda98 (     0x8) kCVImageBufferYCbCrMatrix_SMPTE_240M_1995 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdaa0 (     0x8) kCVImageBufferYCbCrMatrix_DCI_P3 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdaa8 (     0x8) kCVImageBufferYCbCrMatrix_P3_D65 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdab0 (     0x8) kCVImageBufferYCbCrMatrix_ITU_R_2020 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdab8 (     0x8) kCVImageBufferColorPrimariesKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdac0 (     0x8) kCVImageBufferColorPrimaries_ITU_R_709_2 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdac8 (     0x8) kCVImageBufferColorPrimaries_EBU_3213 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdad0 (     0x8) kCVImageBufferColorPrimaries_SMPTE_C [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdad8 (     0x8) kCVImageBufferColorPrimaries_P22 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdae0 (     0x8) kCVImageBufferColorPrimaries_DCI_P3 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdae8 (     0x8) kCVImageBufferColorPrimaries_P3_D65 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdaf0 (     0x8) kCVImageBufferColorPrimaries_ITU_R_2020 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdaf8 (     0x8) kCVImageBufferTransferFunctionKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb00 (     0x8) kCVImageBufferTransferFunction_ITU_R_709_2 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb08 (     0x8) kCVImageBufferTransferFunction_SMPTE_240M_1995 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb10 (     0x8) kCVImageBufferTransferFunction_Linear [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb18 (     0x8) kCVImageBufferTransferFunction_sRGB [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb20 (     0x8) kCVImageBufferTransferFunction_ITU_R_2020 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb28 (     0x8) kCVImageBufferTransferFunction_SMPTE_ST_428_1 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb30 (     0x8) kCVImageBufferTransferFunction_SMPTE_ST_2084_PQ [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb38 (     0x8) kCVImageBufferTransferFunction_ITU_R_2100_HLG [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb40 (     0x8) kCVImageBufferTransferFunction_ARIB_STD_B67_HLG [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb48 (     0x8) kCVImageBufferTransferFunction_aYCC [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb50 (     0x8) kCVImageBufferTransferFunction_UseGamma [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb70 (     0x8) kCVImageBufferChromaLocationTopFieldKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb78 (     0x8) kCVImageBufferChromaLocationBottomFieldKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb80 (     0x8) kCVImageBufferChromaLocation_Left [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb88 (     0x8) kCVImageBufferChromaLocation_Center [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb90 (     0x8) kCVImageBufferChromaLocation_TopLeft [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdb98 (     0x8) kCVImageBufferChromaLocation_Top [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdba0 (     0x8) kCVImageBufferChromaLocation_BottomLeft [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdba8 (     0x8) kCVImageBufferChromaLocation_Bottom [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdbb0 (     0x8) kCVImageBufferChromaLocation_DV420 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdbb8 (     0x8) kCVImageBufferChromaSubsamplingKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdbc0 (     0x8) kCVImageBufferChromaSubsampling_420 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdbc8 (     0x8) kCVImageBufferChromaSubsampling_422 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdbd0 (     0x8) kCVImageBufferChromaSubsampling_411 [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdbd8 (     0x8) kCVImageBufferAlphaChannelIsOpaque [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdbe0 (     0x8) kCVImageBufferMasteringDisplayColorVolumeKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdbe8 (     0x8) kCVImageBufferContentLightLevelInfoKey [EXT, NameNList, MangledNameNList, NList]
 */

/*
 
 let kCVPixelBufferMemoryAllocatorKey: CFString
 let kCVPixelBufferPixelFormatTypeKey: CFString
 let kCVPixelBufferWidthKey: CFString
 let kCVPixelBufferHeightKey: CFString
 let kCVPixelBufferExtendedPixelsLeftKey: CFString
 let kCVPixelBufferExtendedPixelsTopKey: CFString
 let kCVPixelBufferExtendedPixelsRightKey: CFString
 let kCVPixelBufferExtendedPixelsBottomKey: CFString
 let kCVPixelBufferBytesPerRowAlignmentKey: CFString
 let kCVPixelBufferPlaneAlignmentKey: CFString
 let kCVPixelBufferIOSurfacePropertiesKey: CFString
 let kCVPixelBufferOpenGLESCompatibilityKey: CFString
 let kCVPixelBufferCGBitmapContextCompatibilityKey: CFString
 let kCVPixelBufferCGImageCompatibilityKey: CFString
 let kCVPixelBufferOpenGLCompatibilityKey: CFString
 let kCVPixelBufferMetalCompatibilityKey: CFString
 let kCVPixelBufferIOSurfaceCoreAnimationCompatibilityKey: CFString
 let kCVPixelBufferIOSurfaceOpenGLFBOCompatibilityKey: CFString
 let kCVPixelBufferIOSurfaceOpenGLTextureCompatibilityKey: CFString
 let kCVPixelBufferOpenGLESTextureCacheCompatibilityKey: CFString
 let kCVPixelBufferOpenGLTextureCacheCompatibilityKey: CFString
 let kCVPixelBufferIOSurfaceOpenGLESFBOCompatibilityKey: CFString
 let kCVPixelBufferIOSurfaceOpenGLESTextureCompatibilityKey: CFString
 */
/*
 0x00000001a9fbdbf0 (     0x8) kCVPixelBufferPixelFormatTypeKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdbf8 (     0x8) kCVPixelBufferMemoryAllocatorKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc00 (     0x8) kCVPixelBufferWidthKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc08 (     0x8) kCVPixelBufferHeightKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc10 (     0x8) kCVPixelBufferExtendedPixelsLeftKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc18 (     0x8) kCVPixelBufferExtendedPixelsTopKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc20 (     0x8) kCVPixelBufferExtendedPixelsRightKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc28 (     0x8) kCVPixelBufferExtendedPixelsBottomKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc30 (     0x8) kCVPixelBufferBytesPerRowAlignmentKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc38 (     0x8) kCVPixelBufferCGBitmapContextCompatibilityKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc40 (     0x8) kCVPixelBufferCGImageCompatibilityKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc48 (     0x8) kCVPixelBufferOpenGLCompatibilityKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc50 (     0x8) kCVPixelBufferPlaneAlignmentKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc58 (     0x8) kCVPixelBufferIOSurfacePropertiesKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc60 (     0x8) kCVPixelBufferIOSurfaceOpenGLTextureCompatibilityKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc68 (     0x8) kCVPixelBufferIOSurfaceOpenGLFBOCompatibilityKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc70 (     0x8) kCVPixelBufferIOSurfaceCoreAnimationCompatibilityKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc78 (     0x8) kCVPixelBufferIOSurfaceOpenGLESTextureCompatibilityKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc80 (     0x8) kCVPixelBufferIOSurfaceOpenGLESFBOCompatibilityKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc88 (     0x8) kCVPixelBufferOpenGLESCompatibilityKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc90 (     0x8) kCVPixelBufferOpenGLESTextureCacheCompatibilityKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdc98 (     0x8) kCVPixelBufferMetalCompatibilityKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdca0 (     0x8) kCVPixelBufferQDCompatibilityKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdca8 (     0x8) kCVPixelBufferPixelFormatDescriptionKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdcb0 (     0x8) kCVPixelBufferCustomMemoryLayoutCallbacksKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdcb8 (     0x8) kCVPixelBufferExactBytesPerRowKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdcc0 (     0x8) kCVPixelBufferExactHeightKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdcc8 (     0x8) kCVPixelBufferCacheModeKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdcd0 (     0x8) kCVPixelBufferPoolAdjustableBaseAddressGranularityKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdcd8 (     0x8) kCVPixelBufferPoolWorstCaseBytesPerRowKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdce0 (     0x8) kCVPixelBufferBaseAddressAdjustmentKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdce8 (     0x8) kCVPixelBufferBytesPerRowKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdcf0 (     0x8) kCVPixelBufferPoolAllocationThresholdKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdcf8 (     0x8) kCVPixelBufferPoolFreeBufferNotification [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd00 (     0x8) kCVPixelBufferPoolNameKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd08 (     0x8) kCVPixelBufferFixedPointOffsetKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd10 (     0x8) kCVPixelBufferRotationKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd18 (     0x8) kCVPixelBufferExtendedPixelsFilledKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd20 (     0x8) kCVPixelBufferFixedPointInvalidValueKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd28 (     0x8) kCVPixelBufferPoolMinimumBufferCountKey [EXT, NameNList, MangledNameNList, NList]
 0x00000001a9fbdd30 (     0x8) kCVPixelBufferPoolMaximumBufferAgeKey [EXT, NameNList, MangledNameNList, NList]
 */

