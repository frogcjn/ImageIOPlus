//
//  UTI.swift
//  ImageIOPlusBase
//
//  Created by Cao, Jiannan on 2018/11/15.
//

import  func   CoreServices.UTTypeCopyPreferredTagWithClass
import   let   CoreServices.kUTTagClassFilenameExtension
import class CoreFoundation.CFString
import   let   CoreServices.kUTTypeJPEG

public struct UTI : RawRepresentable {
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public protocol UTIConvertible : Equatable {
    var uti: UTI { get }
}

/*
public extension UTIConvertible {
    var filenameExtension: String? {
        return UTTypeCopyPreferredTagWithClass(rawValue as CFString, kUTTagClassFilenameExtension)?.takeUnretainedValue() as String?
    }
}

public extension UTIConvertible where Self : RawRepresentable, Self.RawValue == String {
    var uti: UTI {
        return UTI(rawValue: rawValue)
    }
}
*/

extension UTI : UTIConvertible {
    public var uti: UTI {
        return UTI(rawValue: rawValue)
    }
}

import AVKit

extension AVFileType : UTIConvertible {
    public var uti: UTI {
        return UTI(rawValue: rawValue)
    }
}

/*
extension UTI: ExpressibleByStringLiteral {
    public init(unicodeScalarLiteral value: StringLiteralType) {
        rawValue = value
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        rawValue = value
    }
    
    public init(stringLiteral value: StringLiteralType) {
        rawValue = value
    }
}
*/
/*
public enum UTIImageContent : String {
    case jpeg                   = "public.jpeg"
    case jpeg2000               = "public.jpeg-2000"
    case tiff                   = "public.tiff"
    case pict                   = "com.apple.pict"
    case gif                    = "com.compuserve.gif"
    case png                    = "public.png"
    case quickTimeImage         = "com.apple.quicktime-image"
    case appleICNS              = "com.apple.icns"
    case bmp                    = "com.microsoft.bmp"
    case ico                    = "com.microsoft.ico"
    case rawImage               = "public.camera-raw-image"
    case scalableVectorGraphics = "public.svg-image"
    case livePhoto              = "com.apple.live-photo"
}
*/

/*
/*
 *  kUTTypeItem
 *
 *    generic base type for most things
 *    (files, directories)
 *
 *    UTI: public.item
 *
 *
 *  kUTTypeContent
 *
 *    base type for anything containing user-viewable document content
 *    (documents, pasteboard data, and document packages.) Types describing
 *    files or packages must also conform to kUTTypeData or kUTTypePackage
 *    in order for the system to bind documents to them.
 *
 *    UTI: public.content
 *
 *
 *  kUTTypeCompositeContent
 *
 *    base type for content formats supporting mixed embedded content
 *    (i.e., compound documents)
 *
 *    UTI: public.composite-content
 *    conforms to: public.content
 *
 *
 *  kUTTypeMessage
 *
 *    base type for messages (email, IM, etc.)
 *
 *    UTI: public.message
 *
 *
 *  kUTTypeContact
 *
 *    contact information, e.g. for a person, group, organization
 *
 *    UTI: public.contact
 *
 *
 *  kUTTypeArchive
 *
 *    an archive of files and directories
 *
 *    UTI: public.archive
 *
 *
 *  kUTTypeDiskImage
 *
 *    a data item mountable as a volume
 *
 *    UTI: public.disk-image
 *
 */
public let kUTTypeItem: CFString
public let kUTTypeContent: CFString
public let kUTTypeCompositeContent: CFString
public let kUTTypeMessage: CFString
public let kUTTypeContact: CFString
public let kUTTypeArchive: CFString
public let kUTTypeDiskImage: CFString

/*
 *  kUTTypeData
 *
 *    base type for any sort of simple byte stream,
 *    including files and in-memory data
 *
 *    UTI: public.data
 *    conforms to: public.item
 *
 *
 *  kUTTypeDirectory
 *
 *    file system directory
 *    (includes packages AND folders)
 *
 *    UTI: public.directory
 *    conforms to: public.item
 *
 *
 *  kUTTypeResolvable
 *
 *    symlink and alias file types conform to this UTI
 *
 *    UTI: com.apple.resolvable
 *
 *
 *  kUTTypeSymLink
 *
 *    a symbolic link
 *
 *    UTI: public.symlink
 *    conforms to: public.item, com.apple.resolvable
 *
 *
 *  kUTTypeExecutable
 *
 *    an executable item
 *    UTI: public.executable
 *    conforms to: public.item
 *
 *
 *  kUTTypeMountPoint
 *
 *    a volume mount point (resolvable, resolves to the root dir of a volume)
 *
 *    UTI: com.apple.mount-point
 *    conforms to: public.item, com.apple.resolvable
 *
 *
 *  kUTTypeAliasFile
 *
 *    a fully-formed alias file
 *
 *    UTI: com.apple.alias-file
 *    conforms to: public.data, com.apple.resolvable
 *
 *
 *  kUTTypeAliasRecord
 *
 *    raw alias data
 *
 *    UTI: com.apple.alias-record
 *    conforms to: public.data, com.apple.resolvable
 *
 *
 *  kUTTypeURLBookmarkData
 *
 *    URL bookmark
 *
 *    UTI: com.apple.bookmark
 *    conforms to: public.data, com.apple.resolvable
 *
 */
public let kUTTypeData: CFString
public let kUTTypeDirectory: CFString
public let kUTTypeResolvable: CFString
public let kUTTypeSymLink: CFString
public let kUTTypeExecutable: CFString
public let kUTTypeMountPoint: CFString
public let kUTTypeAliasFile: CFString
public let kUTTypeAliasRecord: CFString
public let kUTTypeURLBookmarkData: CFString

/*
 *  kUTTypeURL
 *
 *    The bytes of a URL
 *    (OSType 'url ')
 *
 *    UTI: public.url
 *    conforms to: public.data
 *
 *
 *  kUTTypeFileURL
 *
 *    The text of a "file:" URL
 *    (OSType 'furl')
 *
 *    UTI: public.file-url
 *    conforms to: public.url
 *
 */
public let kUTTypeURL: CFString
public let kUTTypeFileURL: CFString

/*
 *  kUTTypeText
 *
 *    base type for all text-encoded data,
 *    including text with markup (HTML, RTF, etc.)
 *
 *    UTI: public.text
 *    conforms to: public.data, public.content
 *
 *
 *  kUTTypePlainText
 *
 *    text with no markup, unspecified encoding
 *
 *    UTI: public.plain-text
 *    conforms to: public.text
 *
 *
 *  kUTTypeUTF8PlainText
 *
 *    plain text, UTF-8 encoding
 *    (OSType 'utf8', NSPasteboardType "NSStringPBoardType")
 *
 *    UTI: public.utf8-plain-text
 *    conforms to: public.plain-text
 *
 *
 *  kUTTypeUTF16ExternalPlainText
 *
 *    plain text, UTF-16 encoding, with BOM, or if BOM
 *    is not present, has "external representation"
 *    byte order (big-endian).
 *    (OSType 'ut16')
 *
 *    UTI: public.utf16-external-plain-text
 *    conforms to: public.plain-text
 *
 *
 *  kUTTypeUTF16PlainText
 *
 *    plain text, UTF-16 encoding, native byte order, optional BOM
 *    (OSType 'utxt')
 *
 *    UTI: public.utf16-plain-text
 *    conforms to: public.plain-text
 *
 *
 *  kUTTypeDelimitedText
 *
 *    text containing delimited values
 *
 *    UTI: public.delimited-values-text
 *    conforms to: public.text
 *
 *
 *  kUTTypeCommaSeparatedText
 *
 *    text containing comma-separated values (.csv)
 *
 *    UTI: public.comma-separated-values-text
 *    conforms to: public.delimited-values-text
 *
 *
 *  kUTTypeTabSeparatedText
 *
 *    text containing tab-separated values
 *
 *    UTI: public.tab-separated-values-text
 *    conforms to: public.delimited-values-text
 *
 *
 *  kUTTypeUTF8TabSeparatedText
 *
 *    UTF-8 encoded text containing tab-separated values
 *
 *    UTI: public.utf8-tab-separated-values-text
 *    conforms to: public.tab-separated-values-text, public.utf8-plain-text
 *
 *
 *  kUTTypeRTF
 *
 *    Rich Text Format
 *
 *    UTI: public.rtf
 *    conforms to: public.text
 *
 */
public let kUTTypeText: CFString
public let kUTTypePlainText: CFString
public let kUTTypeUTF8PlainText: CFString
public let kUTTypeUTF16ExternalPlainText: CFString
public let kUTTypeUTF16PlainText: CFString
public let kUTTypeDelimitedText: CFString
public let kUTTypeCommaSeparatedText: CFString
public let kUTTypeTabSeparatedText: CFString
public let kUTTypeUTF8TabSeparatedText: CFString
public let kUTTypeRTF: CFString

/*
 *  kUTTypeHTML
 *
 *    HTML, any version
 *
 *    UTI: public.html
 *    conforms to: public.text
 *
 *
 *  kUTTypeXML
 *
 *    generic XML
 *
 *    UTI: public.xml
 *    conforms to: public.text
 *
 */
public let kUTTypeHTML: CFString
public let kUTTypeXML: CFString

/*
 *  kUTTypeSourceCode
 *
 *    abstract type for source code (any language)
 *
 *    UTI: public.source-code
 *    conforms to: public.plain-text
 *
 *
 *  kUTTypeAssemblyLanguageSource
 *
 *    assembly language source (.s)
 *
 *    UTI: public.assembly-source
 *    conforms to: public.source-code
 *
 *
 *  kUTTypeCSource
 *
 *    C source code (.c)
 *
 *    UTI: public.c-source
 *    conforms to: public.source-code
 *
 *
 *  kUTTypeObjectiveCSource
 *
 *    Objective-C source code (.m)
 *
 *    UTI: public.objective-c-source
 *    conforms to: public.source-code
 *
 *
 *  kUTTypeSwiftSource
 *
 *    Swift source code (.swift)
 *
 *    UTI: public.swift-source
 *    conforms to: public.source-code
 *
 *
 *  kUTTypeCPlusPlusSource
 *
 *    C++ source code (.cp, etc.)
 *
 *    UTI: public.c-plus-plus-source
 *    conforms to: public.source-code
 *
 *
 *  kUTTypeObjectiveCPlusPlusSource
 *
 *    Objective-C++ source code
 *
 *    UTI: public.objective-c-plus-plus-source
 *    conforms to: public.source-code
 *
 *
 *  kUTTypeCHeader
 *
 *    C header
 *
 *    UTI: public.c-header
 *    conforms to: public.source-code
 *
 *
 *  kUTTypeCPlusPlusHeader
 *
 *    C++ header
 *
 *    UTI: public.c-plus-plus-header
 *    conforms to: public.source-code
 *
 *
 *  kUTTypeJavaSource
 *
 *    Java source code
 *
 *    UTI: com.sun.java-source
 *    conforms to: public.source-code
 *
 */
public let kUTTypeSourceCode: CFString
public let kUTTypeAssemblyLanguageSource: CFString
public let kUTTypeCSource: CFString
public let kUTTypeObjectiveCSource: CFString
public let kUTTypeSwiftSource: CFString
public let kUTTypeCPlusPlusSource: CFString
public let kUTTypeObjectiveCPlusPlusSource: CFString
public let kUTTypeCHeader: CFString
public let kUTTypeCPlusPlusHeader: CFString
public let kUTTypeJavaSource: CFString

/*
 *  kUTTypeScript
 *
 *    scripting language source
 *
 *    UTI: public.script
 *    conforms to: public.source-code
 *
 *
 *  kUTTypeAppleScript
 *
 *    AppleScript text format (.applescript)
 *
 *    UTI: com.apple.applescript.text
 *    conforms to: public.script
 *
 *
 *  kUTTypeOSAScript
 *
 *    Open Scripting Architecture script binary format (.scpt)
 *
 *    UTI: com.apple.applescript.script
 *    conforms to: public.data, public.script
 *
 *
 *  kUTTypeOSAScriptBundle
 *
 *    Open Scripting Architecture script bundle format (.scptd)
 *
 *    UTI: com.apple.applescript.script-bundle
 *    conforms to: com.apple.bundle, com.apple.package, public.script
 *
 *
 *  kUTTypeJavaScript
 *
 *    JavaScript source code
 *
 *    UTI: com.netscape.javascript-source
 *    conforms to: public.source-code, public.executable
 *
 *
 *  kUTTypeShellScript
 *
 *    base type for shell scripts
 *
 *    UTI: public.shell-script
 *    conforms to: public.script
 *
 *
 *  kUTTypePerlScript
 *
 *    Perl script
 *
 *    UTI: public.perl-script
 *    conforms to: public.shell-script
 *
 *
 *  kUTTypePythonScript
 *
 *    Python script
 *
 *    UTI: public.python-script
 *    conforms to: public.shell-script
 *
 *
 *  kUTTypeRubyScript
 *
 *    Ruby script
 *
 *    UTI: public.ruby-script
 *    conforms to: public.shell-script
 *
 *
 *  kUTTypePHPScript
 *
 *    PHP script
 *
 *    UTI: public.php-script
 *    conforms to: public.shell-script
 *
 */
public let kUTTypeScript: CFString
public let kUTTypeAppleScript: CFString
public let kUTTypeOSAScript: CFString
public let kUTTypeOSAScriptBundle: CFString
public let kUTTypeJavaScript: CFString
public let kUTTypeShellScript: CFString
public let kUTTypePerlScript: CFString
public let kUTTypePythonScript: CFString
public let kUTTypeRubyScript: CFString
public let kUTTypePHPScript: CFString

/*
 *  kUTTypeJSON
 *
 *    JavaScript object notation (JSON) data
 *    NOTE: JSON almost but doesn't quite conform to
 *    com.netscape.javascript-source
 *
 *    UTI: public.json
 *    conforms to: public.text
 *
 *
 *  kUTTypePropertyList
 *
 *    base type for property lists
 *
 *    UTI: com.apple.property-list
 *    conforms to: public.data
 *
 *
 *  kUTTypeXMLPropertyList
 *
 *    XML property list
 *
 *    UTI: com.apple.xml-property-list
 *    conforms to: public.xml, com.apple.property-list
 *
 *
 *  kUTTypeBinaryPropertyList
 *
 *    XML property list
 *
 *    UTI: com.apple.binary-property-list
 *    conforms to: com.apple.property-list
 *
 */
public let kUTTypeJSON: CFString
public let kUTTypePropertyList: CFString
public let kUTTypeXMLPropertyList: CFString
public let kUTTypeBinaryPropertyList: CFString

/*
 *  kUTTypePDF
 *
 *    Adobe PDF
 *
 *    UTI: com.adobe.pdf
 *    conforms to: public.data, public.composite-content
 *
 *
 *  kUTTypeRTFD
 *
 *    Rich Text Format Directory
 *    (RTF with content embedding, on-disk format)
 *
 *    UTI: com.apple.rtfd
 *    conforms to: com.apple.package, public.composite-content
 *
 *
 *  kUTTypeFlatRTFD
 *
 *    Flattened RTFD (pasteboard format)
 *
 *    UTI: com.apple.flat-rtfd
 *    conforms to: public.data, public.composite-content
 *
 *
 *  kUTTypeTXNTextAndMultimediaData
 *
 *    MLTE (Textension) format for mixed text & multimedia data
 *    (OSType 'txtn')
 *
 *    UTI: com.apple.txn.text-multimedia-data
 *    conforms to: public.data, public.composite-content
 *
 *
 *  kUTTypeWebArchive
 *
 *    The WebKit webarchive format
 *
 *    UTI: com.apple.webarchive
 *    conforms to: public.data, public.composite-content
 */
public let kUTTypePDF: CFString
public let kUTTypeRTFD: CFString
public let kUTTypeFlatRTFD: CFString
public let kUTTypeTXNTextAndMultimediaData: CFString
public let kUTTypeWebArchive: CFString

/*
 *  kUTTypeImage
 *
 *    abstract image data
 *
 *    UTI: public.image
 *    conforms to: public.data, public.content
 *
 *
 *  kUTTypeJPEG
 *
 *    JPEG image
 *
 *    UTI: public.jpeg
 *    conforms to: public.image
 *
 *
 *  kUTTypeJPEG2000
 *
 *    JPEG-2000 image
 *
 *    UTI: public.jpeg-2000
 *    conforms to: public.image
 *
 *
 *  kUTTypeTIFF
 *
 *    TIFF image
 *
 *    UTI: public.tiff
 *    conforms to: public.image
 *
 *
 *  kUTTypePICT
 *
 *    Quickdraw PICT format
 *
 *    UTI: com.apple.pict
 *    conforms to: public.image
 *
 *
 *  kUTTypeGIF
 *
 *    GIF image
 *
 *    UTI: com.compuserve.gif
 *    conforms to: public.image
 *
 *
 *  kUTTypePNG
 *
 *    PNG image
 *
 *    UTI: public.png
 *    conforms to: public.image
 *
 *
 *  kUTTypeQuickTimeImage
 *
 *    QuickTime image format (OSType 'qtif')
 *
 *    UTI: com.apple.quicktime-image
 *    conforms to: public.image
 *
 *
 *  kUTTypeAppleICNS
 *
 *    Apple icon data
 *
 *    UTI: com.apple.icns
 *    conforms to: public.image
 *
 *
 *  kUTTypeBMP
 *
 *    Windows bitmap
 *
 *    UTI: com.microsoft.bmp
 *    conforms to: public.image
 *
 *
 *  kUTTypeICO
 *
 *    Windows icon data
 *
 *    UTI: com.microsoft.ico
 *    conforms to: public.image
 *
 *
 *  kUTTypeRawImage
 *
 *    base type for raw image data (.raw)
 *
 *    UTI: public.camera-raw-image
 *    conforms to: public.image
 *
 *
 *  kUTTypeScalableVectorGraphics
 *
 *    SVG image
 *
 *    UTI: public.svg-image
 *    conforms to: public.image
 *
 *  kUTTypeLivePhoto
 *
 *    Live Photo
 *
 *    UTI: com.apple.live-photo
 *
 *
 */
public let kUTTypeImage: CFString
public let kUTTypeJPEG: CFString
public let kUTTypeJPEG2000: CFString
public let kUTTypeTIFF: CFString
public let kUTTypePICT: CFString
public let kUTTypeGIF: CFString
public let kUTTypePNG: CFString
public let kUTTypeQuickTimeImage: CFString
public let kUTTypeAppleICNS: CFString
public let kUTTypeBMP: CFString
public let kUTTypeICO: CFString
public let kUTTypeRawImage: CFString
public let kUTTypeScalableVectorGraphics: CFString.12, *)
public let kUTTypeLivePhoto: CFString

/*
 *  kUTTypeAudiovisualContent
 *
 *    audio and/or video content
 *
 *    UTI: public.audiovisual-content
 *    conforms to: public.data, public.content
 *
 *
 *  kUTTypeMovie
 *
 *    A media format which may contain both video and audio
 *    Corresponds to what users would label a "movie"
 *
 *    UTI: public.movie
 *    conforms to: public.audiovisual-content
 *
 *
 *  kUTTypeVideo
 *
 *    pure video (no audio)
 *
 *    UTI: public.video
 *    conforms to: public.movie
 *
 *
 *  kUTTypeAudio
 *
 *    pure audio (no video)
 *
 *    UTI: public.audio
 *    conforms to: public.audiovisual-content
 *
 *
 *  kUTTypeQuickTimeMovie
 *
 *    QuickTime movie
 *
 *    UTI: com.apple.quicktime-movie
 *    conforms to: public.movie
 *
 *
 *  kUTTypeMPEG
 *
 *    MPEG-1 or MPEG-2 movie
 *
 *    UTI: public.mpeg
 *    conforms to: public.movie
 *
 *
 *  kUTTypeMPEG2Video
 *
 *    MPEG-2 video
 *
 *    UTI: public.mpeg-2-video
 *    conforms to: public.video
 *
 *
 *  kUTTypeMPEG2TransportStream
 *
 *    MPEG-2 Transport Stream movie format
 *
 *    UTI: public.mpeg-2-transport-stream
 *    conforms to: public.movie
 *
 *
 *  kUTTypeMP3
 *
 *    MP3 audio
 *
 *    UTI: public.mp3
 *    conforms to: public.audio
 *
 *
 *  kUTTypeMPEG4
 *
 *    MPEG-4 movie
 *
 *    UTI: public.mpeg-4
 *    conforms to: public.movie
 *
 *
 *  kUTTypeMPEG4Audio
 *
 *    MPEG-4 audio layer
 *
 *    UTI: public.mpeg-4-audio
 *    conforms to: public.mpeg-4, public.audio
 *
 *
 *  kUTTypeAppleProtectedMPEG4Audio
 *
 *    Apple protected MPEG4 format
 *    (.m4p, iTunes music store format)
 *
 *    UTI: com.apple.protected-mpeg-4-audio
 *    conforms to: public.audio
 *
 *
 *  kUTTypeAppleProtectedMPEG4Video
 *
 *    Apple protected MPEG-4 movie
 *
 *    UTI: com.apple.protected-mpeg-4-video
 *    conforms to: com.apple.m4v-video
 *
 *
 *  kUTTypeAVIMovie
 *
 *    Audio Video Interleaved (AVI) movie format
 *
 *    UTI: public.avi
 *    conforms to: public.movie
 *
 *
 *  kUTTypeAudioInterchangeFileFormat
 *
 *    AIFF audio format
 *
 *    UTI: public.aiff-audio
 *    conforms to: public.aifc-audio
 *
 *
 *  kUTTypeWaveformAudio
 *
 *    Waveform audio format (.wav)
 *
 *    UTI: com.microsoft.waveform-audio
 *    conforms to: public.audio
 *
 *
 *  kUTTypeMIDIAudio
 *
 *    MIDI audio format
 *
 *    UTI: public.midi-audio
 *    conforms to: public.audio
 *
 *
 */
public let kUTTypeAudiovisualContent: CFString
public let kUTTypeMovie: CFString
public let kUTTypeVideo: CFString
public let kUTTypeAudio: CFString
public let kUTTypeQuickTimeMovie: CFString
public let kUTTypeMPEG: CFString
public let kUTTypeMPEG2Video: CFString
public let kUTTypeMPEG2TransportStream: CFString
public let kUTTypeMP3: CFString
public let kUTTypeMPEG4: CFString
public let kUTTypeMPEG4Audio: CFString
public let kUTTypeAppleProtectedMPEG4Audio: CFString
public let kUTTypeAppleProtectedMPEG4Video: CFString
public let kUTTypeAVIMovie: CFString
public let kUTTypeAudioInterchangeFileFormat: CFString
public let kUTTypeWaveformAudio: CFString
public let kUTTypeMIDIAudio: CFString

/*
 *  kUTTypePlaylist
 *
 *    base type for playlists
 *
 *    UTI: public.playlist
 *
 *
 *  kUTTypeM3UPlaylist
 *
 *    M3U or M3U8 playlist
 *
 *    UTI: public.m3u-playlist
 *    conforms to: public.text, public.playlist
 *
 */
public let kUTTypePlaylist: CFString
public let kUTTypeM3UPlaylist: CFString

/*
 *  kUTTypeFolder
 *
 *    a user-browsable directory (i.e., not a package)
 *
 *    UTI: public.folder
 *    conforms to: public.directory
 *
 *
 *  kUTTypeVolume
 *
 *    the root folder of a volume/mount point
 *
 *    UTI: public.volume
 *    conforms to: public.folder
 *
 *
 *  kUTTypePackage
 *
 *    a packaged directory
 *
 *    UTI: com.apple.package
 *    conforms to: public.directory
 *
 *
 *  kUTTypeBundle
 *
 *    a directory conforming to one of the CFBundle layouts
 *
 *    UTI: com.apple.bundle
 *    conforms to: public.directory
 *
 *
 *  kUTTypePluginBundle
 *
 *    base type for bundle-based plugins
 *
 *    UTI: com.apple.plugin
 *    conforms to: com.apple.bundle, com.apple.package
 *
 *
 *  kUTTypeSpotlightImporter
 *
 *    a Spotlight metadata importer
 *
 *    UTI: com.apple.metadata-importer
 *    conforms to: com.apple.plugin
 *
 *
 *  kUTTypeQuickLookGenerator
 *
 *    a QuickLook preview generator
 *
 *    UTI: com.apple.quicklook-generator
 *    conforms to: com.apple.plugin
 *
 *
 *  kUTTypeXPCService
 *
 *    an XPC service
 *
 *    UTI: com.apple.xpc-service
 *    conforms to: com.apple.bundle, com.apple.package
 *
 *
 *  kUTTypeFramework
 *
 *    a Mac OS X framework
 *
 *    UTI: com.apple.framework
 *    conforms to: com.apple.bundle
 *
 */
public let kUTTypeFolder: CFString
public let kUTTypeVolume: CFString
public let kUTTypePackage: CFString
public let kUTTypeBundle: CFString
public let kUTTypePluginBundle: CFString
public let kUTTypeSpotlightImporter: CFString
public let kUTTypeQuickLookGenerator: CFString
public let kUTTypeXPCService: CFString
public let kUTTypeFramework: CFString

/*
 *  kUTTypeApplication
 *
 *    base type for OS X applications, launchable items
 *
 *    UTI: com.apple.application
 *    conforms to: public.executable
 *
 *
 *  kUTTypeApplicationBundle
 *
 *    a bundled application
 *
 *    UTI: com.apple.application-bundle
 *    conforms to: com.apple.application, com.apple.bundle, com.apple.package
 *
 *
 *  kUTTypeApplicationFile
 *
 *    a single-file Carbon/Classic application
 *
 *    UTI: com.apple.application-file
 *    conforms to: com.apple.application, public.data
 *
 *
 *  kUTTypeUnixExecutable
 *
 *    a UNIX executable (flat file)
 *
 *    UTI: public.unix-executable
 *    conforms to: public.data, public.executable
 *
 *
 *  kUTTypeWindowsExecutable
 *
 *    a Windows executable (.exe files)
 *
 *    UTI: com.microsoft.windows-executable
 *    conforms to: public.data, public.executable
 *
 *
 *  kUTTypeJavaClass
 *
 *    a Java class
 *
 *    UTI: com.sun.java-class
 *    conforms to: public.data, public.executable
 *
 *
 *  kUTTypeJavaArchive
 *
 *    a Java archive (.jar)
 *
 *    UTI: com.sun.java-archive
 *    conforms to: public.zip-archive, public.executable
 *
 *
 *  kUTTypeSystemPreferencesPane
 *
 *    a System Preferences pane
 *
 *    UTI: com.apple.systempreference.prefpane
 *    conforms to: com.apple.package, com.apple.bundle
 *
 */
// Abstract executable types
public let kUTTypeApplication: CFString
public let kUTTypeApplicationBundle: CFString
public let kUTTypeApplicationFile: CFString
public let kUTTypeUnixExecutable: CFString

// Other platform binaries
public let kUTTypeWindowsExecutable: CFString
public let kUTTypeJavaClass: CFString
public let kUTTypeJavaArchive: CFString

// Misc. binaries
public let kUTTypeSystemPreferencesPane: CFString

/*
 *  kUTTypeGNUZipArchive
 *
 *    a GNU zip archive (gzip)
 *
 *    UTI: org.gnu.gnu-zip-archive
 *    conforms to: public.data, public.archive
 *
 *
 *  kUTTypeBzip2Archive
 *
 *    a bzip2 archive (.bz2)
 *
 *    UTI: public.bzip2-archive
 *    conforms to: public.data, public.archive
 *
 *
 *  kUTTypeZipArchive
 *
 *    a zip archive
 *
 *    UTI: public.zip-archive
 *    conforms to: com.pkware.zip-archive
 *
 */
public let kUTTypeGNUZipArchive: CFString
public let kUTTypeBzip2Archive: CFString
public let kUTTypeZipArchive: CFString

/*
 *  kUTTypeSpreadsheet
 *
 *    base spreadsheet document type
 *
 *    UTI: public.spreadsheet
 *    conforms to: public.content
 *
 *
 *  kUTTypePresentation
 *
 *    base presentation document type
 *
 *    UTI: public.presentation
 *    conforms to: public.composite-content
 *
 *
 *  kUTTypeDatabase
 *
 *    a database store
 *
 *    UTI: public.database
 *
 */
public let kUTTypeSpreadsheet: CFString
public let kUTTypePresentation: CFString
public let kUTTypeDatabase: CFString

/*
 *  kUTTypeVCard
 *
 *    VCard format
 *
 *    UTI: public.vcard
 *    conforms to: public.text, public.contact
 *
 *
 *  kUTTypeToDoItem
 *
 *    to-do item
 *
 *    UTI: public.to-do-item
 *
 *
 *  kUTTypeCalendarEvent
 *
 *    calendar event
 *
 *    UTI: public.calendar-event
 *
 *
 *  kUTTypeEmailMessage
 *
 *    e-mail message
 *
 *    UTI: public.email-message
 *    conforms to: public.message
 *
 */
public let kUTTypeVCard: CFString
public let kUTTypeToDoItem: CFString
public let kUTTypeCalendarEvent: CFString
public let kUTTypeEmailMessage: CFString

/*
 *  kUTTypeInternetLocation
 *
 *    base type for Apple Internet locations
 *
 *    UTI: com.apple.internet-location
 *    conforms to: public.data
 *
 */

public let kUTTypeInternetLocation: CFString

/*
 *  kUTTypeInkText
 *
 *    Opaque InkText data
 *
 *    UTI: com.apple.ink.inktext
 *    conforms to: public.data
 *
 *
 *  kUTTypeFont
 *
 *    base type for fonts
 *
 *    UTI: public.font
 *
 *
 *  kUTTypeBookmark
 *
 *    bookmark
 *
 *    UTI: public.bookmark
 *
 *
 *  kUTType3DContent
 *
 *    base type for 3D content
 *
 *    UTI: public.3d-content
 *    conforms to: public.content
 *
 *
 *  kUTTypePKCS12
 *
 *    PKCS#12 format
 *
 *    UTI: com.rsa.pkcs-12
 *    conforms to: public.data
 *
 *
 *  kUTTypeX509Certificate
 *
 *    X.509 certificate format
 *
 *    UTI: public.x509-certificate
 *    conforms to: public.data
 *
 *
 *  kUTTypeElectronicPublication
 *
 *    ePub format
 *
 *    UTI: org.idpf.epub-container
 *    conforms to: public.data, public.composite-content
 *
 *
 *  kUTTypeLog
 *
 *    console log
 *
 *    UTI: public.log
 *
 */
public let kUTTypeInkText: CFString
public let kUTTypeFont: CFString
public let kUTTypeBookmark: CFString
public let kUTType3DContent: CFString
public let kUTTypePKCS12: CFString
public let kUTTypeX509Certificate: CFString
public let kUTTypeElectronicPublication: CFString
public let kUTTypeLog: CFString

*/
