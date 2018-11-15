//
//  CGImageSourceImage.swift
//  CoreVideoPlus
//
//  Created by Cao, Jiannan on 2018/11/15.
//

import ImageIO

// MARK: - Image of CGImageSource

public struct CGImageSourceImage  {
    public let index: Int
    public unowned let imageSource: CGImageSource
    public init(index: Int, imageSource: CGImageSource) {
        assert(0..<CGImageSourceGetCount(imageSource) ~= index, "index out of range for CGImageSource.")
        self.index = index
        self.imageSource = imageSource
    }
}
