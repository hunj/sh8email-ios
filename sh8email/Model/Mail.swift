//
//  Mail.swift
//  ios
//
//  Created by 이강산 on 2016. 9. 25..
//  Copyright © 2016년 이강산. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

/**
	`Mail` model is specified in [app server spec](https://github.com/triplepy/sh8email-app-server#mail-model-specification),
	which is based on [mail model of nodemailer/mailparser](https://nodemailer.com/extras/mailparser/#mail-object).
*/
class Mail: Mappable {
	/**
		headers – a Map object with lowercase header keys
		subject is the subject line (also available from the header mail.headers.get(‘subject’))
		from is an address object for the From: header
		to is an address object for the To: header
		cc is an address object for the Cc: header
		bcc is an address object for the Bcc: header (usually not present)
		date is a Date object for the Date: header
		messageId is the Message-ID value string
		inReplyTo is the In-Reply-To value string
		reply-to is an address object for the Cc: header
		references is an array of referenced Message-ID values
		html is the HTML body of the message. If the message included embedded images as cid: urls then these are all replaced with base64 formatted data: URIs
		text is the plaintext body of the message
		textAsHtml is the plaintext body of the message formatted as HTML
		attachments is an array of attachments
	*/
	var headers: Any?
	var subject: String?
	var from: Address?
	var to: Address?
	var cc: Address?
	var bcc: Address?
	var date: Date?
	var messageId: String?
	var inReplyTo: String?
	var reply-to: Address?
	
	
	var description: String {
		return "\(self.sender) (\(self.recipDate))\n\(self.subject)\n\(self.contents)"
	}
	
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        pk          <- map["pk"]
        recipient   <- map["recipient"]
        sender      <- map["sender"]
        subject     <- map["subject"]
        contents    <- map["contents"]
        recipDate   <- map["recipDate"]
        isSecret    <- map["isSecret"]
        isRead      <- map["isRead"]
    }
	
}
