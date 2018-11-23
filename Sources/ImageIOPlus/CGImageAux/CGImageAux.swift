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
public struct CGImageAux {
    public var info: Info
    public var type: CGImageAuxType
    
    public init?(rawValue: Info.RawValue, type: CGImageAuxType) {
        guard let info = Info(rawValue: rawValue) else {
            return nil
        }
        self.type = type
        self.info = info
    }
}

public extension CGImageAux {
    struct Info: RawKeyDictionaryWrapper {
        public typealias RawValue = [String: Any]
        
        public enum Key : String, CaseIterable {
            case metadata        = "kCGImageAuxiliaryDataInfoMetadata"
            case data            = "kCGImageAuxiliaryDataInfoData"
            case dataDescription = "kCGImageAuxiliaryDataInfoDataDescription"
        }
        
        public var metadata: CGImageMetadata
        public var data: Data
        public var dataDescription: [String: Any]
        
        public let _rawValue: RawKeyDict
        
        public var rawValue: RawKeyDict {
            return [
                Key.metadata       .rawValue: metadata,
                Key.data           .rawValue: data,
                Key.dataDescription.rawValue: dataDescription
            ]
        }
        
        public init?(dict: Dict, rawKeyDict: RawKeyDict) {
            _rawValue = rawKeyDict
            
            metadata = dict[.metadata]       .map(cgImageMetadata)!
            data = dict[.data]           .map(cfData)!
            dataDescription = dict[.dataDescription].map(cfDictWithStringKey)!
        }
    }
}

import class Foundation.NSString

public protocol AuxConvertible {
    init(fromDictionaryRepresentation: [AnyHashable : Any]) throws
    func applyingExifOrientation(_ exifOrientation: CGImagePropertyOrientation) -> Self
    func dictionaryRepresentation(forAuxiliaryDataType: AutoreleasingUnsafeMutablePointer<NSString?>?) -> [AnyHashable : Any]?
}

public extension AuxConvertible {
    init(aux: CGImageAux) throws {
        try self.init(fromDictionaryRepresentation: aux.info.rawValue)
    }
    
    func auxRepresentation() -> CGImageAux {
        var rawType: NSString?
        let rawAux = dictionaryRepresentation(forAuxiliaryDataType: &rawType) as! [String: Any]?
        return CGImageAux(rawValue: rawAux!, type: CGImageAuxType.init(rawValue: rawType! as String)!)!
    }
}

import class AVFoundation.AVDepthData
import class AVFoundation.AVPortraitEffectsMatte

extension AVDepthData : AuxConvertible {
}

extension AVPortraitEffectsMatte : AuxConvertible {
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
