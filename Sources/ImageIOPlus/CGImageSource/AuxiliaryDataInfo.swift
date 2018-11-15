//
//  CGImageAuxiliaryDataInfo.swift
//  ImageIOExtension
//
//  Created by Cao, Jiannan on 2018/10/19.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import ImageIO
import struct Foundation.Data
import ImageIOPlusBase

// kCGImageAuxiliaryDataInfoData
// kCGImageAuxiliaryDataInfoMetadata
// kCGImageAuxiliaryDataInfoDataDescription
public extension CGImageSourceImage {
    struct AuxiliaryDataInfo : RawKeyDictionaryWrapper {
        public typealias RawValue = [String: Any]

        public enum Key : String {
            case metadata = "kCGImageAuxiliaryDataInfoMetadata"
            case data = "kCGImageAuxiliaryDataInfoData"
            case dataDescription = "kCGImageAuxiliaryDataInfoDataDescription"
        }

        public let metadata: CGImageMetadata
        public let data: Data
        public let dataDescription: [String: Any]
        public let rawValue: RawKeyDict
        public init?(dict: Dict, rawKeyDict: RawKeyDict) {
            self.rawValue = rawKeyDict

            metadata = dict[.metadata] as! CGImageMetadata
            data = dict[.data] as! CFData as Data
            dataDescription = dict[.dataDescription] as! [String: Any]
        }

        /*public var rawValue: [String: Any] {
            /*return [
                kCGImageAuxiliaryDataInfoMetadata as String: metadata,
                kCGImageAuxiliaryDataInfoData as String: data,
                kCGImageAuxiliaryDataInfoDataDescription as String: dataDescription
            ]*/
            /*if let _rawValue = _rawValue {
                return _rawValue
            } else {*/
                return [
                    kCGImageAuxiliaryDataInfoMetadata as String: metadata,
                    kCGImageAuxiliaryDataInfoData as String: data,
                    kCGImageAuxiliaryDataInfoDataDescription as String: dataDescription
                ]
            //}
        }*/
        }
}

import AVFoundation

public extension AVDepthData {
    convenience init(auxiliaryData: CGImageSourceImage.AuxiliaryDataInfo) throws {
        try self.init(fromDictionaryRepresentation: auxiliaryData.rawValue)
    }
}

public extension AVPortraitEffectsMatte {
    convenience init(auxiliaryData: CGImageSourceImage.AuxiliaryDataInfo) throws {
        try self.init(fromDictionaryRepresentation: auxiliaryData.rawValue)
    }
}
