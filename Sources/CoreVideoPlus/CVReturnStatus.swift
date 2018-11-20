//
//  CVReturn.swift
//  get-aux
//
//  Created by Cao, Jiannan on 2018/11/4.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import CoreVideo

public enum CVReturnStatus : RawRepresentable, Swift.Error {
    case success // 0
    case first // -6600
    case last // -6699
    case error(Error)
    
    public var rawValue: CVReturn {
        switch self {
        case .success: return 0
        case .first: return -6600
        case .last: return -6699
        case .error(let error): return error.rawValue
        }
    }
    
    public init?(rawValue: CVReturn) {
        switch rawValue {
        case 0:
            self = .success
        case -6600:
            self = .error(.Error)
        case -6699:
            self = .last
        default:
            guard let error = Error(rawValue: rawValue) else { return nil}
            self = .error(error)
        }
    }
    
    public func throwIfNotSuccess() throws {
        guard case .success = self else {
            if case .error(let error) = self { throw error } else { throw self }
        }
    }
    

    public enum Error : Int32, CaseIterable, Swift.Error {
        case Success                         = 0
        case Error                           = -6600
        case InvalidArgument                 = -6661
        case AllocationFailed                = -6662
        case Unsupported                     = -6663
        
        // DisplayLink related errors
        case InvalidDisplay                  = -6670
        case DisplayLinkAlreadyRunning       = -6671
        case DisplayLinkNotRunning           = -6672
        case DisplayLinkCallbacksNotSet      = -6673
        
        // Buffer related errors
        case InvalidPixelFormat              = -6680
        case InvalidSize                     = -6681
        case InvalidPixelBufferAttributes    = -6682
        case PixelBufferNotOpenGLCompatible  = -6683
        case PixelBufferNotMetalCompatible   = -6684
        
        // Buffer Pool related errors
        case WouldExceedAllocationThreshold  = -6689
        case PoolAllocationFailed            = -6690
        case InvalidPoolAttributes           = -6691
        case Retry                           = -6692
    }

}
/*
{
    case Success                         = 0,
    
    case First                           = -6660,
    
    case Error                           = case First,
    case InvalidArgument                 = -6661,
    case AllocationFailed                = -6662,
    case Unsupported                     = -6663,
    
    // DisplayLink related errors
    case InvalidDisplay                  = -6670,
    case DisplayLinkAlreadyRunning       = -6671,
    case DisplayLinkNotRunning           = -6672,
    case DisplayLinkCallbacksNotSet      = -6673,
    
    // Buffer related errors
    case InvalidPixelFormat              = -6680,
    case InvalidSize                     = -6681,
    case InvalidPixelBufferAttributes    = -6682,
    case PixelBufferNotOpenGLCompatible  = -6683,
    case PixelBufferNotMetalCompatible   = -6684,
    
    // Buffer Pool related errors
    case WouldExceedAllocationThreshold  = -6689,
    case PoolAllocationFailed            = -6690,
    case InvalidPoolAttributes           = -6691,
    case Retry                           = -6692,
    
    case Last                            = -6699
    
};*/
