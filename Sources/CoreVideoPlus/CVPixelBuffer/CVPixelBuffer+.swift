//
//  CVPixelBuffer+.swift
//  get-auxiliary
//
//  Created by Cao, Jiannan on 2018/11/5.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import CoreVideo
import ImageIOPlusBase

public extension CVPixelBuffer {
    func pixel<Element>(x: Int, y: Int, elementType: Element.Type) -> Element {
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
    
    func minMaxPixel<Element>(elementType: Element.Type) -> (min: Element, max: Element)? {
        return withBaseAddressLocked(.readOnly) {
            if Element.self == Float16.self {
                var minValue: Float?
                var maxValue: Float?
                for i in 0..<width {
                    for j in 0..<height {
                        let value = pixel(x: i, y:j, elementType: Float16.self).floatValue
                        minValue = minValue.map { min($0, value) } ?? value
                        maxValue = minValue.map { max($0, value) } ?? value
                    }
                }
                
                if let minValue = minValue, let maxValue = maxValue {
                    return (Float16(minValue) as! Element, Float16(maxValue) as! Element)
                }
                return nil
                
            }
            return nil
        }
    }
    
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
