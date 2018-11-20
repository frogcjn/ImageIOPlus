//
//  CGImageMetadata+Swift.swift
//  get-depth
//
//  Created by Cao, Jiannan on 2018/10/20.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import Foundation
/*
CGImageMetadata

CGImageMetadataCreateMutable()
CGImageMetadataCreateXMPData
CGImageMetadataCreateFromXMPData
CGImageMetadataCreateMutableCopy(<#T##metadata: CGImageMetadata##CGImageMetadata#>)

CGImageMetadataGetTypeID()

CGImageMetadataCopyTags(<#T##metadata: CGImageMetadata##CGImageMetadata#>)
CGImageMetadataCopyTagWithPath(<#T##metadata: CGImageMetadata##CGImageMetadata#>, <#T##parent: CGImageMetadataTag?##CGImageMetadataTag?#>, <#T##path: CFString##CFString#>)
CGImageMetadataCopyTagMatchingImageProperty(<#T##metadata: CGImageMetadata##CGImageMetadata#>, <#T##dictionaryName: CFString##CFString#>, <#T##propertyName: CFString##CFString#>)

CGImageMetadataCopyStringValueWithPath(<#T##metadata: CGImageMetadata##CGImageMetadata#>, <#T##parent: CGImageMetadataTag?##CGImageMetadataTag?#>, <#T##path: CFString##CFString#>)

CGImageMetadataSetTagWithPath(<#T##metadata: CGMutableImageMetadata##CGMutableImageMetadata#>, <#T##parent: CGImageMetadataTag?##CGImageMetadataTag?#>, <#T##path: CFString##CFString#>, <#T##tag: CGImageMetadataTag##CGImageMetadataTag#>)
CGImageMetadataSetValueWithPath(<#T##metadata: CGMutableImageMetadata##CGMutableImageMetadata#>, <#T##parent: CGImageMetadataTag?##CGImageMetadataTag?#>, <#T##path: CFString##CFString#>, <#T##value: CFTypeRef##CFTypeRef#>)
CGImageMetadataSetValueMatchingImageProperty(<#T##metadata: CGMutableImageMetadata##CGMutableImageMetadata#>, <#T##dictionaryName: CFString##CFString#>, <#T##propertyName: CFString##CFString#>, <#T##value: CFTypeRef##CFTypeRef#>)
CGImageMetadataRemoveTagWithPath(<#T##metadata: CGMutableImageMetadata##CGMutableImageMetadata#>, <#T##parent: CGImageMetadataTag?##CGImageMetadataTag?#>, <#T##path: CFString##CFString#>)

CGImageMetadataEnumerateTagsUsingBlock(<#T##metadata: CGImageMetadata##CGImageMetadata#>, <#T##rootPath: CFString?##CFString?#>, <#T##options: CFDictionary?##CFDictionary?#>, <#T##block: CGImageMetadataTagBlock##CGImageMetadataTagBlock##(CFString, CGImageMetadataTag) -> Bool#>)
CGImageMetadataRegisterNamespaceForPrefix(<#T##metadata: CGMutableImageMetadata##CGMutableImageMetadata#>, <#T##xmlns: CFString##CFString#>, <#T##prefix: CFString##CFString#>, <#T##err: UnsafeMutablePointer<Unmanaged<CFError>?>?##UnsafeMutablePointer<Unmanaged<CFError>?>?#>)

CGImageMetadataTag

CGImageMetadataTagCreate(<#T##xmlns: CFString##CFString#>, <#T##prefix: CFString?##CFString?#>, <#T##name: CFString##CFString#>, <#T##type: CGImageMetadataType##CGImageMetadataType#>, <#T##value: CFTypeRef##CFTypeRef#>)

CGImageMetadataTagGetType(<#T##tag: CGImageMetadataTag##CGImageMetadataTag#>)
CGImageMetadataTagGetTypeID()

CGImageMetadataTagCopyName(<#T##tag: CGImageMetadataTag##CGImageMetadataTag#>)
CGImageMetadataTagCopyValue(<#T##tag: CGImageMetadataTag##CGImageMetadataTag#>)
CGImageMetadataTagCopyPrefix(<#T##tag: CGImageMetadataTag##CGImageMetadataTag#>)
CGImageMetadataTagCopyNamespace(<#T##tag: CGImageMetadataTag##CGImageMetadataTag#>)
CGImageMetadataTagCopyQualifiers(<#T##tag: CGImageMetadataTag##CGImageMetadataTag#>)


CGImageMetadataType
CGImageMetadataErrors
CGImageMetadataTagBlock
*/

