//
//  File.swift
//  get-depth
//
//  Created by Cao, Jiannan on 2018/10/21.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import ImageIO

// MARK - Status

public protocol CGImageSourceCollectionWithStatusProtocol {
    var status: CGImageSourceStatus  { get }
    
    var properties: [String: Any]? { get }
    func properties(options: CGImageSource.Options?) -> [String: Any]?
}

public protocol CGImageSourceImageWithStatusProtocol : CGImageSourceCollectionWithStatusProtocol {
    var metadata: CGImageMetadata? { get }
    func metadata(options: CGImageSource.Image.Options?) -> CGImageMetadata?
    
    var thumbnail: CGImage? { get }
    func thumbnail(options: CGImageSource.Image.Options?) -> CGImage?
    
    var cgImage: CGImage? { get }
    func cgImage(options: CGImageSource.Image.Options?) -> CGImage?
    
    func removeCache()
    
    var properties: [String: Any]? { get }
}
