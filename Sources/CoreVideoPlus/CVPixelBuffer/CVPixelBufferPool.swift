//
//  CVPixelBufferPool.swift
//  get-auxiliary
//
//  Created by Cao, Jiannan on 2018/11/4.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import CoreVideo
import ImageIOPlusBase

public extension CVPixelBufferPool {
    /*!
     @function   CVPixelBufferPoolCreate
     @abstract   Creates a new Pixel Buffer pool.
     @param      allocator The CFAllocatorRef to use for allocating this buffer pool.  May be NULL.
     @param      attributes   A CFDictionaryRef containing the attributes to be used for creating new PixelBuffers within the pool.
     @param      poolOut   The newly created pool will be placed here
     @result     Returns kCVReturnSuccess on success
     */
    class func `init`(
        allocator: CFAllocator? = nil,
        _ poolAttributes: Attributes?,
        _ pixelBufferAttributes: CVPixelBuffer.Attributes?,
        _ poolOut: UnsafeMutablePointer<CVPixelBufferPool?>
        ) -> CVReturn {
        return CVPixelBufferPoolCreate(allocator, poolAttributes?.rawValue as CFDictionary?, pixelBufferAttributes?.rawValue as CFDictionary?, poolOut)
    }
}

public extension CVPixelBufferPool {
    /*!
     @function   CVPixelBufferPoolCreatePixelBuffer
     @abstract   Creates a new PixelBuffer object from the pool.
     @discussion The function creates a new (attachment-free) CVPixelBuffer using the pixel buffer attributes specifed during pool creation.
     @param      allocator The CFAllocatorRef to use for creating the pixel buffer.  May be NULL.
     @param      pool      The CVPixelBufferPool that should create the new CVPixelBuffer.
     @param      pixelBufferOut   The newly created pixel buffer will be placed here
     @result     Returns kCVReturnSuccess on success
     */
    class func createPixelBuffer(
        allocator: CFAllocator?,
        _ pixelBufferPool: CVPixelBufferPool,
        _ pixelBufferOut: UnsafeMutablePointer<CVPixelBuffer?>
        ) -> CVReturn {
        return CVPixelBufferPoolCreatePixelBuffer(allocator, pixelBufferPool, pixelBufferOut)
    }
    
    /*
     @function   CVPixelBufferPoolCreatePixelBufferWithAuxAttributes
     @abstract   Creates a new PixelBuffer object from the pool.
     @discussion This function creates a new CVPixelBuffer using the pixel buffer attributes specified during pool creation and the attributes specified in the auxAttributes parameter.
     @param      allocator The CFAllocatorRef to use for creating the pixel buffer.  May be NULL.
     @param      pixelBufferPool      The CVPixelBufferPool that should create the new CVPixelBuffer.
     @param      auxAttributes    Attributes describing this specific allocation request.  May be NULL.
     @param      pixelBufferOut   The newly created pixel buffer will be placed here
     @result     Returns kCVReturnSuccess on success
     */
    class func createPixelBufferWithAuxAttributes(
        _ allocator: CFAllocator?,
        _ pixelBufferPool: CVPixelBufferPool,
        _ auxAttributes: CFDictionary?,
        _ pixelBufferOut: UnsafeMutablePointer<CVPixelBuffer?>
        ) -> CVReturn
    {
        return CVPixelBufferPoolCreatePixelBufferWithAuxAttributes(allocator, pixelBufferPool, auxAttributes, pixelBufferOut)
    }
    
    /*!
     @function       CVPixelBufferPoolFlush
     @abstract       Frees as many buffers from the pool as possible.
     @discussion     By default, this function will free all aged out buffers.  Setting the
     kCVPixelBufferPoolFlushExcessBuffers flag will cause this call to free all unused
     buffers regardless of age.
     @param        pool    The CVPixelBufferPool to be flushed.
     @param        options Set to kCVPixelBufferPoolFlushExcessBuffers to free all unused buffers
     regardless of their age.
     */
    func flush(_ options: CVPixelBufferPoolFlushFlags) {
        CVPixelBufferPoolFlush(self, options)
    }
    
}

public extension CVPixelBufferPool {
    /*
     @function   CVPixelBufferPoolGetAttributes
     @abstract   Returns the pool attributes dictionary for a CVPixelBufferPool
     @param      pool  The CVPixelBufferPoolRef to retrieve the attributes from
     @result     Returns the pool attributes dictionary, or NULL on failure.
     */
    @available(OSX 10.4, *)
    var attributes: CFDictionary? {
        return CVPixelBufferPoolGetAttributes(self)
    }
    
    /*!
     @function   CVPixelBufferPoolGetPixelBufferAttributes
     @abstract   Returns the attributes of pixel buffers that will be created from this pool.
     @discussion This function is provided for those cases where you may need to know some information about the buffers that
     will be created up front.
     @param      pool  The CVPixelBufferPoolRef to retrieve the attributes from
     @result     Returns the pixel buffer attributes dictionary, or NULL on failure.
     */
    @available(OSX 10.4, *)
    public var pixelBufferAttributes: CFDictionary? {
        return CVPixelBufferPoolGetPixelBufferAttributes(self)
    }

    @available(OSX 10.4, *)
    public class var typeID: CFTypeID {
        return CVPixelBufferPoolGetTypeID()
    }
        
}

public extension CVPixelBufferPool {
    struct Attributes : RawKeyDictionaryWrapper {
        public enum Key : String {
            case poolName                             = "PoolName" // String
            case poolAdjustableBaseAddressGranularity = "PoolAdjustableBaseAddressGranularity" // Int
            case poolWorstCaseBytesPerRow             = "PoolWorstCaseBytesPerRow" // Int
            case poolMinimumBufferCount               = "PoolMinimumBufferCount" // Int
            case poolMaximumBufferAge                 = "PoolMaximumBufferAge" // CFAbsoluteTime -> Double
            
        }
        
        public let poolName                             : String?
        public let poolAdjustableBaseAddressGranularity : Int?
        public let poolWorstCaseBytesPerRow             : Int?
        public let poolMinimumBufferCount               : Int?
        public let poolMaximumBufferAge                 : CFAbsoluteTime?
        // TODO: 2018-11-03
        
        public let rawValue: RawKeyDict
        public init(dict: Dict, rawKeyDict: RawKeyDict) {
            rawValue = rawKeyDict
            
            poolName                             = dict[.poolName].map(cfString)
            poolAdjustableBaseAddressGranularity = dict[.poolAdjustableBaseAddressGranularity].map(cfInt)
            poolWorstCaseBytesPerRow             = dict[.poolWorstCaseBytesPerRow].map(cfInt)
            poolMinimumBufferCount               = dict[.poolMinimumBufferCount].map(cfInt)
            poolMaximumBufferAge                 = dict[.poolMaximumBufferAge].map(cfDouble)
        }
    }
}

public extension CVPixelBufferPool {
    struct AuxAttributes : RawKeyDictionaryWrapper {
        public enum Key : String {
            case poolAllocationThreshold = "BufferPoolAllocationThreshold"
        }
        
        public let poolAllocationThreshold: Int
        
        public let rawValue: RawKeyDict
        public init?(dict: Dict, rawKeyDict: RawKeyDict) {
            rawValue = rawKeyDict
            
            poolAllocationThreshold = dict[.poolAllocationThreshold].map(cfInt)!
            
        }
    }
}



/*
 // By default, buffers will age out after one second.   If required, setting an age of zero will disable
// the age-out mechanism completely.

public let kCVPixelBufferPoolMinimumBufferCountKey: CFString
public let kCVPixelBufferPoolMaximumBufferAgeKey: CFString
 
 // Key for the auxiliary attributes dictionary passed to CVPixelBufferPoolCreatePixelBufferWithAuxAttributes().
 
 // When set, indicates that a new pixel buffer should not be allocated if
 // the pool already has this many or more pixel buffers allocated.
 // This does not prevent already-allocated buffers from being recycled.
 // If this key causes CVPixelBufferPoolCreatePixelBufferWithAuxAttributes to fail,
 // it will return kCVReturnWouldExceedAllocationThreshold.
 public let kCVPixelBufferPoolAllocationThresholdKey: CFString // CFNumberRef -- for use only in auxAttributes
 
 // kCVPixelBufferPoolFreeBufferNotification is posted if a buffer becomes available after
 // CVPixelBufferPoolCreatePixelBufferWithAuxAttributes has failed due to kCVPixelBufferPoolAllocationThresholdKey.
 // This notification will not be posted by the pool if kCVPixelBufferPoolAllocationThresholdKey
 // has never been passed to CVPixelBufferPoolCreatePixelBufferWithAuxAttributes.
 public let kCVPixelBufferPoolFreeBufferNotification: CFString
 
 
 /*!
 @enum CVPixelBufferPoolFlush flags
 @discussion Flags to pass to CVPixelBufferPoolFlush()
 @constant kCVPixelBufferPoolFlushExcessBuffers
 This flag will cause CVPixelBufferPoolFlush to flush all unused buffers regardless of age.
 */
 public struct CVPixelBufferPoolFlushFlags : OptionSet {
 
 public init(rawValue: CVOptionFlags)
 
 
 public static var excessBuffers: CVPixelBufferPoolFlushFlags { get }
 }
*/

