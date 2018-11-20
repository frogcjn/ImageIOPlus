//
//  File.swift
//  get-depth
//
//  Created by Cao, Jiannan on 2018/10/21.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import ImageIO

// MARK: - Status
public protocol CGImageSourceSharedStatusProtocol {
    var status: CGImageSourceStatus  { get } /*implementation required*/
    func properties(options: CGImageSource.Options?) -> /*CGImageProperties*/[String: Any]?  /*implementation required*/
    
    var properties: /*CGImageProperties*/[String: Any]? { get }
}

// MARK: - Status of ImageSource
public protocol CGImageSourceStatusProtocol : CGImageSourceSharedStatusProtocol {
    
}

// MARK: - Status of ImageSourceImage
public protocol CGImageSourceImageStatusProtocol : CGImageSourceSharedStatusProtocol {
    
    /* implementation required */
    func metadata(options: CGImageSourceImage.Options?) -> CGImageMetadata?
    func thumbnail(options: CGImageSourceImage.Options?) -> CGImage?
    func cgImage(options: CGImageSourceImage.Options?) -> CGImage?
    func removeCache()
    
    /* has default implementation */
    var metadata: CGImageMetadata? { get }
    var thumbnail: CGImage? { get }
    var cgImage: CGImage? { get }
}


// MARK: - Default Implementation: Status
public extension CGImageSourceSharedStatusProtocol {
    var properties: [String: Any]? { return properties(options: nil) }
}

// MARK: - Default Implementation: Status of ImageSourceImage
public extension CGImageSourceImageStatusProtocol {
    public var metadata: CGImageMetadata? {
        return metadata(options: nil)
    }
    public var thumbnail: CGImage? {
        return thumbnail(options: nil)
    }
    public var cgImage: CGImage? {
        return cgImage(options: nil)
    }
}
