//
//  CGImageAux.swift
//  ImageIOExtension
//
//  Created by Cao, Jiannan on 2018/10/19.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import ImageIO
import struct Foundation.Data
import ImageIOPlusBase

// kCGImageAux
// kCGImageAuxMetadata
// kCGImageAuxDescription
public struct CGImageAux : RawKeyDictionaryWrapper {
    public typealias RawValue = [String: Any]

    public enum Key : String {
        case metadata        = "kCGImageAuxiliaryDataInfoMetadata"
        case data            = "kCGImageAuxiliaryDataInfoData"
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
            kCGImageAuxMetadata as String: metadata,
            kCGImageAux as String: data,
            kCGImageAuxDescription as String: dataDescription
        ]*/
        /*if let _rawValue = _rawValue {
            return _rawValue
        } else {*/
            return [
                kCGImageAuxMetadata as String: metadata,
                kCGImageAux as String: data,
                kCGImageAuxDescription as String: dataDescription
            ]
        //}
    }*/
}

import AVFoundation

public extension AVDepthData {
    convenience init(aux: CGImageAux) throws {
        try self.init(fromDictionaryRepresentation: aux.rawValue)
    }
}

public extension AVPortraitEffectsMatte {
    convenience init(aux: CGImageAux) throws {
        try self.init(fromDictionaryRepresentation: aux.rawValue)
    }
}
