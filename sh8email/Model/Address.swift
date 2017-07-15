//
//  Address.swift
//  sh8email
//
//  Created by Hun Jae Lee on 4/20/17.
//  Copyright © 2017 hunj. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

/**
[Address objects](https://nodemailer.com/extras/mailparser/#address-object) have the following structure:
- `value` an array with address details
- `name` is the name part of the email/group
- `address` is the email address
- `group` is an array of grouped addresses
- `text` is a formatted address string for plaintext context
- `html` is a formatted address string for HTML context
*/
class Address: Mappable {
	var value: Any?
	var name: Any?
	var address: Address?
	var group: [Address]?
	var text: String?
	var html: String?
	
	var description: String {
		return "\(String(describing: self.name)) <\(String(describing: self.address))>"
	}
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		value	<- map["value"]
		name	<- map["name"]
		address	<- map["address"]
		group	<- map["group"]
		text	<- map["text"]
		html	<- map["html"]
	}
}
