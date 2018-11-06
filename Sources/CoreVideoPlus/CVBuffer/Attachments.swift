//
//  CVBufferAttachments.swift
//  get-auxiliary
//
//  Created by Cao, Jiannan on 2018/11/2.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import CoreVideo
import ImageIOPlusBase

public extension CVBuffer {
    public struct Attachments : RawKeyDictionaryWrapper {
        
        // CVBuffer
        public let timeValue: TimeValue?
        
        // CVImageBuffer
        public let colorSpace: CGColorSpace?
        public let clearAperture: CleanAperture?
        public let preferredCleanAperture: CleanAperture?
        public let fieldCount: Int?
        public let fieldDetail: FieldDetail?
        public let pixelAspectRatio: PixelAspectRatio?
        public let displayDimensions: DisplayDimensions?
        public let gammaLevel: Float?
        public let iccProfile: Data?
        public let yCbCrMatrix: YCbCrMatrix?
        public let colorPrimaries: ColorPrimaries?
        public let transferFunction: TransferFunction?
        public let chromaLocationTopField: ChromaLocation?
        public let chromaLocationBottomField: ChromaLocation?
        public let chromaSubsampling: ChromaSubsampling?
        public let alphaChannelIsOpaque: Bool?
        public let contentLightLevelInfo: String?
        public let masteringDisplayColorVolumne: String?
        
        public let rawValue : RawKeyDict
        public init(dict: Dict, rawKeyDict: RawKeyDict) {
            rawValue = rawKeyDict
            
            colorSpace = dict[.colorSpace]
                .map(cgColorSpace)
            
            clearAperture = dict[.cleanAperture]
                .map(cfDictWithStringKey)
                .map { CleanAperture(rawValue: $0)! }
            
            preferredCleanAperture = dict[.preferredCleanAperture]
                .map(cfDictWithStringKey)
                .map { CleanAperture(rawValue: $0)! }
            
            fieldCount = dict[.fieldCount]
                .map(cfInt)
            
            fieldDetail = dict[.fieldDetail]
                .map(cfDictWithStringKey)
                .map { FieldDetail(rawValue: $0)! }
            
            pixelAspectRatio = dict[.pixelAspectRatio]
                .map(cfDictWithStringKey)
                .map { PixelAspectRatio(rawValue: $0)! }
            
            displayDimensions = dict[.displayDimensions]
                .map(cfDictWithStringKey)
                .map { DisplayDimensions(rawValue: $0)! }
            
            gammaLevel = dict[.gammaLevel]
                .map(cfFloat)

            iccProfile = dict[.iccProfile]
                .map(cfData)
            
            yCbCrMatrix = dict[.yCbCrMatrix]
                .map(cfString)
                .map { YCbCrMatrix.init(rawValue: $0)! }
            
            colorPrimaries = dict[.colorPrimaries]
                .map(cfString)
                .map { ColorPrimaries.init(rawValue: $0)! }
            
            transferFunction = dict[.transferFunction]
                .map(cfString)
                .map { TransferFunction.init(rawValue: $0)! }
            
            chromaLocationTopField = dict[.chromaLocationTopField]
                .map(cfString)
                .map { ChromaLocation.init(rawValue: $0)! }
            
            chromaLocationBottomField = dict[.chromaLocationBottomField]
                .map(cfString)
                .map { ChromaLocation.init(rawValue: $0)! }
            
            chromaSubsampling = dict[.chromaSubsampling]
                .map(cfString)
                .map { ChromaSubsampling.init(rawValue: $0)! }
            
            alphaChannelIsOpaque         = dict[.alphaChannelIsOpaque].map(cfBoolean)
            contentLightLevelInfo        = dict[.contentLightLevelInfo].map(cfString)
            masteringDisplayColorVolumne = dict[.masteringDisplayColorVolume].map(cfString)
            
            timeValue = dict[.timeValue]
                .map(cfDictWithStringKey)
                .map { TimeValue.init(rawValue: $0)! }
            
        }
    }
}

public extension CVBuffer.Attachments {
    /*
     https://ios.ddf.net/symbols/198C8BB3-7D7A-35D2-A02B-E30B4C908B99
     kCVImageBufferCGColorSpaceKey
     ,kCVImageBufferCleanApertureKey
     ,kCVImageBufferPreferredCleanApertureKey
     ,kCVImageBufferFieldCountKey
     ,kCVImageBufferFieldDetailKey
     ,kCVImageBufferPixelAspectRatioKey
     ,kCVImageBufferDisplayDimensionsKey
     ,kCVImageBufferGammaLevelKey
     ,kCVImageBufferICCProfileKey
     ,kCVImageBufferYCbCrMatrixKey
     ,kCVImageBufferColorPrimariesKey
     ,kCVImageBufferTransferFunctionKey
     ,kCVImageBufferContentLightLevelInfoKey
     ,kCVImageBufferChromaLocationTopFieldKey
     ,kCVImageBufferChromaLocationBottomFieldKey
     ,kCVImageBufferChromaSubsamplingKey
     ,kCVImageBufferAlphaChannelIsOpaque
     ,kCVImageBufferMasteringDisplayColorVolumeKey
     */
    
    public enum Key : String {
        // CVBuffer, Generally only available for frames emitted by QuickTime
        case timeValue                   = "QTMovieTime" // let kCVBufferTimeValueKey: CFString
        
        // CVImageBuffer
        case colorSpace                  = "CGColorSpace"
        case cleanAperture               = "CVCleanAperture"
        case preferredCleanAperture      = "CVPreferredCleanAperture"
        case fieldCount                  = "CVFieldCount"
        case fieldDetail                 = "CVFieldDetail"
        case pixelAspectRatio            = "CVPixelAspectRatio"
        case displayDimensions           = "CVDisplayDimensions"
        case gammaLevel                  = "CVImageBufferGammaLevel"
        case iccProfile                  = "CVImageBufferICCProfile"
        case yCbCrMatrix                 = "CVImageBufferYCbCrMatrix"
        case colorPrimaries              = "CVImageBufferColorPrimaries"
        case transferFunction            = "CVImageBufferTransferFunction"
        case chromaLocationTopField      = "CVImageBufferChromaLocationTopField"
        case chromaLocationBottomField   = "CVImageBufferChromaLocationBottomField"
        case chromaSubsampling           = "CVImageBufferChromaSubsampling"
        case alphaChannelIsOpaque        = "AlphaChannelIsOpaque"
        case contentLightLevelInfo       = "ContentLightLevelInfo"
        case masteringDisplayColorVolume = "MasteringDisplayColorVolume"
    }
}

public extension CVBuffer.Attachments {
    public struct CleanAperture : RawKeyDictionaryWrapper {
        
        /*
         kCVImageBufferCleanApertureWidthKey
         kCVImageBufferCleanApertureHeightKey
         kCVImageBufferCleanApertureHorizontalOffsetKey
         kCVImageBufferCleanApertureVerticalOffsetKey
         */
        public enum Key : String {
            case width            = "Width"
            case height           = "Height"
            case horizontalOffset = "HorizontalOffset"
            case verticalOffset   = "VerticalOffset"
        }
        
        public var width: Float?
        public var height: Float?
        public var horizontalOffset: Float?
        public var verticalOffset: Float?
        
        public let rawValue: RawKeyDict
        public init(dict: Dict, rawKeyDict: RawKeyDict) {
            rawValue = rawKeyDict
            
            width            = dict[.width]           .map { $0 as! CFNumber as NSNumber as! Float }
            height           = dict[.height]          .map { $0 as! CFNumber as NSNumber as! Float }
            horizontalOffset = dict[.horizontalOffset].map { $0 as! CFNumber as NSNumber as! Float }
            verticalOffset   = dict[.verticalOffset]  .map { $0 as! CFNumber as NSNumber as! Float }
        }
    }
    
    public struct FieldDetail : RawKeyDictionaryWrapper {
        
        /*
         0x00000001a9fbda20 (     0x8) kCVImageBufferFieldDetailTemporalTopFirst
         0x00000001a9fbda28 (     0x8) kCVImageBufferFieldDetailTemporalBottomFirst
         0x00000001a9fbda30 (     0x8) kCVImageBufferFieldDetailSpatialFirstLineEarly
         0x00000001a9fbda38 (     0x8) kCVImageBufferFieldDetailSpatialFirstLineLate
         */
        
        public enum Key : String {
            case temporalTopFirst      = "TemporalTopFirst"
            case temporalBottomFirst   = "TemporalBottomFirst"
            case spatialFirstLineEarly = "SpatialFirstLineEarly"
            case spatialFirstLineLate  = "SpatialFirstLineLate"
        }
        
        public var temporalTopFirst: String?
        public var temporalBottomFirst: String?
        public var spatialFirstLineEarly: String?
        public var spatialFirstLineLate: String?
        
        public let rawValue: RawKeyDict
        public init(dict: Dict, rawKeyDict: RawKeyDict) {
            rawValue = rawKeyDict
            
            temporalTopFirst      = dict[.temporalTopFirst]     .map { $0 as! CFString as NSString as String }
            temporalBottomFirst   = dict[.temporalBottomFirst]  .map { $0 as! CFString as NSString as String }
            spatialFirstLineEarly = dict[.spatialFirstLineEarly].map { $0 as! CFString as NSString as String }
            spatialFirstLineLate  = dict[.spatialFirstLineLate] .map { $0 as! CFString as NSString as String }
        }
    }
    
    public struct PixelAspectRatio : RawKeyDictionaryWrapper {
        public typealias RawKey = Key.RawValue
        /*
         0x00000001a9fbda48 (     0x8) kCVImageBufferPixelAspectRatioHorizontalSpacingKey
         0x00000001a9fbda50 (     0x8) kCVImageBufferPixelAspectRatioVerticalSpacingKey
         */
        public enum Key : String {
            case horizontalSpacing = "HorizontalSpacing"
            case verticalSpacing   = "VerticalSpacing"
        }
        
        public let horizontalSpacing : Float?
        public let   verticalSpacing : Float?
        
        public let rawValue: RawKeyDict
        public init(dict: Dict, rawKeyDict: RawKeyDict) {
            rawValue = rawKeyDict
            
            horizontalSpacing = dict[.horizontalSpacing].map { $0 as! CFNumber as NSNumber as! Float }
            verticalSpacing   = dict[.verticalSpacing]  .map { $0 as! CFNumber as NSNumber as! Float }
        }
    }
    
    public struct DisplayDimensions : RawKeyDictionaryWrapper {
        /*
         0x00000001a9fbda60 (     0x8) kCVImageBufferDisplayWidthKey
         0x00000001a9fbda68 (     0x8) kCVImageBufferDisplayHeightKey
         */
        public enum Key : String {
            case width  = "Width"
            case height = "Height"
        }
        
        public let width  : Float?
        public let height : Float?
        
        public let rawValue: RawKeyDict
        public init(dict: Dict, rawKeyDict: RawKeyDict) {
            rawValue = rawKeyDict
            
            width  = dict[.width] .map { $0 as! CFNumber as NSNumber as! Float }
            height = dict[.height].map { $0 as! CFNumber as NSNumber as! Float }
        }
    }
    
    public struct TimeValue: RawKeyDictionaryWrapper {
        public enum Key : String {
            case timeScale = "TimeScale"
            case timeValue = "TimeValue"
        }
        
        public let timeScale  : Float?
        public let timeValue : Float?
        
        public let rawValue: RawKeyDict
        public init(dict: Dict, rawKeyDict: RawKeyDict) {
            rawValue = rawKeyDict
            
            timeScale = dict[.timeScale].map { $0 as! CFNumber as NSNumber as! Float }
            timeValue = dict[.timeValue].map { $0 as! CFNumber as NSNumber as! Float }
        }
    }
    /*
     0x00000001a9fbda88 (     0x8) kCVImageBufferYCbCrMatrix_ITU_R_709_2
     0x00000001a9fbda90 (     0x8) kCVImageBufferYCbCrMatrix_ITU_R_601_4
     0x00000001a9fbda98 (     0x8) kCVImageBufferYCbCrMatrix_SMPTE_240M_1995
     0x00000001a9fbdaa0 (     0x8) kCVImageBufferYCbCrMatrix_DCI_P3
     0x00000001a9fbdaa8 (     0x8) kCVImageBufferYCbCrMatrix_P3_D65
     0x00000001a9fbdab0 (     0x8) kCVImageBufferYCbCrMatrix_ITU_R_2020
     */
    public enum YCbCrMatrix : String {
        case ITU_R_709_2
        case ITU_R_601_4
        case SMPTE_240M_1995
        case DCI_P3
        case P3_D65
        case ITU_R_2020
    }
    
    /*
     kCVImageBufferTransferFunction_ITU_R_709_2
     kCVImageBufferTransferFunction_SMPTE_240M_1995
     0x00000001a9fbdb10 (     0x8) kCVImageBufferTransferFunction_Linear
     0x00000001a9fbdb18 (     0x8) kCVImageBufferTransferFunction_sRGB
     0x00000001a9fbdb20 (     0x8) kCVImageBufferTransferFunction_ITU_R_2020
     0x00000001a9fbdb28 (     0x8) kCVImageBufferTransferFunction_SMPTE_ST_428_1
     0x00000001a9fbdb30 (     0x8) kCVImageBufferTransferFunction_SMPTE_ST_2084_PQ
     0x00000001a9fbdb38 (     0x8) kCVImageBufferTransferFunction_ITU_R_2100_HLG
     0x00000001a9fbdb40 (     0x8) kCVImageBufferTransferFunction_ARIB_STD_B67_HLG
     0x00000001a9fbdb48 (     0x8) kCVImageBufferTransferFunction_aYCC
     0x00000001a9fbdb50 (     0x8) kCVImageBufferTransferFunction_UseGamma
     */
    public enum TransferFunction : String {
        case ITU_R_709_2
        case SMPTE_240M_1995
        case linear = "Linear"
        case sRGB = "IEC_sRGB"
        case ITU_R_2020
        case SMPTE_ST_428_1
        case SMPTE_ST_2084_PQ
        case ITU_R_2100_HLG
        case ARIB_STD_B67_HLG // cannot find
        case aYCC = "aYCC"
        case useGamma = "UseGamma"
    }
    
    
    /*
     0x00000001a9fbdb80 (     0x8) kCVImageBufferChromaLocation_Left
     0x00000001a9fbdb88 (     0x8) kCVImageBufferChromaLocation_Center
     0x00000001a9fbdb90 (     0x8) kCVImageBufferChromaLocation_TopLeft
     0x00000001a9fbdb98 (     0x8) kCVImageBufferChromaLocation_Top
     0x00000001a9fbdba0 (     0x8) kCVImageBufferChromaLocation_BottomLeft
     0x00000001a9fbdba8 (     0x8) kCVImageBufferChromaLocation_Bottom
     0x00000001a9fbdbb0 (     0x8) kCVImageBufferChromaLocation_DV420
     */
    
    public enum ChromaLocation : String {
        case center     = "Center"
        case top        = "Top"
        case bottom     = "Bottom"
        
        case left       = "Left"
        case topLeft    = "TopLeft"
        case bottomLeft = "BottomLeft"
        
        case DV420      = "DV 4:2:0"
    }
    
    /*
     0x00000001a9fbdbc0 (     0x8) kCVImageBufferChromaSubsampling_420
     0x00000001a9fbdbc8 (     0x8) kCVImageBufferChromaSubsampling_422
     0x00000001a9fbdbd0 (     0x8) kCVImageBufferChromaSubsampling_411
     */
    
    public enum ChromaSubsampling : String {
        case _420 = "4:2:0"
        case _422 = "4:2:2"
        case _411 = "4:1:1"
    }
    
    // Image Buffer Color Primaries Constants
    /*
     public let kCVImageBufferColorPrimaries_ITU_R_709_2: CFString
     public let kCVImageBufferColorPrimaries_EBU_3213: CFString
     public let kCVImageBufferColorPrimaries_SMPTE_C: CFString
     public let kCVImageBufferColorPrimaries_DCI_P3: CFString
     public let kCVImageBufferColorPrimaries_ITU_R_2020: CFString
     public let kCVImageBufferColorPrimaries_P3_D65: CFString
     public let kCVImageBufferColorPrimaries_P22: CFString
     */
    public enum ColorPrimaries : String {
        case ITU_R_709_2
        case EBU_3213
        case SMPTE_C
        case DCI_P3
        case ITU_R_2020
        case P3_D65
        case P22
    }
}

public extension CVBuffer.Attachments.ColorPrimaries {
    var codePoint: Int32 {
        return CVColorPrimariesGetIntegerCodePointForString(rawValue as CFString)
    }
    
    init?(codePoint: Int32) {
        guard let rawValue = CVColorPrimariesGetStringForIntegerCodePoint(codePoint)?.takeUnretainedValue() as String? else {
            return nil
        }
        self.init(rawValue: rawValue)
    }
}

public extension CVBuffer.Attachments.TransferFunction {
    var codePoint: Int32 {
        return CVTransferFunctionGetIntegerCodePointForString(rawValue as CFString)
    }
    
    init?(codePoint: Int32) {
        guard let rawValue = CVTransferFunctionGetStringForIntegerCodePoint(codePoint)?.takeUnretainedValue() as String? else {
            return nil
        }
        self.init(rawValue: rawValue)
    }
}


public extension CVBuffer.Attachments.YCbCrMatrix {
    var codePoint: Int32 {
        return CVYCbCrMatrixGetIntegerCodePointForString(rawValue as CFString)
    }
    
    init?(codePoint: Int32) {
        guard let rawValue = CVYCbCrMatrixGetStringForIntegerCodePoint(codePoint)?.takeUnretainedValue() as String? else {
            return nil
        }
        self.init(rawValue: rawValue)
    }
}