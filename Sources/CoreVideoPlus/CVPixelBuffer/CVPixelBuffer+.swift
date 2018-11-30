//
//  CVPixelBuffer+.swift
//  get-aux
//
//  Created by Cao, Jiannan on 2018/11/5.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import CoreVideo
import ImageIOPlusBase
import typealias ImageIOPlusBase.Float16Raw
import Accelerate
import struct Foundation.Data
// resizing float 32 (for depth/disparity data map resizing)
public extension CVPixelBuffer {
    /**
     First crops the pixel buffer, then resizes it.
     */
    func resizing_float32(
        cropX: Int,
        cropY: Int,
        cropWidth: Int,
        cropHeight: Int,
        scaleWidth: Int,
        scaleHeight: Int
        ) -> CVPixelBuffer? {
        let srcPixelBuffer = self
        CVPixelBufferLockBaseAddress(srcPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        guard let srcData = CVPixelBufferGetBaseAddress(srcPixelBuffer) else {
            print("Error: could not get pixel buffer base address")
            return nil
        }
        let bytesPerPixel = 4
        let srcBytesPerRow = CVPixelBufferGetBytesPerRow(srcPixelBuffer)
        let offset = cropY*srcBytesPerRow + cropX*bytesPerPixel
        var srcBuffer = vImage_Buffer(data: srcData.advanced(by: offset),
                                      height: vImagePixelCount(cropHeight),
                                      width: vImagePixelCount(cropWidth),
                                      rowBytes: srcBytesPerRow)
        
        let destBytesPerRow = scaleWidth*bytesPerPixel
        guard let destData = malloc(scaleHeight*destBytesPerRow) else {
            print("Error: out of memory")
            return nil
        }
        var destBuffer = vImage_Buffer(data: destData,
                                       height: vImagePixelCount(scaleHeight),
                                       width: vImagePixelCount(scaleWidth),
                                       rowBytes: destBytesPerRow)
        
        let error = vImageScale_PlanarF(&srcBuffer, &destBuffer, nil, vImage_Flags(0))
        CVPixelBufferUnlockBaseAddress(srcPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        if error != kvImageNoError {
            print("Error:", error)
            free(destData)
            return nil
        }
        
        let releaseCallback: CVPixelBufferReleaseBytesCallback = { _, ptr in
            if let ptr = ptr {
                free(UnsafeMutableRawPointer(mutating: ptr))
            }
        }
        
        let pixelFormat = CVPixelBufferGetPixelFormatType(srcPixelBuffer)
        var dstPixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreateWithBytes(nil, scaleWidth, scaleHeight,
                                                  pixelFormat, destData,
                                                  destBytesPerRow, releaseCallback,
                                                  nil, nil, &dstPixelBuffer)
        if status != kCVReturnSuccess {
            print("Error: could not create new pixel buffer")
            free(destData)
            return nil
        }
        return dstPixelBuffer
    }
    
    func resizing_float32(width: Int, height: Int) -> CVPixelBuffer? {
        return resizing_float32(
            cropX: 0, cropY: 0,
            cropWidth: self.width, cropHeight: self.height,
            scaleWidth: width, scaleHeight: height
        )
    }
}

public extension CVPixelBuffer {
    /*func pixel<Element>(x: Int, y: Int, elementType: Element.Type) -> Element {
        return withBaseAddressLocked(.readOnly) {
            return baseAddress
                .advanced(by: y * bytesPerRow + x * MemoryLayout<Element>.size)
                .assumingMemoryBound(to: Element.self)[0]
        }
    }
    func setPixel<Element>(x: Int, y: Int, value: Element) {
        withBaseAddressLocked {
            /*guard let baseAddress = baseAddress else {
             return
             }*/
            var value = value
            
            baseAddress
                .advanced(by: y * bytesPerRow + x * MemoryLayout<Element>.size)
                .copyMemory(from: &value, byteCount: MemoryLayout<Element>.size)
        }
    }
    
    func pixels<Element>(elementType: Element.Type) -> [Element] {
        return withBaseAddressLocked(.readOnly) {
            let width = self.width
            let height = self.height
            let bytesPerRow = self.bytesPerRow
            var baseAddress = self.baseAddress

            return Array(
                (0..<height).map { _ -> [Element] in
                    let row = [Element](UnsafeBufferPointer(start: baseAddress.assumingMemoryBound(to: Element.self), count: width))
                    baseAddress = baseAddress.advanced(by: bytesPerRow)
                    return row
                }.joined()
            )
        }
    }
    */

    func pixels_float16() -> [Float] {
        return withBaseAddressLocked(.readOnly) {
            let width       = self.width
            let height      = self.height
            let bytesPerRow = self.bytesPerRow
            let baseAddress = self.baseAddress
            var float16Array: [Float] = [Float](repeating: 0, count: width * height)
            
            var sourceBuffer      = vImage_Buffer(data: baseAddress,   height: UInt(height), width: UInt(width), rowBytes: bytesPerRow)
            var destinationBuffer = vImage_Buffer(data: &float16Array, height: UInt(height), width: UInt(width), rowBytes: MemoryLayout<Float>.size * width)
            vImageConvert_Planar16FtoPlanarF(&sourceBuffer, &destinationBuffer, 0)
            
            return float16Array
        }
    }
    
    func pixels_float16() -> [UInt32] {
        return withBaseAddressLocked(.readOnly) {
            let width       = self.width
            let height      = self.height
            let bytesPerRow = self.bytesPerRow
            let baseAddress = self.baseAddress
            
            let rowBuffers = (0..<height).map {
                UnsafeBufferPointer(start: baseAddress.advanced(by: $0 * bytesPerRow).assumingMemoryBound(to: UInt32.self), count: width)
            }
            return .init(rowBuffers.joined())
        }
    }
    
    func pixels_float32() -> [Float32] {
        return withBaseAddressLocked(.readOnly) {
            let width = self.width
            let height = self.height
            let bytesPerRow = self.bytesPerRow
            let baseAddress = self.baseAddress
            
            let rowBuffers = (0..<height).map {
                UnsafeBufferPointer(start: baseAddress.advanced(by: $0 * bytesPerRow).assumingMemoryBound(to: Float32.self), count: width)
            }
            return .init(rowBuffers.joined())
        }
    }
    
    func data_float16() -> Data {
        return withBaseAddressLocked(.readOnly) {
            let width       = self.width
            let height      = self.height
            let bytesPerRow = self.bytesPerRow
            let data        = Data(bytes: baseAddress, count: dataSize)
            
            // According to Core Video engineering, the reason that the bytes per row is rounded up from 180 to 196 is because of a required 16 byte alignment. 180 / 16 = 11.25; 192 / 16 = 12.0.
            // https://stackoverflow.com/questions/46879895/byte-per-row-is-wrong-when-creating-a-cvpixelbuffer-with-width-multiple-of-90
            let rowBuffers = (0..<height).map {
                data.advanced(by: $0 * bytesPerRow)[0..<MemoryLayout<UInt16>.size * width]
            }
            return .init(rowBuffers.joined())
        }
    }
    
    func data_float32() -> Data {
        return withBaseAddressLocked(.readOnly) {
            let width       = self.width
            let height      = self.height
            let bytesPerRow = self.bytesPerRow
            let data        = Data(bytes: baseAddress, count: dataSize)
            
            // According to Core Video engineering, the reason that the bytes per row is rounded up from 180 to 196 is because of a required 16 byte alignment. 180 / 16 = 11.25; 192 / 16 = 12.0.
            // https://stackoverflow.com/questions/46879895/byte-per-row-is-wrong-when-creating-a-cvpixelbuffer-with-width-multiple-of-90
            let rowBuffers = (0..<height).map {
                data.advanced(by: $0 * bytesPerRow)[0..<MemoryLayout<Float32>.size * width]
            }
            return .init(rowBuffers.joined())
        }
    }
    
    /*func minMaxPixel_float16() -> (min: Float, max: Float)? {
        return withBaseAddressLocked(.readOnly) {
            let width = self.width
            let height = self.height
            let bytesPerRow = self.bytesPerRow
            let baseAddress = self.baseAddress
            var baseAddressFloat32: [Float] = [Float](repeating: 0, count: width * height)
            
            var sourceBuffer = vImage_Buffer(data: baseAddress, height: UInt(height), width: UInt(width), rowBytes: bytesPerRow)
            var destinationBuffer = vImage_Buffer(data: &baseAddressFloat32, height: UInt(height), width: UInt(width), rowBytes: MemoryLayout<Float>.size * width)
            vImageConvert_Planar16FtoPlanarF(&sourceBuffer, &destinationBuffer, 0)
            
            var minValue = baseAddressFloat32[0]
            var maxValue = baseAddressFloat32[0]
            for y in 0..<height {
                for x in 0..<width {
                    let value = baseAddressFloat32[y*width + x]
                    if value > maxValue { maxValue = value }
                    if value < minValue { minValue = value }
                }
            }
            return (minValue, maxValue)
        }
    }
    
    func minMaxPixel_float32() -> (min: Float, max: Float)? {
        return withBaseAddressLocked(.readOnly) {
            let width = self.width
            let height = self.height
            let bytesPerRow = self.bytesPerRow
            let baseAddress = self.baseAddress
            var baseAddressFloat32: [Float] = [Float](repeating: 0, count: width * height)
            [Float32](start: )
            // var inputs: [UInt16] = values
            // var outputs: [Float] = Array<Float>(repeating: 0, count: values.count)
            // let width = vImagePixelCount(values.count)
            var sourceBuffer = vImage_Buffer(data: baseAddress, height: UInt(height), width: UInt(width), rowBytes: bytesPerRow)
            var destinationBuffer = vImage_Buffer(data: &baseAddressFloat32, height: UInt(height), width: UInt(width), rowBytes: MemoryLayout<Float>.size * width)
            vImageConvert_Planar16FtoPlanarF(&sourceBuffer, &destinationBuffer, 0)
            
            // if Element.self == UInt16.self {
            var minValue = baseAddressFloat32[0]
            var maxValue = baseAddressFloat32[0]
            for y in 0..<height {
                for x in 0..<width {
                    let value = baseAddressFloat32[y*width + x]
                    if value > maxValue { maxValue = value }
                    if value < minValue { minValue = value }
                }
            }
            return (minValue, maxValue)
        }
    }*/
    
    func data(bytesPerPixel: Int) -> Data? {
        return withBaseAddressLocked(.readOnly) {
            /*guard let baseAddress = baseAddress else {
             return nil
             }*/
            
            // According to Core Video engineering, the reason that the bytes per row is rounded up from 180 to 196 is because of a required 16 byte alignment. 180 / 16 = 11.25; 192 / 16 = 12.0.
            // https://stackoverflow.com/questions/46879895/byte-per-row-is-wrong-when-creating-a-cvpixelbuffer-with-width-multiple-of-90
            
            print(self[attachments: .shouldPropagate])
            
            if bytesPerRow != width * bytesPerPixel {
                print(bytesPerRow, width * bytesPerPixel)
                var a = 0
                var b = 0
                var c = 0
                var d = 0
                
                // self.getAttachments(attachmentMode: .shouldNotPropagate) == [:]
                
                // self.getAttachments(attachmentMode: .shouldPropagate) == [
                //      "CVImageBufferTransferFunction": Linear,
                //      "CVImageBufferColorPrimaries": ITU_R_709_2
                //  ]
                
                // print(self.getAttachments(attachmentMode: .shouldPropagate))
                
                print(kCVBufferPropagatedAttachmentsKey)
                CVPixelBufferGetExtendedPixels(self, &a, &b, &c, &d)
                print(a,b,c,d)
            }
            
            let originalData = Data(bytes: baseAddress, count: dataSize)
            return Data((0..<height).map{
                originalData[bytesPerRow * $0 ..< bytesPerRow * $0 + bytesPerPixel * width]
                }.joined())
        }
    }
    
    func setData<T>(data: UnsafeBufferPointer<T>) {
        withBaseAddressLocked {
            /*guard let baseAddress = baseAddress else {
             return
             }*/
            baseAddress.copyMemory(from: UnsafeRawPointer(data.baseAddress!), byteCount: data.count * MemoryLayout<T>.size)
        }
    }
}

/*
 
 
 /*
 subscript(_ x: Int, _ y: Int) -> Float {
 return withBaseAddressLocked(.readOnly) {
 // guard let addr = baseAddress else { return 0 }
 let buffer = baseAddress.assumingMemoryBound(to: Float.self)
 let index = x + (y * width)
 return buffer[index]
 }
 }*/
 
 func normalize() {
 withBaseAddressLocked(.readOnly) {
 let floatPtr = baseAddress.assumingMemoryBound(to: Float.self)
 let width = self.width
 let height = self.height
 let floatBuffer = UnsafeBufferPointer(start: floatPtr, count: width * height)
 var minValue: Float = .greatestFiniteMagnitude
 var maxValue: Float = .leastNormalMagnitude
 for f in floatBuffer {
 minValue = min(minValue, f)
 maxValue = max(maxValue, f)
 }
 let range = maxValue - minValue
 for y in 0 ..< height {
 for x in 0 ..< width {
 let pixel = floatBuffer[y * width + x]
 floatPtr[y * width + x] = 1-(pixel - minValue) / range
 }
 }
 }
 }*/
