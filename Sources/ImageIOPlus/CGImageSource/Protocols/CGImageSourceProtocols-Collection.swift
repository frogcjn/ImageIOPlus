//
//  ImageCollection.swift
//  get-depth
//
//  Created by Cao, Jiannan on 2018/10/21.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import ImageIO

// MARK: - Collection of ImageSource
public protocol CGImageSourceCollectionProtocol : Collection {
    
    // collection
    var count: Int { get }     /* required implmentation */
    subscript(_ index: Int) -> Element { get }  /* required implmentation */
    
    // collection convenience of image
    var containsImage: Bool { get }
    
    associatedtype Elements : Collection where Elements.Element == Self.Element
    var images: Elements { get }
    
    // primary image
    var primaryImageIndex: Int? { get }  /* required implmentation */
    var primaryOrderedIndices: Indices { get }
    
    var primaryImage: Element? { get }
    var primaryOrderedImages: Elements { get }
}

// MARK: - Default Impplementation: Collection of ImageSource
public extension CGImageSourceCollectionProtocol where Self.Indices == ArraySlice<Index> {
    // collection
    public var startIndex: Int {
        return 0
    }
    
    public var endIndex: Int {
        return count
    }
    
    public func index(after i: Int) -> Int {
        return i+1
    }
    
    // collection convenience of image
    public var containsImage: Bool {
        return !isEmpty
    }
    
    public var images: LazyMapCollection<Indices, Element> {
        return indices.lazy.map { self[$0] }
    }
    
    // primary image
    public var primaryImage: Element? {
        return primaryImageIndex.map { self[$0] }
    }
    
    public var primaryOrderedImages: LazyMapCollection<Indices, Element> {
        return primaryOrderedIndices.lazy.map { self[$0] }
    }
    
    public var indices: Indices {
        return [Int](0..<count)[...]
    }
    
    public var primaryOrderedIndices: Indices {
        guard let primaryImageIndex = primaryImageIndex else {
            return self.indices
        }
        var indices = self.indices
        indices.insert(indices.remove(at: primaryImageIndex), at: 0)
        return indices
    }
}

/*
public protocol CGImageSourceImageCollectionWithPrimaryImageProtocol : CGImageSourceImageCollectionProtocol {
    
    var primaryImageIndex: Int? { get } /* requireed */
    var primaryOrderedIndices: Indices { get }
    
    var primaryImage: Element? { get }
    var primaryOrderedImages: Elements { get }
}

// default implement
public extension CGImageSourceImageCollectionWithPrimaryImageProtocol {
    

}

// default implementation for indices
public extension CGImageSourceImageCollectionProtocol where Self.Indices == ArraySlice<Index> {
    // make sure indices and primaryOrderedIndices are the same type. So here we implement it as ArraySlice<Int>
    public var indices: Indices {
        return [Int](0..<count)[...]
    }
}

public extension CGImageSourceImageCollectionWithPrimaryImageProtocol where Indices == ArraySlice<Index> {
    
    public var primaryOrderedIndices: Indices {
        guard let primaryImageIndex = primaryImageIndex else {
            return self.indices
        }
        var indices = self.indices
        indices.insert(indices.remove(at: primaryImageIndex), at: 0)
        return indices
    }
}*/
