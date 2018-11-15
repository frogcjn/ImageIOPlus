//
//  File.swift
//  get-depth
//
//  Created by Cao, Jiannan on 2018/10/21.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import ImageIO
import AVFoundation

// MARK: - Collection with Auxiliary Image

public protocol CGImageSourceImageCollectionWithAuxiliaryImageProtocol : CGImageSourceImageCollectionWithPrimaryImageProtocol where Element : CGImageSourceImageWithAuxiliaryDataProtocol {
    func auxiliaryImageIndex(type: CGImageSource.AuxiliaryType) -> Index?
    func containsAuxiliaryImage(type: CGImageSource.AuxiliaryType) -> Bool
    func auxiliaryImage(type: CGImageSource.AuxiliaryType) -> Element?

    func auxiliaryData(type: CGImageSource.AuxiliaryType) -> CGImageSourceImage.AuxiliaryDataInfo?
    var depthData: AVDepthData? { get }
    var matte: AVPortraitEffectsMatte? { get }
}

// default implement
public extension CGImageSourceImageCollectionWithAuxiliaryImageProtocol {
    func auxiliaryImageIndex(type: CGImageSource.AuxiliaryType) -> Index? {
        return primaryOrderedIndices.first { self[$0].containsAuxiliaryData(type: type) }
    }
    
    func auxiliaryImage(type: CGImageSource.AuxiliaryType) -> Element? {
        return auxiliaryImageIndex(type: type).map { self[$0] }
    }
    
    func containsAuxiliaryImage(type: CGImageSource.AuxiliaryType) -> Bool {
        return auxiliaryImageIndex(type: type) != nil
    }
    
    func auxiliaryData(type: CGImageSource.AuxiliaryType) -> CGImageSourceImage.AuxiliaryDataInfo? {
        return auxiliaryImage(type: type)?.auxiliaryData(type: type)
    }
    
    var depthDataWithoutApplyingOrientation: AVDepthData? {
        do {
            return try auxiliaryData(type: .disparityOrDepth).map { try AVDepthData(auxiliaryData: $0) }
        } catch {
            print(error)
            return nil
        }
    }
    
    var depthData: AVDepthData? {
        guard let properties = auxiliaryImage(type: .disparityOrDepth)?.properties else {
            print("disparityOrDepth, invalidProperties")
            return nil
        }
        return depthDataWithoutApplyingOrientation?.applyingExifOrientation(CGImagePropertyOrientation(rawValue: properties[kCGImagePropertyOrientation as String] as! UInt32)!)
    }
    
    var matte: AVPortraitEffectsMatte? {
        do {
            return try auxiliaryData(type: .matte).map { try AVPortraitEffectsMatte(auxiliaryData: $0) }
        } catch {
            print(error)
            return nil
        }
    }
}

// MARK - Image with Auxiliary Data

@available(OSX 10.13, *)
public protocol CGImageSourceImageWithAuxiliaryDataProtocol : CGImageSourceImageWithStatusProtocol {
    func auxiliaryData(cgType: CGImageAuxiliaryDataType) -> CGImageSourceImage.AuxiliaryDataInfo? /* required implement */
    func auxiliaryData(type: CGImageSource.AuxiliaryType) -> CGImageSourceImage.AuxiliaryDataInfo? /* required implement */
    func rawAuxiliaryData(cgType: CGImageAuxiliaryDataType) -> CFDictionary? /* required implement */
    func rawAuxiliaryData(type: CGImageSource.AuxiliaryType) -> CFDictionary? /* required implement */

    func containsAuxiliaryData(cgType: CGImageAuxiliaryDataType) -> Bool
    func containsAuxiliaryData(type: CGImageSource.AuxiliaryType) -> Bool
}

// default implement
@available(OSX 10.13, *)
public extension CGImageSourceImageWithAuxiliaryDataProtocol {
    func containsAuxiliaryData(cgType: CGImageAuxiliaryDataType) -> Bool {
        return auxiliaryData(cgType: cgType) != nil
    }
    func containsAuxiliaryData(type: CGImageSource.AuxiliaryType) -> Bool {
        return auxiliaryData(type: type) != nil
    }
}
