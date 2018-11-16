//
//  Float16.swift
//  get-aux
//
//  Created by Cao, Jiannan on 2018/11/5.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import Accelerate

public typealias Float16Raw = UInt16

extension Float16Raw {
    public func float16ToFloat() -> Float {
        return UInt16.float16s_to_floats(values: [self])[0]
    }
    
    public static func float16_to_float(value: UInt16) -> Float {
        return float16s_to_floats(values: [value])[0]
    }
    
    public static func float16s_to_floats(values: [UInt16]) -> [Float] {
        var inputs: [UInt16] = values
        var outputs: [Float] = Array<Float>(repeating: 0, count: values.count)
        let width = vImagePixelCount(values.count)
        var sourceBuffer = vImage_Buffer(data: &inputs, height: 1, width: width, rowBytes: MemoryLayout<UInt16>.size * values.count)
        var destinationBuffer = vImage_Buffer(data: &outputs, height: 1, width: width, rowBytes: MemoryLayout<Float>.size * values.count)
        vImageConvert_Planar16FtoPlanarF(&sourceBuffer, &destinationBuffer, 0)
        return outputs
    }
}
/*public struct Float16: RawRepresentable, Comparable, CustomStringConvertible {
    public static func < (lhs: Float16, rhs: Float16) -> Bool {
        return lhs.floatValue < rhs.floatValue
    }
    
    public var rawValue: UInt16
    
    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }
    
    public static func float_to_float16(value: Float) -> UInt16 {
        return floats_to_float16s(values: [value])[0]
    }
    
    public static func float16_to_float(value: UInt16) -> Float {
        return float16s_to_floats(values: [value])[0]
    }
    
    public static func floats_to_float16s(values: [Float]) -> [UInt16] {
        var inputs = values
        var outputs = Array<UInt16>(repeating: 0, count: values.count)
        let width = vImagePixelCount(values.count)
        var sourceBuffer = vImage_Buffer(data: &inputs, height: 1, width: width, rowBytes: MemoryLayout<Float>.size * values.count)
        var destinationBuffer = vImage_Buffer(data: &outputs, height: 1, width: width, rowBytes: MemoryLayout<UInt16>.size * values.count)
        vImageConvert_PlanarFtoPlanar16F(&sourceBuffer, &destinationBuffer, 0)
        return outputs
    }
    
    public static func float16s_to_floats(values: [UInt16]) -> [Float] {
        var inputs: [UInt16] = values
        var outputs: [Float] = Array<Float>(repeating: 0, count: values.count)
        let width = vImagePixelCount(values.count)
        var sourceBuffer = vImage_Buffer(data: &inputs, height: 1, width: width, rowBytes: MemoryLayout<UInt16>.size * values.count)
        var destinationBuffer = vImage_Buffer(data: &outputs, height: 1, width: width, rowBytes: MemoryLayout<Float>.size * values.count)
        vImageConvert_Planar16FtoPlanarF(&sourceBuffer, &destinationBuffer, 0)
        return outputs
    }
    
    public init(_ value: Float) {
        self.rawValue = Float16.float_to_float16(value: value)
    }
    
    public var floatValue: Float {
        return Float16.float16_to_float(value: self.rawValue)
    }
    
    public var description: String {
        return self.floatValue.description
    }
}*/
