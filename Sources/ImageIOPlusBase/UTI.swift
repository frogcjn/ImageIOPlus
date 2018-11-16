//
//  UTI.swift
//  ImageIOPlusBase
//
//  Created by Cao, Jiannan on 2018/11/15.
//

import  func   CoreServices.UTTypeCopyPreferredTagWithClass
import   let   CoreServices.kUTTagClassFilenameExtension
import class CoreFoundation.CFString

public struct UTI : RawRepresentable {
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public var filenameExtension: String? {
        return UTTypeCopyPreferredTagWithClass(rawValue as CFString, kUTTagClassFilenameExtension)?.takeUnretainedValue() as String?
    }
}

extension UTI: ExpressibleByStringLiteral {
    public init(unicodeScalarLiteral value: StringLiteralType) {
        rawValue = value
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        rawValue = value
    }
    
    public init(stringLiteral value: StringLiteralType) {
        rawValue = value
    }
}

extension UTI : Equatable {
    
}
