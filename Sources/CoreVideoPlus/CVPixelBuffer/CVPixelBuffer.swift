//
//  CVPixelBuffer+.swift
//  ImageIOExtension
//
//  Created by Cao, Jiannan on 2018/11/1.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import CoreFoundation
import CoreVideo

public extension CVPixelBuffer {
    
    // typeID
    class var typeID: CFTypeID {
        return CVPixelBufferGetTypeID()
    }
    
    // create
    /*!
     @function   CVPixelBufferCreate
     @abstract   Call to create a single PixelBuffer for a given size and pixelFormatType.
     @discussion Creates a single PixelBuffer for a given size and pixelFormatType. It allocates the necessary memory based on the pixel dimensions, pixelFormatType and extended pixels described in the pixelBufferAttributes. Not all parameters of the pixelBufferAttributes will be used here.
     @param      width   Width of the PixelBuffer in pixels.
     @param      height  Height of the PixelBuffer in pixels.
     @param    pixelFormat       Pixel format indentified by its respective CVPixelFormat.
     @param    pixelBufferAttributes      A dictionary with additional attributes for a pixel buffer. This parameter is optional. See BufferAttributeKeys for more details.
     @param      pixelBufferOut          The new pixel buffer will be returned here
     @result    returns kCVReturnSuccess on success.
     */
    public class func `init`(
        allocator: CFAllocator? = nil,
        pixelFormat: CVPixelFormat,
        size: Int.Size,
        attributes: Attributes? = nil
    ) throws -> CVPixelBuffer? {
        let pixelFormat = pixelFormat.rawValue
        let attributes = attributes?.rawValue as CFDictionary?

        var pixelBuffer: CVPixelBuffer?
        let `return` = CVPixelBufferCreate(allocator, size.width, size.height, pixelFormat, attributes, &pixelBuffer)
        let returnStatus = CVReturnStatus(rawValue: `return`)!
        try returnStatus.throwIfNotSuccess()
        
        return pixelBuffer
    }

    /*!
     @function   CVPixelBufferCreateWithBytes
     @abstract   Call to create a single PixelBuffer for a given size and pixelFormatType based on a passed in piece of memory.
     @discussion Creates a single PixelBuffer for a given size and pixelFormatType. Not all parameters of the pixelBufferAttributes will be used here. It requires a release callback function that will be called, when the PixelBuffer gets destroyed so that the owner of the pixels can free the memory.
     @param      width   Width of the PixelBuffer in pixels
     @param      height  Height of the PixelBuffer in pixels
     @param      pixelFormat        Pixel format indentified by its respective CVPixelFormat.
     @param      baseAddress        Address of the memory storing the pixels.
     @param      bytesPerRow        Row bytes of the pixel storage memory.
     @param      releaseCallback         CVPixelBufferReleaseBytePointerCallback function that gets called when the PixelBuffer gets destroyed.
     @param      releaseRefCon           User data identifying the PixelBuffer for the release callback.
     @param      pixelBufferAttributes      A dictionary with additional attributes for a a pixel buffer. This parameter is optional. See PixelBufferAttributes for more details.
     @param      pixelBufferOut          The new pixel buffer will be returned here
     @result    returns kCVReturnSuccess on success.
     */
    public func `init`(
        allocator: CFAllocator? = nil,
        pixelFormat: CVPixelFormat,
        planeInfo: PlaneInfo,
        attributes: Attributes? = nil,
        releaseCallback: ReleaseBytesCallback? = nil,
        releaseRefCon: UnsafeMutableRawPointer? = nil
    ) throws -> CVPixelBuffer? {
        let pixelFormat = pixelFormat.rawValue
        let attributes = attributes?.rawValue as CFDictionary?

        var pixelBuffer: CVPixelBuffer?
        let `return` = CVPixelBufferCreateWithBytes(
            allocator,
            planeInfo.size.width,
            planeInfo.size.height,
            pixelFormat,
            planeInfo.baseAddress,
            planeInfo.bytesPerRow,
            releaseCallback,
            releaseRefCon,
            attributes,
            &pixelBuffer)
        let returnStatus = CVReturnStatus(rawValue: `return`)!
        try returnStatus.throwIfNotSuccess()
        
        return pixelBuffer
    }

    /*!
     @function   CVPixelBufferCreateWithPlanarBytes
     @abstract   Call to create a single PixelBuffer in planar format for a given size and pixelFormatType based on a passed in piece of memory.
     @discussion Creates a single PixelBuffer for a given size and pixelFormatType. Not all parameters of the pixelBufferAttributes will be used here. It requires a release callback function that will be called, when the PixelBuffer gets destroyed so that the owner of the pixels can free the memory.
     @param      width            Width of the PixelBuffer in pixels
     @param      height            Height of the PixelBuffer in pixels
     @param      pixelFormat        Pixel format indentified by its respective CVPixelFormat.
     @param    dataPtr            Pass a pointer to a plane descriptor block, or NULL.
     @param    dataSize        pass size if planes are contiguous, NULL if not.
     @param    numberOfPlanes        Number of planes.
     @param    planeBaseAddress    Array of base addresses for the planes.
     @param    planeWidth        Array of plane widths.
     @param    planeHeight        Array of plane heights.
     @param    planeBytesPerRow    Array of plane bytesPerRow values.
     @param    releaseCallback        CVPixelBufferReleaseBytePointerCallback function that gets called when the PixelBuffer gets destroyed.
     @param    releaseRefCon        User data identifying the PixelBuffer for the release callback.
     @param    pixelBufferAttributes      A dictionary with additional attributes for a a pixel buffer. This parameter is optional. See PixelBufferAttributes for more details.
     @param      pixelBufferOut          The new pixel buffer will be returned here
     @result    returns kCVReturnSuccess on success.
     */
    public func `init`(
        allocator: CFAllocator? = nil,
        pixelFormat: CVPixelFormat,
        size: Int.Size,
        planeDescriptor: UnsafeMutableRawPointer? = nil,
        planeDataSize: Int? = nil,
        planeInfos: [PlaneInfo],
        attributes: Attributes? = nil,
        releaseCallback: ReleasePlanarBytesCallback? = nil,
        releaseRefCon: UnsafeMutableRawPointer? = nil
        ) throws -> CVPixelBuffer? {
        let pixelFormat = pixelFormat.rawValue
        let attributes = attributes?.rawValue as CFDictionary?

        let planeCount         = planeInfos.count
        var planeBaseAddresses = planeInfos.map { $0.baseAddress as UnsafeMutableRawPointer? }
        var planeWidths        = planeInfos.map { $0.size.width }
        var planeHeights       = planeInfos.map { $0.size.height }
        var planeBytesPerRow   = planeInfos.map { $0.bytesPerRow }
        
        var pixelBuffer: CVPixelBuffer?
        
        let `return` = CVPixelBufferCreateWithPlanarBytes(
            allocator,
            size.width,
            size.height,
            pixelFormat,
            planeDescriptor,
            planeDataSize ?? 0,
            
            planeCount,
            &planeBaseAddresses,
            &planeWidths,
            &planeHeights,
            &planeBytesPerRow,
            
            releaseCallback,
            releaseRefCon,
            attributes,
            &pixelBuffer
        )
        
        let returnStatus = CVReturnStatus(rawValue: `return`)!
        try returnStatus.throwIfNotSuccess()

        return pixelBuffer
    }
    
    public typealias PlaneInfo = (size: Int.Size, bytesPerRow: Int, baseAddress: UnsafeMutableRawPointer)
    public typealias ReleaseBytesCallback = @convention(c) (UnsafeMutableRawPointer?, UnsafeRawPointer?) -> Void
    public typealias ReleasePlanarBytesCallback = @convention(c) (UnsafeMutableRawPointer?, UnsafeRawPointer?, Int, Int, UnsafeMutablePointer<UnsafeRawPointer?>?) -> Void
}

public extension CVPixelBuffer {
    /*!
     @function   CVPixelBufferCreateResolvedAttributesDictionary
     @abstract   Takes a CFArray of CFDictionary objects describing various pixel buffer attributes and tries to resolve them into a
     single dictionary.
     @discussion This is useful when you need to resolve multiple requirements between different potential clients of a buffer.
     @param      attributes CFArray of CFDictionaries containing kCVPixelBuffer key/value pairs.
     @param      resolvedDictionaryOut The resulting dictionary will be placed here.
     @result     Return value that may be useful in discovering why resolution failed.
     */
    class func resolve(
        allocator: CFAllocator? = nil,
        attributesArray: [Attributes]
        ) throws -> Attributes {
        let rawInputAttributes = attributesArray.map { $0.rawValue as CFDictionary } as CFArray
        
        var rawOutputAttributes: CFDictionary?
        let `return` = CVPixelBufferCreateResolvedAttributesDictionary(allocator, rawInputAttributes, &rawOutputAttributes)
        let returnStatus = CVReturnStatus(rawValue: `return`)!
        guard case .success = returnStatus else { throw returnStatus }
        
        let outputAttributs = rawOutputAttributes.map{ $0 as [NSObject : AnyObject] as! [String: Any] }.map { Attributes(rawValue: $0)! }!
        return outputAttributs
    }
}

public extension CVPixelBuffer {
    /*!
     @function   CVPixelBufferGetPixelFormatType
     @abstract   Returns the PixelFormatType of the PixelBuffer.
     @result     CVPixelFormat identifying the pixel format by its type.
     */
    var pixelFormat: CVPixelFormat {
        return CVPixelFormat(rawValue: CVPixelBufferGetPixelFormatType(self))!
    }
    
    /*!
     @function   CVPixelBufferGetWidth
     @abstract   Returns the width of the PixelBuffer.
     @result     Width in pixels.
     */
    var width: Int {
        return CVPixelBufferGetWidth(self)
    }
    
    /*!
     @function   CVPixelBufferGetHeight
     @abstract   Returns the height of the PixelBuffer.
     @result     Height in pixels.
     */
    var height: Int {
        return CVPixelBufferGetHeight(self)
    }
    
    /*!
     @function   CVPixelBufferGetBytesPerRow
     @abstract   Returns the rowBytes of the PixelBuffer.
     @result     Bytes per row of the image data.   For planar buffers this will return a rowBytes value such that bytesPerRow * height
     will cover the entire image including all planes.
     */
    var bytesPerRow: Int {
        return CVPixelBufferGetBytesPerRow(self)
    }

    /*!
     @function   CVPixelBufferGetBaseAddress
     @abstract   Returns the base address of the PixelBuffer.
     @discussion Retrieving the base address for a PixelBuffer requires that the buffer base address be locked
     via a successful call to CVPixelBufferLockBaseAddress.
     @result     Base address of the pixels.
     For chunky buffers, this will return a pointer to the pixel at 0,0 in the buffer
     For planar buffers this will return a pointer to a PlanarComponentInfo struct (defined in QuickTime).
     */
    var baseAddress: UnsafeMutableRawPointer {
        return CVPixelBufferGetBaseAddress(self)!
    }
    
    
    var planInfo: PlaneInfo {
        return (
            (width, height),
            bytesPerRow,
            baseAddress
        )
    }

}

public extension CVPixelBuffer {
    /*!
     @function   CVPixelBufferIsPlanar
     @abstract   Returns if the PixelBuffer is planar.
     @param      pixelBuffer Target PixelBuffer.
     @result     True if the PixelBuffer was created using CVPixelBufferCreateWithPlanarBytes.
     */
    var isPlanar: Bool {
        return CVPixelBufferIsPlanar(self)
    }
    
    /*!
     @function   CVPixelBufferGetDataSize
     @abstract   Returns the data size for contigous planes of the PixelBuffer.
     @result     Data size used in CVPixelBufferCreateWithPlanarBytes.
     */
    var dataSize: Int {
        return CVPixelBufferGetDataSize(self)
    }

    /*!
     @function   CVPixelBufferGetPlaneCount
     @abstract   Returns number of planes of the PixelBuffer.
     @param      pixelBuffer Target PixelBuffer.
     @result     Number of planes.  Returns 0 for non-planar CVPixelBufferRefs.
     */
    var planeCount: Int {
        return CVPixelBufferGetPlaneCount(self)
    }

    /*!
     @function   CVPixelBufferGetWidthOfPlane
     @abstract   Returns the width of the plane at planeIndex in the PixelBuffer.
     @discussion On OSX 10.10 and earlier, or iOS 8 and earlier, calling this
     function with a non-planar buffer will have undefined behavior.
     @param      pixelBuffer Target PixelBuffer.
     @param      planeIndex  Identifying the plane.
     @result     Width in pixels, or 0 for non-planar CVPixelBufferRefs.
     */
    func widthOfPlane(at planeIndex: Int) -> Int {
        return CVPixelBufferGetWidthOfPlane(self, planeIndex)
    }

    /*!
     @function   CVPixelBufferGetHeightOfPlane
     @abstract   Returns the height of the plane at planeIndex in the PixelBuffer.
     @discussion On OSX 10.10 and earlier, or iOS 8 and earlier, calling this
     function with a non-planar buffer will have undefined behavior.
     @param      pixelBuffer Target PixelBuffer.
     @param      planeIndex  Identifying the plane.
     @result     Height in pixels, or 0 for non-planar CVPixelBufferRefs.
     */
    func heightOfPlane(at planeIndex: Int) -> Int {
        return CVPixelBufferGetHeightOfPlane(self, planeIndex)
    }

    /*!
     @function   CVPixelBufferGetBaseAddressOfPlane
     @abstract   Returns the base address of the plane at planeIndex in the PixelBuffer.
     @discussion Retrieving the base address for a PixelBuffer requires that the buffer base address be locked
     via a successful call to CVPixelBufferLockBaseAddress. On OSX 10.10 and earlier, or iOS 8 and
     earlier, calling this function with a non-planar buffer will have undefined behavior.
     @param      pixelBuffer Target PixelBuffer.
     @param      planeIndex  Identifying the plane.
     @result     Base address of the plane, or NULL for non-planar CVPixelBufferRefs.
     */
    func baseAddressOfPlane(at planeIndex: Int) -> UnsafeMutableRawPointer? {
        return CVPixelBufferGetBaseAddressOfPlane(self, planeIndex)
    }

    /*!
     @function   CVPixelBufferGetBytesPerRowOfPlane
     @abstract   Returns the row bytes of the plane at planeIndex in the PixelBuffer.
     @discussion On OSX 10.10 and earlier, or iOS 8 and earlier, calling this
     function with a non-planar buffer will have undefined behavior.
     @param      pixelBuffer Target PixelBuffer.
     @param      planeIndex  Identifying the plane.
     @result     Row bytes of the plane, or NULL for non-planar CVPixelBufferRefs.
     */
    func bytesPerRowOfPlane(at planeIndex: Int) -> Int {
        return CVPixelBufferGetBytesPerRowOfPlane(self, planeIndex)
    }
    
    func planeInfo(at planeIndex: Int) -> PlaneInfo? {
        return baseAddressOfPlane(at: planeIndex).map {(
            (widthOfPlane(at: planeIndex), heightOfPlane(at: planeIndex)),
            bytesPerRowOfPlane(at: planeIndex),
            $0
        )}
    }
    
    subscript(planeInfo planeIndex: Int) -> PlaneInfo? {
        return planeInfo(at: planeIndex)
    }
    
}

public extension CVPixelBuffer {
    /*!
     @function   CVPixelBufferLockBaseAddress
     @abstract   Description Locks the BaseAddress of the PixelBuffer to ensure that the memory is accessible.
     @discussion This API ensures that the CVPixelBuffer is accessible in system memory. This should only be called if the base address is going to be used and the pixel data will be accessed by the CPU.
     @param      pixelBuffer Target PixelBuffer.
     @param      lockFlags See CVPixelBufferLockFlags.
     @result     kCVReturnSuccess if the lock succeeded, or error code on failure
     */
    func lockBaseAddress(_ lockFlags: CVPixelBufferLockFlags = []) -> CVReturn {
        return CVPixelBufferLockBaseAddress(self, lockFlags)
    }
    
    /*!
     @function   CVPixelBufferUnlockBaseAddress
     @abstract   Description Unlocks the BaseAddress of the PixelBuffer.
     @param      unlockFlags See CVPixelBufferLockFlags.
     @result     kCVReturnSuccess if the unlock succeeded, or error code on failure
     */
    func unlockBaseAddress(_ unlockFlags: CVPixelBufferLockFlags = []) -> CVReturn {
        return CVPixelBufferUnlockBaseAddress(self, unlockFlags)
    }

    func withBaseAddressLocked<T>(
        _ flags: CVPixelBufferLockFlags = [],
        _ f: () throws -> T
        ) rethrows -> T {
        CVPixelBufferLockBaseAddress(self, flags)
        defer { CVPixelBufferUnlockBaseAddress(self, flags) }
        
        return try f()
    }
}

public extension CVPixelBuffer {
    /*!
     @function   CVPixelBufferGetExtendedPixels
     @abstract   Returns the size of extended pixels of the PixelBuffer.
     @discussion On OSX 10.10 and earlier, or iOS 8 and earlier, calling this
     function with a non-planar buffer will have undefined behavior.
     @param      pixelBuffer Target PixelBuffer.
     @param      extraColumnsOnLeft Returns the pixel row padding to the left.  May be NULL.
     @param      extraRowsOnTop Returns the pixel row padding to the top.  May be NULL.
     @param      extraColumnsOnRight Returns the pixel row padding to the right. May be NULL.
     @param      extraRowsOnBottom Returns the pixel row padding to the bottom. May be NULL.
     */
    public var extendedPixels: (left: Int, right: Int,  top: Int, bottom: Int) {
        var extraColumnsOnLeft: Int = 0
        var extraColumnsOnRight: Int = 0
        var extraRowsOnTop: Int = 0
        var extraRowsOnBottom: Int = 0
        
        CVPixelBufferGetExtendedPixels(self, &extraColumnsOnLeft, &extraColumnsOnRight, &extraRowsOnTop, &extraRowsOnBottom)
        
        return (extraColumnsOnLeft, extraColumnsOnRight, extraRowsOnTop, extraRowsOnBottom)
    }
    
    /*!
     @function   CVPixelBufferFillExtendedPixels
     @abstract   Fills the extended pixels of the PixelBuffer.   This function replicates edge pixels to fill the entire extended region of the image.
     @param      pixelBuffer Target PixelBuffer.
     */
    func fillExtendedPixels() throws {
        let `return` = CVPixelBufferFillExtendedPixels(self)
        let returnStatus = CVReturnStatus(rawValue: `return`)!
        try returnStatus.throwIfNotSuccess()
    }
}

public extension Int {
    typealias Size = (width: Int, height: Int)
}
