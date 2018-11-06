//
//  CVPixelType.swift
//  ImageIOExtension
//
//  Created by Cao, Jiannan on 2018/11/2.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import CoreVideo

public enum CVPixelFormat : OSType, CaseIterable {
    // indexed
    case indexed1                       = 0x00000001 /* 1 bit indexed */
    case indexed2                       = 0x00000002 /* 2 bit indexed */
    case indexed4                       = 0x00000004 /* 4 bit indexed */
    case indexed8                       = 0x00000008 /* 8 bit indexed */
    
    // component: matte
    case oneComponent8                  = "L008"     /* 8 bit one component, black is zero */
    case oneComponent16Half             = "L00h"     /* 16 bit one component IEEE half-precision float, 16-bit little-endian samples */
    case oneComponent32Float            = "L00f"     /* 32 bit one component IEEE float, 32-bit little-endian samples */
    case twoComponent8                  = "2C08"     /* 8 bit two component, black is zero */
    case twoComponent16Half             = "2C0h"     /* 16 bit two component IEEE half-precision float, 16-bit little-endian samples */
    case twoComponent32Float            = "2C0f"     /* 32 bit two component IEEE float, 32-bit little-endian samples */
    
    // depth/disparity
    case disparityFloat16               = "hdis"     /* IEEE754-2008 binary16 (half float), describing the normalized shift when comparing two images. Units are 1/meters: ( pixelShift / (pixelFocalLength * baselineInMeters) ) */
    case disparityFloat32               = "fdis"     /* IEEE754-2008 binary32 float, describing the normalized shift when comparing two images. Units are 1/meters: ( pixelShift / (pixelFocalLength * baselineInMeters) ) */
    case depthFloat16                   = "hdep"     /* IEEE754-2008 binary16 (half float), describing the depth (distance to an object) in meters */
    case depthFloat32                   = "fdep"     /* IEEE754-2008 binary32 float, describing the depth (distance to an object) in meters */
    
    // gray
    case indexedGray1WhiteIsZero        = 0x00000021 /* 1 bit indexed gray, white is zero */
    case indexedGray2WhiteIsZero        = 0x00000022 /* 2 bit indexed gray, white is zero */
    case indexedGray4WhiteIsZero        = 0x00000024 /* 4 bit indexed gray, white is zero */
    case indexedGray8WhiteIsZero        = 0x00000028 /* 8 bit indexed gray, white is zero */
    case gray16                         = "b16g"     /* 16 bit Grayscale, 16-bit big-endian samples, black is zero */
    case alphaGray32                    = "b32a"     /* 32 bit AlphaGray, 16-bit big-endian samples, black is zero */

    // RGB
    case RGB24                          = 0x00000018 /* 24 bit RGB */
    case RGB30                          = "R10k"     /* 30 bit RGB, 10-bit big-endian samples, 2 unused padding bits (at least significant end). */
    case RGB48                          = "b48r"     /* 48 bit RGB, 16-bit big-endian samples */
    // RGB-A
    case RGBA32                         = "RGBA"     /* 32 bit RGBA */
    case RGBAHalf_64                    = "RGhA"     /* 64 bit RGBA IEEE half-precision float, 16-bit little-endian samples */
    case RGBAFloat_128                  = "RGfA"     /* 128 bit RGBA IEEE float, 32-bit little-endian samples */
    case RGBLEPackedWideGamut30         = "w30r"     /* little-endian RGB101010, 2 MSB are zero, wide-gamut (384-895) */
    // A-RGB
    case ARGB32                         = 0x00000020 /* 32 bit ARGB */
    case ARGB64                         = "b64a"     /* 64 bit ARGB, 16-bit big-endian samples */
    case ARGB2101010LEPacked            = "l10r"     /* little-endian ARGB2101010 full-range ARGB */
    // BGR
    case BGR24                          = "24BG"     /* 24 bit BGR */
    case BGRA32                         = "BGRA"     /* 32 bit BGRA */
    // A-GBR
    case ABGR32                         = "ABGR"     /* 32 bit ABGR */

    // LEBE RGB
    case BE555_16                       = 0x00000010 /* 16 bit BE RGB 555 */
    case LE555_16                       = "L555"     /* 16 bit LE RGB 555 */
    case LE5551_16                      = "5551"     /* 16 bit LE RGB 5551 */
    case BE565_16                       = "B565"     /* 16 bit BE RGB 565 */
    case LE565_16                       = "L565"     /* 16 bit LE RGB 565 */
    
    // bayer
    case bayer_RGGB14                   = "rgg4"     /* Bayer 14-bit Little-Endian, packed in 16-bits, ordered R G R G... alternating with G B G B... */
    case bayer_BGGR14                   = "bgg4"     /* Bayer 14-bit Little-Endian, packed in 16-bits, ordered B G B G... alternating with G R G R... */
    case bayer_GBRG14                   = "gbr4"     /* Bayer 14-bit Little-Endian, packed in 16-bits, ordered G B G B... alternating with R G R G... */
    case bayer_GRBG14                   = "grb4"     /* Bayer 14-bit Little-Endian, packed in 16-bits, ordered G R G R... alternating with B G B G... */

    // Y"CbCr
    case YpCbCr8_422                    = "2vuy"     /* Component Y"CbCr 8-bit 4:2:2, ordered Cb Y"0 Cr Y"1 */
    case YpCbCrA8_4444                  = "v408"     /* Component Y"CbCrA 8-bit 4:4:4:4, ordered Cb Y" Cr A */
    case YpCbCrA8R_4444                 = "r408"     /* Component Y"CbCrA 8-bit 4:4:4:4, rendering format. full range alpha, zero biased YUV, ordered A Y" Cb Cr */
    case AYpCbCr8_4444                  = "y408"     /* Component Y"CbCrA 8-bit 4:4:4:4, ordered A Y" Cb Cr, full range alpha, video range Y"CbCr. */
    case AYpCbCr16_4444                 = "y416"     /* Component Y"CbCrA 16-bit 4:4:4:4, ordered A Y" Cb Cr, full range alpha, video range Y"CbCr, 16-bit little-endian samples. */
    case YpCbCr8_444                    = "v308"     /* Component Y"CbCr 8-bit 4:4:4 */
    case YpCbCr16_422                   = "v216"     /* Component Y"CbCr 10,12,14,16-bit 4:2:2 */
    case YpCbCr10_422                   = "v210"     /* Component Y"CbCr 10-bit 4:2:2 */
    case YpCbCr10_444                   = "v410"     /* Component Y"CbCr 10-bit 4:4:4 */
    case YpCbCr8Planar_420              = "y420"     /* Planar Component Y"CbCr 8-bit 4:2:0.  baseAddr points to a big-endian CVPlanarPixelBufferInfo_YCbCrPlanar struct */
    case YpCbCr8PlanarFullRange_420     = "f420"     /* Planar Component Y"CbCr 8-bit 4:2:0, full range.  baseAddr points to a big-endian CVPlanarPixelBufferInfo_YCbCrPlanar struct */
    case YpCbCr_4A_8BiPlanar_422        = "a2vy"     /* First plane: Video-range Component Y"CbCr 8-bit 4:2:2, ordered Cb Y"0 Cr Y"1; second plane: alpha 8-bit 0-255 */
    case YpCbCr8BiPlanarVideoRange_420  = "420v"     /* Bi-Planar Component Y"CbCr 8-bit 4:2:0, video-range (luma=[16,235] chroma=[16,240]).  baseAddr points to a big-endian CVPlanarPixelBufferInfo_YCbCrBiPlanar struct */
    case YpCbCr8BiPlanarFullRange_420   = "420f"     /* Bi-Planar Component Y"CbCr 8-bit 4:2:0, full-range (luma=[0,255] chroma=[1,255]).  baseAddr points to a big-endian CVPlanarPixelBufferInfo_YCbCrBiPlanar struct */
    case YpCbCr8_yuvs_422               = "yuvs"     /* Component Y"CbCr 8-bit 4:2:2, ordered Y"0 Cb Y"1 Cr */
    case YpCbCr8FullRange_422           = "yuvf"     /* Component Y"CbCr 8-bit 4:2:2, full range, ordered Y"0 Cb Y"1 Cr */
    case YpCbCr10BiPlanarVideoRange_420 = "x420"     /* 2 plane YCbCr10 4:2:0, each 10 bits in the MSBs of 16bits, video-range (luma=[64,940] chroma=[64,960]) */
    case YpCbCr10BiPlanarVideoRange_422 = "x422"     /* 2 plane YCbCr10 4:2:2, each 10 bits in the MSBs of 16bits, video-range (luma=[64,940] chroma=[64,960]) */
    case YpCbCr10BiPlanarVideoRange_444 = "x444"     /* 2 plane YCbCr10 4:4:4, each 10 bits in the MSBs of 16bits, video-range (luma=[64,940] chroma=[64,960]) */
    case YpCbCr10BiPlanarFullRange_420  = "xf20"     /* 2 plane YCbCr10 4:2:0, each 10 bits in the MSBs of 16bits, full-range (Y range 0-1023) */
    case YpCbCr10BiPlanarFullRange_422  = "xf22"     /* 2 plane YCbCr10 4:2:2, each 10 bits in the MSBs of 16bits, full-range (Y range 0-1023) */
    case YpCbCr10BiPlanarFullRange_444  = "xf44"     /* 2 plane YCbCr10 4:4:4, each 10 bits in the MSBs of 16bits, full-range (Y range 0-1023) */
}

extension OSType : ExpressibleByStringLiteral {
    public init(stringLiteral: String) {
        self = stringLiteral.unicodeScalars.filter{ $0.isASCII }.map{ $0.value }.reduce(0, { $0 << 8 + $1 })
    }
}
