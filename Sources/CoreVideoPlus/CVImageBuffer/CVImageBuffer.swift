//
//  CVImageBuffer+.swift
//  ImageIOExtension
//
//  Created by Cao, Jiannan on 2018/11/1.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import CoreFoundation
import CoreVideo

public extension CVImageBuffer {
    /*!
     @function   CVImageBufferGetEncodedSize
     @abstract   Returns the full encoded dimensions of a CVImageBuffer.  For example, for an NTSC DV frame this would be 720x480
     @result     A CGSize returning the full encoded size of the buffer
     Returns zero size if called with a non-CVImageBufferRef type or NULL.
     */
    var encodedSize: CGSize {
        return CVImageBufferGetEncodedSize(self)
    }
    
    /*!
     @function   CVImageBufferGetDisplaySize
     @abstract   Returns the nominal output display size (in square pixels) of a CVImageBuffer.
     For example, for an NTSC DV frame this would be 640x480
     @result     A CGSize returning the nominal display size of the buffer
     Returns zero size if called with a non-CVImageBufferRef type or NULL.
     */
    var displaySize: CGSize {
        return CVImageBufferGetDisplaySize(self)
    }
    
    /*!
     @function   CVImageBufferGetCleanRect
     @abstract   Returns the source rectangle of a CVImageBuffer that represents the clean aperture
     of the buffer in encoded pixels.    For example, an NTSC DV frame would return a CGRect with an
     origin of 8,0 and a size of 704,480.
     Note that the origin of this rect always the lower left    corner.   This is the same coordinate system as
     used by CoreImage.
     @result     A CGSize returning the nominal display size of the buffer
     Returns zero rect if called with a non-CVImageBufferRef type or NULL.
     */
    var cleanRect: CGRect {
        return CVImageBufferGetCleanRect(self)
    }
    
    /*!
     @function   CVImageBufferGetColorSpace
     @abstract   Returns the color space of a CVImageBuffer.
     @result     A CGColorSpaceRef representing the color space of the buffer.
     Returns NULL if called with a non-CVImageBufferRef type or NULL.
     */
    #if os(macOS)
    var colorSpace: Unmanaged<CGColorSpace>? {
        return CVImageBufferGetColorSpace(self)
    }
    #endif
    
    
    /*!
     @function   CVImageBufferIsFlipped
     @abstract   Returns whether the image is flipped vertically or not.
     @result     True if 0,0 in the texture is upper left, false if 0,0 is lower left.
     */
    var isFlipped: Bool {
        return CVImageBufferIsFlipped(self)
    }
}

@available(macOS 10.12, iOS 10, tvOS 10, watchOS 3, *)
public extension CVImageBuffer {
    /*!
     @function   CVImageBufferCreateColorSpaceFromAttachments
     @abstract   Attempts to synthesize a CGColorSpace from an image buffer's attachments.
     @param      attachments A CFDictionary of attachments for an image buffer, obtained using CVBufferGetAttachments().
     @result     A CGColorSpaceRef representing the color space of the buffer.
     Returns NULL if the attachments dictionary does not contain the information required to synthesize a CGColorSpace.
     @discussion
     To generate a CGColorSpace, the attachments dictionary should include values for either:
     1. kCVImageBufferICCProfile
     2. kCVImageBufferColorPrimariesKey, kCVImageBufferTransferFunctionKey, and kCVImageBufferYCbCrMatrixKey (and possibly kCVImageBufferGammaLevelKey)
     The client is responsible for releasing the CGColorSpaceRef when it is done with it (CGColorSpaceRelease() or CFRelease())
     
     */
    class func colorSpace(from attachments: Attachments) -> CGColorSpace? {
        let attachments = attachments.rawValue as CFDictionary
        let colorSpace = CVImageBufferCreateColorSpaceFromAttachments(attachments)
        
        return colorSpace?.takeUnretainedValue()
    }
}

/*
 // For legacy reasons CVImageBuffer.h includes CoreGraphics.h and ApplicationServices.h
 
 public let kCVImageBufferCGColorSpaceKey: CFString // CGColorSpaceRef
 public let kCVImageBufferCleanApertureKey: CFString // CFDictionary containing the following four keys
 public let kCVImageBufferCleanApertureWidthKey: CFString // CFNumber
 public let kCVImageBufferCleanApertureHeightKey: CFString // CFNumber
 public let kCVImageBufferCleanApertureHorizontalOffsetKey: CFString // CFNumber, horizontal offset from center of image buffer
 public let kCVImageBufferCleanApertureVerticalOffsetKey: CFString // CFNumber, vertical offset from center of image buffer
 public let kCVImageBufferPreferredCleanApertureKey: CFString // CFDictionary containing same keys as kCVImageBufferCleanApertureKey
 
 public let kCVImageBufferFieldCountKey: CFString // CFNumber
 public let kCVImageBufferFieldDetailKey: CFString // CFString with one of the following four values
 public let kCVImageBufferFieldDetailTemporalTopFirst: CFString // CFString
 public let kCVImageBufferFieldDetailTemporalBottomFirst: CFString // CFString
 public let kCVImageBufferFieldDetailSpatialFirstLineEarly: CFString // CFString
 public let kCVImageBufferFieldDetailSpatialFirstLineLate: CFString // CFString
 
 public let kCVImageBufferPixelAspectRatioKey: CFString // CFDictionary with the following two keys
 public let kCVImageBufferPixelAspectRatioHorizontalSpacingKey: CFString // CFNumber
 public let kCVImageBufferPixelAspectRatioVerticalSpacingKey: CFString // CFNumber
 
 public let kCVImageBufferDisplayDimensionsKey: CFString // CFDictionary with the following two keys
 public let kCVImageBufferDisplayWidthKey: CFString // CFNumber
 public let kCVImageBufferDisplayHeightKey: CFString // CFNumber
 
 public let kCVImageBufferGammaLevelKey: CFString // CFNumber describing the gamma level, used in absence of (or ignorance of) kCVImageBufferTransferFunctionKey
 
 public let kCVImageBufferICCProfileKey: CFString // CFData representation of the ICC profile
 
 public let kCVImageBufferYCbCrMatrixKey: CFString // CFString describing the color matrix for YCbCr->RGB. This key can be one of the following values:
 public let kCVImageBufferYCbCrMatrix_ITU_R_709_2: CFString // CFString
 public let kCVImageBufferYCbCrMatrix_ITU_R_601_4: CFString // CFString
 public let kCVImageBufferYCbCrMatrix_SMPTE_240M_1995: CFString // CFString
 public let kCVImageBufferYCbCrMatrix_DCI_P3: CFString // CFString
 public let kCVImageBufferYCbCrMatrix_P3_D65: CFString // CFString
 public let kCVImageBufferYCbCrMatrix_ITU_R_2020: CFString // CFString
 
 public let kCVImageBufferColorPrimariesKey: CFString // CFString describing the color primaries. This key can be one of the following values
 public let kCVImageBufferColorPrimaries_ITU_R_709_2: CFString
 public let kCVImageBufferColorPrimaries_EBU_3213: CFString
 public let kCVImageBufferColorPrimaries_SMPTE_C: CFString
 public let kCVImageBufferColorPrimaries_P22: CFString
 public let kCVImageBufferColorPrimaries_DCI_P3: CFString
 public let kCVImageBufferColorPrimaries_P3_D65: CFString
 public let kCVImageBufferColorPrimaries_ITU_R_2020: CFString
 
 public let kCVImageBufferTransferFunctionKey: CFString // CFString describing the transfer function. This key can be one of the following values
 public let kCVImageBufferTransferFunction_ITU_R_709_2: CFString
 public let kCVImageBufferTransferFunction_SMPTE_240M_1995: CFString
 public let kCVImageBufferTransferFunction_UseGamma: CFString
 
 public let kCVImageBufferTransferFunction_sRGB: CFString // IEC 61966-2-1 sRGB or sYCC
 public let kCVImageBufferTransferFunction_ITU_R_2020: CFString // note: kCVImageBufferTransferFunction_ITU_R_709_2 is equivalent, and preferred
 public let kCVImageBufferTransferFunction_SMPTE_ST_428_1: CFString
 public let kCVImageBufferTransferFunction_SMPTE_ST_2084_PQ: CFString
 public let kCVImageBufferTransferFunction_ITU_R_2100_HLG: CFString
 public let kCVImageBufferTransferFunction_Linear: CFString
 
 /* Chroma siting information. For progressive images, only the TopField value is used. */
 public let kCVImageBufferChromaLocationTopFieldKey: CFString // CFString with one of the following CFString values
 public let kCVImageBufferChromaLocationBottomFieldKey: CFString // CFString with one of the following CFString values
 public let kCVImageBufferChromaLocation_Left: CFString // Chroma sample is horizontally co-sited with the left column of luma samples, but centered vertically.
 public let kCVImageBufferChromaLocation_Center: CFString // Chroma sample is fully centered
 public let kCVImageBufferChromaLocation_TopLeft: CFString // Chroma sample is co-sited with the top-left luma sample.
 public let kCVImageBufferChromaLocation_Top: CFString // Chroma sample is horizontally centered, but co-sited with the top row of luma samples.
 public let kCVImageBufferChromaLocation_BottomLeft: CFString // Chroma sample is co-sited with the bottom-left luma sample.
 public let kCVImageBufferChromaLocation_Bottom: CFString // Chroma sample is horizontally centered, but co-sited with the bottom row of luma samples.
 public let kCVImageBufferChromaLocation_DV420: CFString // Cr and Cb samples are alternately co-sited with the left luma samples of the same field.
 
 // These describe the format of the original subsampled data before conversion to 422/2vuy.   In order to use
 // these tags, the data must have been converted to 4:2:2 via simple pixel replication.
 public let kCVImageBufferChromaSubsamplingKey: CFString // CFString/CFNumber with one of the following values
 public let kCVImageBufferChromaSubsampling_420: CFString
 public let kCVImageBufferChromaSubsampling_422: CFString
 public let kCVImageBufferChromaSubsampling_411: CFString
 
 // Can be set to kCFBooleanTrue as a hint that the alpha channel is fully opaque.  Not used if the pixel format type has no alpha channel.
 public let kCVImageBufferAlphaChannelIsOpaque: CFString
 
 // Returns the standard integer code point corresponding to a given CoreVideo YCbCrMatrix constant string (in the kCVImageBufferYCbCrMatrix_... family).  Returns 2 (the code point for "unknown") if the string is NULL or not recognized.
 public func CVYCbCrMatrixGetIntegerCodePointForString(_ yCbCrMatrixString: CFString?) -> Int32
 
 // Returns the standard integer code point corresponding to a given CoreVideo ColorPrimaries constant string (in the kCVImageBufferColorPrimaries_... family).  Returns 2 (the code point for "unknown") if the string is NULL or not recognized.
 public func CVColorPrimariesGetIntegerCodePointForString(_ colorPrimariesString: CFString?) -> Int32
 
 // Returns the standard integer code point corresponding to a given CoreVideo TransferFunction constant string (in the kCVImageBufferTransferFunction_... family).  Returns 2 (the code point for "unknown") if the string is NULL or not recognized.
 public func CVTransferFunctionGetIntegerCodePointForString(_ transferFunctionString: CFString?) -> Int32
 
 // Returns the CoreVideo YCbCrMatrix constant string (in the kCVImageBufferYCbCrMatrix_... family) corresponding to a given standard integer code point.  Returns NULL if the code point is not recognized, or if it is 2 (the code point for "unknown").
 public func CVYCbCrMatrixGetStringForIntegerCodePoint(_ yCbCrMatrixCodePoint: Int32) -> Unmanaged<CFString>?
 
 // Returns the CoreVideo ColorPrimaries constant string (in the kCVImageBufferColorPrimaries_... family) corresponding to a given standard integer code point.  Returns NULL if the code point is not recognized, or if it is 2 (the code point for "unknown").
 public func CVColorPrimariesGetStringForIntegerCodePoint(_ colorPrimariesCodePoint: Int32) -> Unmanaged<CFString>?
 
 // Returns the CoreVideo TransferFunction constant string (in the kCVImageBufferTransferFunction_... family) corresponding to a given standard integer code point.  Returns NULL if the code point is not recognized, or if it is 2 (the code point for "unknown").
 public func CVTransferFunctionGetStringForIntegerCodePoint(_ transferFunctionCodePoint: Int32) -> Unmanaged<CFString>?

 */
