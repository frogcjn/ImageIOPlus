//
//  CGImageAuxType.swift
//  ImageIOExtension
//
//  Created by Cao, Jiannan on 2018/10/19.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import ImageIO

/*public enum AT : String {
    case disparityOrDepth
    case matte
}*/

public enum CGImageAuxType : String, CaseIterable {
    case disparity            = "kCGImageAuxiliaryDataTypeDisparity"
    case depth                = "kCGImageAuxiliaryDataTypeDepth"
    case portraitEffectsMatte = "kCGImageAuxiliaryDataTypePortraitEffectsMatte"
}
