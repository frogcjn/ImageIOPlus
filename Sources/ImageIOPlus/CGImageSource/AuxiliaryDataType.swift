//
//  CGImageAuxiliaryDataType.swift
//  ImageIOExtension
//
//  Created by Cao, Jiannan on 2018/10/19.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import ImageIO

public extension CGImageSource {
    public enum AuxiliaryType : String {
        case disparityOrDepth
        case matte
    }
}

public enum CGImageAuxiliaryDataType {
    case disparity
    case depth
    case portraitEffectsMatte
}

extension CGImageAuxiliaryDataType : CaseIterable, RawRepresentable {
    public typealias RawValue = String
    
    public init?(rawValue: String) {
        switch rawValue as CFString {
        case kCGImageAuxiliaryDataTypeDisparity:
            self = .disparity
        case kCGImageAuxiliaryDataTypeDepth:
            self = .depth
        case kCGImageAuxiliaryDataTypePortraitEffectsMatte:
            self = .portraitEffectsMatte
        default:
            return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case .disparity:
            return kCGImageAuxiliaryDataTypeDisparity as String
        case .depth:
            return kCGImageAuxiliaryDataTypeDepth as String
        case .portraitEffectsMatte:
            return kCGImageAuxiliaryDataTypePortraitEffectsMatte as String
        }
    }
}
