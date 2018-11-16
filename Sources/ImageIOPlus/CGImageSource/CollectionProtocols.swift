//
//  ImageCollection.swift
//  get-depth
//
//  Created by Cao, Jiannan on 2018/10/21.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//


// MARK: - Collection

public protocol CGImageSourceImageCollectionProtocol : Collection {
    // collection
    var count: Int { get } /* required implement */
    subscript(_ index: Int) -> Element { get } /* required implement */
    
    // convenience
    var containsImage: Bool { get }
    
    associatedtype Elements : Collection where Elements.Element == Self.Element
    var images: Elements { get }
}

// default implement
public extension CGImageSourceImageCollectionProtocol {
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
    
    // convenience
    public var containsImage: Bool {
        return !isEmpty
    }
    
    public var images: LazyMapCollection<Indices, Element> {
        return indices.lazy.map { self[$0] }
    }
}

// MARK: - Collection with Primary Image

public protocol CGImageSourceImageCollectionWithPrimaryImageProtocol : CGImageSourceImageCollectionProtocol {
    
    var primaryImageIndex: Int? { get } /* requireed */
    var primaryOrderedIndices: Indices { get }
    
    var primaryImage: Element? { get }
    var primaryOrderedImages: Elements { get }
}

// default implement
public extension CGImageSourceImageCollectionWithPrimaryImageProtocol {
    
    public var primaryImage: Element? {
        return primaryImageIndex.map { self[$0] }
    }
    
    public var primaryOrderedImages: LazyMapCollection<Indices, Element> {
        return primaryOrderedIndices.lazy.map { self[$0] }
    }
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
}
