//
//  Bridging.swift
//  ImageIOExtension
//
//  Created by Cao, Jiannan on 2018/10/18.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import class CoreGraphics.CGColorSpace
import CoreGraphics
import class ImageIO.CGImageMetadata

protocol _CFBridgeable {
    associatedtype CFType
    var _cfObject: CFType { get }
}

protocol _NSBridgeable {
    associatedtype NSType
    var _nsObject: NSType { get }
}

public extension Dictionary where Key : RawRepresentable, Key.RawValue : Hashable {
    init(rawKeyDict dict: [Key.RawValue: Value]) {
        self = Dictionary(uniqueKeysWithValues: dict.map { (Key(rawValue: $0)!, $1) })
    }
}

public protocol RawDictionaryWrapper : RawRepresentable where RawValue == Dict {
    associatedtype Key : Hashable
    typealias Dict = [Key : Any]
}

public protocol RawKeyDictionaryWrapper : RawRepresentable where RawValue == [RawKey : Any] {
    
    associatedtype Key : Hashable, RawRepresentable where Key.RawValue : Hashable
    typealias Dict = [Key : Any]
    
    typealias RawKey = Key.RawValue
    typealias RawKeyDict = [RawKey : Any]
    
    init?(dict: Dict, rawKeyDict: RawKeyDict)
}

extension RawKeyDictionaryWrapper {
    public init?(rawValue: RawKeyDict) {
        self.init(dict: .init(rawKeyDict: rawValue), rawKeyDict: rawValue)
    }
}

import CoreFoundation
import Foundation
public func cfBoolean(of value: Any) -> Bool {
     return value as! CFBoolean as NSNumber as! Bool
}

public func cfInt(of value: Any) -> Int {
    return value as! CFNumber as NSNumber as! Int
}

public func cfUInt32(of value: Any) -> UInt32 {
    return value as! CFNumber as NSNumber as! UInt32
}

public func cfFloat(of value: Any) -> Float {
    return value as! CFNumber as NSNumber as! Float
}

public func cfDouble(of value: Any) -> Double {
    return value as! CFNumber as NSNumber as! Double
}

public func cfString(of value: Any) -> String {
    return value as! CFString as NSString as String
}

public func cfDictWithStringKey(of value: Any) -> [String: Any] {
    return value as! CFDictionary as NSDictionary as [NSObject: AnyObject] as! [String: Any]
}

public func cfData(of value: Any) -> Data {
    return value as! CFData as NSData as Data
}

public func cfAllocator(of value: Any) -> CFAllocator {
    return value as! CFAllocator
}

public func cgImageMetadata(of value: Any) -> CGImageMetadata {
    return value as! CGImageMetadata
}

public func cgColor(of value: Any) -> CGColor {
    return value as! CGColor
}

public func cgColorSpace(of value: Any) -> CGColorSpace {
    return value as! CGColorSpace
}

public func cgBitmapInfo(of value: Any) -> CGBitmapInfo {
    return CGBitmapInfo(rawValue: cfUInt32(of: value))
}
