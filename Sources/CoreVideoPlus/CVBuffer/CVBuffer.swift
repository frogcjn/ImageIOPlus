//
//  CVBuffer+.swift
//  get-auxiliary
//
//  Created by Cao, Jiannan on 2018/11/1.
//  Copyright © 2018 Cao, Jiannan. All rights reserved.
//

import CoreFoundation
import CoreVideo

public extension CVBuffer {
    
    // buffer[attachment: key as Attachments.Key] = attachment as Any
    subscript(attachment key: Attachments.Key)  -> (value: Any, attachmentMode: CVAttachmentMode)? {
        get {
            let cfKey = key.rawValue as CFString
            
            var attachmentMode: CVAttachmentMode = .shouldNotPropagate
            let cfValue = CVBufferGetAttachment(self, cfKey, &attachmentMode)
            
            let value = cfValue?.takeUnretainedValue()
            return value.map { ($0, attachmentMode) }
        }
        set {
            let cfKey = key.rawValue as CFString
            
            guard let newValue = newValue else {
                return CVBufferRemoveAttachment(self, cfKey)
            }
            let value = newValue.value
            let attachmentMode = newValue.attachmentMode
            
            let cfValue = value as CFTypeRef
            
            CVBufferSetAttachment(self, cfKey, cfValue, attachmentMode)
        }

    }
    
    /*!
     @function   CVBufferGetAttachment
     @abstract   Returns a specific attachment of a CVBuffer object
     @discussion You can attach any CF object to a CVBuffer object to store additional information. CVBufferGetAttachment retrieves an attachement identified by a key.
     @param      key    Key in form of a CFString identifying the desired attachment.
     @param      attachmentMode.  Returns the mode of the attachment, if desired.  May be NULL.
     @result     If found the attachment object
     */
    func attachment(for key: Attachments.Key) -> (Any, CVAttachmentMode)? {
        return self[attachment: key]
    }

    /*!
     @function   CVBufferRemoveAttachment
     @abstract   Removes a specific attachment of a CVBuffer object
     @discussion CVBufferRemoveAttachment removes an attachement identified by a key. If found the attachement is removed and the retain count decremented.
     @param      key    Key in form of a CFString identifying the desired attachment.
     */
    func removeAttachment(forKey key: Attachments.Key) {
        self[attachment: key] = nil
    }
    
    /*!
     @function   CVBufferRemoveAllAttachments
     @abstract   Removes all attachments of a CVBuffer object
     @discussion While CVBufferRemoveAttachment removes a specific attachement identified by a key CVBufferRemoveAllAttachments removes all attachments of a buffer and decrements their retain counts.
     @param      buffer  Target CVBuffer object.
     */
    func removeAllAttachments() {
        CVBufferRemoveAllAttachments(self)
    }
}

public extension CVBuffer {
    // buffer[attachments: mode as CVAttachmentMode] = attachments as Attachments
    subscript(attachments mode: CVAttachmentMode)  -> Attachments {
        get {
            let cfValue = CVBufferGetAttachments(self, mode)!
            
            let rawValue = cfValue as [NSObject: AnyObject] as! [String: Any]
            let value = Attachments(rawValue: rawValue)!
            return value
        }
        set {
            let cfValue = newValue.rawValue as CFDictionary
            
            CVBufferSetAttachments(self, cfValue, mode)
        }
        
    }

    /*!
     @function   CVBufferGetAttachments
     @abstract   Returns all attachments of a CVBuffer object
     @discussion CVBufferGetAttachments is a convenience call that returns all attachments with their corresponding keys in a CFDictionary.
     @result     A CFDictionary with all buffer attachments identified by there keys. If no attachment is present, the dictionary is empty.  Returns NULL
     for invalid attachment mode.
     */
    func attachments(for mode: CVAttachmentMode) -> Attachments {
        return self[attachments: mode]
    }
    
}

public extension CVBuffer {
    /*!
     @function   CVBufferPropagateAttachments
     @abstract   Copy all propagatable attachments from one buffer to another.
     @discussion CVBufferPropagateAttachments is a convenience call that copies all attachments with a mode of kCVAttachmentMode_ShouldPropagate from one
     buffer to another.
     @param      sourceBuffer  CVBuffer to copy attachments from.
     @param      destinationBuffer  CVBuffer to copy attachments to.
     */
    class func propagateAttachments(_ sourceBuffer: CVBuffer, destinationBuffer: CVBuffer) {
        CVBufferPropagateAttachments(sourceBuffer,destinationBuffer)
    }
    
    /*!
     @function   CVBufferPropagateAttachments
     @abstract   Copy all propagatable attachments from one buffer to another.
     @discussion CVBufferPropagateAttachments is a convenience call that copies all attachments with a mode of kCVAttachmentMode_ShouldPropagate from one
     buffer to another.
     @param      sourceBuffer  CVBuffer to copy attachments from.
     @param      destinationBuffer  CVBuffer to copy attachments to.
     */
    func propagateAttachments(to destination: CVBuffer) {
        CVBufferPropagateAttachments(self, destination)
    }
    
    /*!
     @function   CVBufferPropagateAttachments
     @abstract   Copy all propagatable attachments from one buffer to another.
     @discussion CVBufferPropagateAttachments is a convenience call that copies all attachments with a mode of kCVAttachmentMode_ShouldPropagate from one
     buffer to another.
     @param      sourceBuffer  CVBuffer to copy attachments from.
     @param      destinationBuffer  CVBuffer to copy attachments to.
     */
    func propagateAttachments(from source: CVBuffer) {
        CVBufferPropagateAttachments(source, self)
    }
}

/*
 
 /*!
 @function   CVBufferGetAttachment
 @abstract   Returns a specific attachment of a CVBuffer object
 @discussion You can attach any CF object to a CVBuffer object to store additional information. CVBufferGetAttachment retrieves an attachement identified by a key.
 @param      key    Key in form of a CFString identifying the desired attachment.
 @param      attachmentMode.  Returns the mode of the attachment, if desired.  May be NULL.
 @result     If found the attachment object
 */
 func attachment(for key: Attachments.Key) -> (Any, CVAttachmentMode)? {
 let cfKey = key.rawValue as CFString
 
 var attachmentMode: CVAttachmentMode = .shouldNotPropagate
 let cfValue = CVBufferGetAttachment(self, cfKey, &attachmentMode)
 
 let value = cfValue?.takeUnretainedValue()
 return value.map { ($0, attachmentMode) }
 }
 
 /*!
 @function   CVBufferSetAttachment
 @abstract   Sets or adds a attachment of a CVBuffer object
 @discussion You can attach any CF object to a CVBuffer object to store additional information. CVBufferGetAttachment stores an attachement identified by a key. If the key doesn't exist, the attachment will be added. If the key does exist, the existing attachment will be replaced. In bouth cases the retain count of the attachment will be incremented. The value can be any CFType but nil has no defined behavior.
 @param      key     Key in form of a CFString identifying the desired attachment.
 @param      value    Attachment in form af a CF object.
 @param      attachmentMode    Specifies which attachment mode is desired for this attachment.   A particular attachment key may only exist in
 a single mode at a time.
 */
 func set(attachment key: Attachments.Key, _ value: Any, attachmentMode: CVAttachmentMode) {
 let cfKey = key.rawValue as CFString
 let cfValue = value as CFTypeRef
 
 CVBufferSetAttachment(self, cfKey, cfValue, attachmentMode)
 }
 
 /*!
 @function   CVBufferGetAttachment
 @abstract   Returns a specific attachment of a CVBuffer object
 @discussion You can attach any CF object to a CVBuffer object to store additional information. CVBufferGetAttachment retrieves an attachement identified by a key.
 @param      key    Key in form of a CFString identifying the desired attachment.
 @param      attachmentMode.  Returns the mode of the attachment, if desired.  May be NULL.
 @result     If found the attachment object
 */
 func getAttachment(key: String) -> (Unmanaged<CFTypeRef>?, CVAttachmentMode) {
 var attachmentMode: CVAttachmentMode!
 return (CVBufferGetAttachment(self, key as CFString, &attachmentMode), attachmentMode)
 }
 
 /*!
 @function   CVBufferSetAttachment
 @abstract   Sets or adds a attachment of a CVBuffer object
 @discussion You can attach any CF object to a CVBuffer object to store additional information. CVBufferGetAttachment stores an attachement identified by a key. If the key doesn't exist, the attachment will be added. If the key does exist, the existing attachment will be replaced. In bouth cases the retain count of the attachment will be incremented. The value can be any CFType but nil has no defined behavior.
 @param      key     Key in form of a CFString identifying the desired attachment.
 @param      value    Attachment in form af a CF object.
 @param      attachmentMode    Specifies which attachment mode is desired for this attachment.   A particular attachment key may only exist in
 a single mode at a time.
 */
 func setAttachment(key: String, _ value: AnyObject, attachmentMode: CVAttachmentMode) {
 CVBufferSetAttachment(self, key as CFString, value, attachmentMode)
 
 }
 
 /*!
 @function   CVBufferRemoveAttachment
 @abstract   Removes a specific attachment of a CVBuffer object
 @discussion CVBufferRemoveAttachment removes an attachement identified by a key. If found the attachement is removed and the retain count decremented.
 @param      key    Key in form of a CFString identifying the desired attachment.
 */
 func removeAttachment(key: String) {
 CVBufferRemoveAttachment(self, key as CFString)
 }*/
/*
 /*!
 @function   CVBufferGetAttachments
 @abstract   Returns all attachments of a CVBuffer object
 @discussion CVBufferGetAttachments is a convenience call that returns all attachments with their corresponding keys in a CFDictionary.
 @result     A CFDictionary with all buffer attachments identified by there keys. If no attachment is present, the dictionary is empty.  Returns NULL
 for invalid attachment mode.
 */
 func getAttachments(attachmentMode: CVAttachmentMode) -> [String: Any] {
 return CVBufferGetAttachments(self, attachmentMode) as [NSObject: AnyObject]? as! [String: Any]
 }
 
 /*!
 @function   CVBufferSetAttachments
 @abstract   Sets a set of attachments for a CVBuffer
 @discussion CVBufferSetAttachments is a convenience call that in turn calls CVBufferSetAttachment for each key and value in the given dictionary. All key value pairs must be in the root level of the dictionary.
 @param      buffer  Target CVBuffer object.
 */
 func setAttachments(_ theAttachments: [String: Any], attachmentMode: CVAttachmentMode) {
 CVBufferSetAttachments(self, theAttachments as CFDictionary, attachmentMode)
 }
 

 }
 */
