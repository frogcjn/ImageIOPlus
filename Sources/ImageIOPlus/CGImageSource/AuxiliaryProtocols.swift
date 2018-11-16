//
//  File.swift
//  get-depth
//
//  Created by Cao, Jiannan on 2018/10/21.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import ImageIO
import AVFoundation

// MARK: - Collection with Aux Image

public protocol CGImageSourceImageCollectionWithAuxImageProtocol : CGImageSourceImageCollectionWithPrimaryImageProtocol where Element : CGImageSourceImageWithAuxProtocol {
    func auxImageIndex(type: CGImageAuxType) -> Index?
    func containsAuxImage(type: CGImageAuxType) -> Bool
    func auxImage(type: CGImageAuxType) -> Element?
    func aux(type: CGImageAuxType) -> CGImageAux?
    
    var depthDataWithoutApplyingOrientation: AVDepthData? { get }
    var depthData: AVDepthData? { get }
    var portraitEffectsMatte: AVPortraitEffectsMatte? { get }
    var portraitEffectsMatteWithoutApplyingOrientation: AVPortraitEffectsMatte? { get }
}

// default implement
public extension CGImageSourceImageCollectionWithAuxImageProtocol {
    func auxImageIndex(type: CGImageAuxType) -> Index? {
        return primaryOrderedIndices.first { self[$0].containsAux(type: type) }
    }
    
    func auxImage(type: CGImageAuxType) -> Element? {
        return auxImageIndex(type: type).map { self[$0] }
    }
    
    func containsAuxImage(type: CGImageAuxType) -> Bool {
        return auxImageIndex(type: type) != nil
    }
    
    func aux(type: CGImageAuxType) -> CGImageAux? {
        return auxImage(type: type)?.aux(type: type)
    }
    
    var depthDataWithoutApplyingOrientation: AVDepthData? {
        do {
            return try (aux(type: .depth) ?? aux(type: .disparity)).map { try AVDepthData(aux: $0) }
        } catch {
            print(error)
            return nil
        }
    }
    
    var depthData: AVDepthData? {
        guard let properties = (auxImage(type: .depth) ?? auxImage(type: .disparity))?.properties else {
            print("disparityOrDepth, invalidProperties")
            return nil
        }
        return depthDataWithoutApplyingOrientation?.applyingExifOrientation(CGImagePropertyOrientation(rawValue: properties[kCGImagePropertyOrientation as String] as! UInt32)!)
    }
    
    var portraitEffectsMatteWithoutApplyingOrientation: AVPortraitEffectsMatte? {
        do {
            return try aux(type: .portraitEffectsMatte).map { try AVPortraitEffectsMatte(aux: $0) }
        } catch {
            print(error)
            return nil
        }
    }
    
    var portraitEffectsMatte: AVPortraitEffectsMatte? {
        guard let properties = auxImage(type: .portraitEffectsMatte)?.properties else {
            print("disparityOrDepth, invalidProperties")
            return nil
        }
        return portraitEffectsMatteWithoutApplyingOrientation?.applyingExifOrientation(CGImagePropertyOrientation(rawValue: properties[kCGImagePropertyOrientation as String] as! UInt32)!)
    }
}

// MARK - Image with Aux Data

public protocol CGImageSourceImageWithAuxProtocol : CGImageSourceImageWithStatusProtocol {
    func aux(type: CGImageAuxType) -> CGImageAux? /* required implement */
    // func aux(at: AT) -> CGImageAux? /* required implement */
    // func rawAux(cgType: CGImageAuxType) -> CFDictionary? /* required implement */
    // func rawAux(type: CGImageSource.AuxType) -> CFDictionary? /* required implement */

    func containsAux(type: CGImageAuxType) -> Bool
    // func containsAux(at: AT) -> Bool
}

// default implement
public extension CGImageSourceImageWithAuxProtocol {
    func containsAux(type: CGImageAuxType) -> Bool {
        return aux(type: type) != nil
    }
    /*func containsAux(at: AT) -> Bool {
        return aux(at: at) != nil
    }*/
}
