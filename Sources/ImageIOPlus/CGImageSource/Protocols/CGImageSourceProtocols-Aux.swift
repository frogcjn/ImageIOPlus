//
//  File.swift
//  get-depth
//
//  Created by Cao, Jiannan on 2018/10/21.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import ImageIO
import AVFoundation

// MARK: - Aux Protocol

public protocol CGImageSourceSharedAuxProtocol {
    func aux(type: CGImageAuxType) -> CGImageAux? /* required implementation for CGImageSourceImage */
    func containsAux(type: CGImageAuxType) -> Bool
    
    var depthDataWithoutApplyingOrientation: AVDepthData? { get }
    var portraitEffectsMatteWithoutApplyingOrientation: AVPortraitEffectsMatte? { get }
    
    var depthData: AVDepthData? { get }
    var portraitEffectsMatte: AVPortraitEffectsMatte? { get }
}


// MARK: - Aux of ImageSource

public protocol CGImageSourceAuxProtocol : CGImageSourceSharedAuxProtocol, CGImageSourceCollectionProtocol {
    func auxImageIndex(type: CGImageAuxType) -> Self.Index?
    
    func auxImage(type: CGImageAuxType) -> Self.Element?
    func containsAuxImage(type: CGImageAuxType) -> Bool
}

// MARK: - Aux of ImageSourceImage

public protocol CGImageSourceImageAuxProtocol : CGImageSourceSharedAuxProtocol {
    
}

// MARK: - Default Implementation: Aux
public extension CGImageSourceSharedAuxProtocol {
    func containsAux(type: CGImageAuxType) -> Bool {
        return aux(type: type) != nil
    }
}

// MARK: - Default Implementation: Aux of Image
extension CGImageSourceImageAuxProtocol where Self : CGImageSourceImageStatusProtocol {
    
    public var depthDataWithoutApplyingOrientation: AVDepthData? {
        do {
            return try (aux(type: .disparity) ?? aux(type: .depth)).map { try AVDepthData(aux: $0) }
        } catch {
            print(error)
            return nil
        }
    }
    public var portraitEffectsMatteWithoutApplyingOrientation: AVPortraitEffectsMatte? {
        do {
            return try aux(type: .portraitEffectsMatte).map { try AVPortraitEffectsMatte(aux: $0) }
        } catch {
            print(error)
            return nil
        }
    }
    
    public var depthData: AVDepthData? {
        guard let properties = /*(auxImage(type: .depth) ?? auxImage(type: .disparity))?*/self.properties else {
            print("disparityOrDepth, invalidProperties")
            return nil
        }
        return depthDataWithoutApplyingOrientation?.applyingExifOrientation(CGImagePropertyOrientation(rawValue: properties[kCGImagePropertyOrientation as String] as! UInt32)!)
    }
    
    public var portraitEffectsMatte: AVPortraitEffectsMatte? {
        guard let properties = /*auxImage(type: .portraitEffectsMatte)?*/ self.properties else {
            print("disparityOrDepth, invalidProperties")
            return nil
        }
        return portraitEffectsMatteWithoutApplyingOrientation?.applyingExifOrientation(CGImagePropertyOrientation(rawValue: properties[kCGImagePropertyOrientation as String] as! UInt32)!)
    }
}

// MARK: - Default Implementation: Aux of ImageSource
public extension CGImageSourceAuxProtocol where Self.Element : CGImageSourceImageAuxProtocol {
    
    // aux image
    func auxImageIndex(type: CGImageAuxType) -> Self.Index? {
        return primaryOrderedIndices.first { self[$0].containsAux(type: type) }
    }
    
    func auxImage(type: CGImageAuxType) -> Self.Element? {
        return auxImageIndex(type: type).map { self[$0] }
    }
    
    func containsAuxImage(type: CGImageAuxType) -> Bool {
        return auxImageIndex(type: type) != nil
    }
    
    // aux
    public func aux(type: CGImageAuxType) -> CGImageAux? {
        return auxImage(type: type)?.aux(type: type)
    }
    
    public var depthDataWithoutApplyingOrientation: AVDepthData? {
        return (auxImage(type: .disparity) ?? auxImage(type: .depth))?.depthDataWithoutApplyingOrientation
    }
    
    public var portraitEffectsMatteWithoutApplyingOrientation: AVPortraitEffectsMatte? {
        return auxImage(type: .portraitEffectsMatte)?.portraitEffectsMatteWithoutApplyingOrientation
    }
    
    public var depthData: AVDepthData? {
        return (auxImage(type: .disparity) ?? auxImage(type: .depth))?.depthData
    }
    
    public var portraitEffectsMatte: AVPortraitEffectsMatte? {
        return auxImage(type: .portraitEffectsMatte)?.portraitEffectsMatte
    }
}



/*
// default implement
public extension CGImageSourceImageWithAuxProtocol {
    func containsAux(type: CGImageAuxType) -> Bool {
        return aux(type: type) != nil
    }
    /*func containsAux(at: AT) -> Bool {
        return aux(at: at) != nil
    }*/
}
*/





/*
 func aux(type: CGImageAuxType) -> CGImageAux? /* required implement */
 // func aux(at: AT) -> CGImageAux? /* required implement */
 // func rawAux(cgType: CGImageAuxType) -> CFDictionary? /* required implement */
 // func rawAux(type: CGImageSource.AuxType) -> CFDictionary? /* required implement */
 
 func containsAux(type: CGImageAuxType) -> Bool
 // func containsAux(at: AT) -> Bool
 */

/*
 public protocol CGImageSourceAuxImageProtocol : CGImageSourceCollectionProtocol {
 func auxImageIndex(type: CGImageAuxType) -> Index?
 func containsAuxImage(type: CGImageAuxType) -> Bool
 func auxImage(type: CGImageAuxType) -> Element?
 }
 
 // MARK default implementation
 public extension CGImageSourceAuxImageProtocol where Self.Element : AuxProtocol {
 
 }*/

