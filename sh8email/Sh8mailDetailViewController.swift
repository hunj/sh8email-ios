//
//  ShowSh8EmailViewController.swift
//  sh8email
//
//  Created by Hun Jae Lee on 2/27/17.
//  Copyright © 2017 이강산. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class Sh8mailDetailViewController: UIViewController {
	// email data
	var email: Mail?
	
	// MARK: UIOutlets
	@IBOutlet var subjectLabel: UILabel!
	@IBOutlet var senderLabel: UILabel!
	@IBOutlet var recipDateLabel: UILabel!
	@IBOutlet var contentView: UIWebView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		request(email!)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func request(_ email: Mail) {
		if (email.isSecret!) {
			// show UIAlert for password
			var inputTextField: UITextField?
			let passwordPrompt = UIAlertController(title: "Encrypted Email", message: "Please enter the password to the email", preferredStyle: UIAlertControllerStyle.alert)
			passwordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { (action) -> Void in
				// go up one segue
				
			}))
			passwordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
				// call json using password
				let password = inputTextField?.text!
				self.requestDataAndSetFields(for: email, using: password!)
			}))
			passwordPrompt.addTextField(configurationHandler: {(textField: UITextField!) in
				textField.placeholder = "Password"
				textField.isSecureTextEntry = true
				inputTextField = textField
			})
			present(passwordPrompt, animated: true, completion:  { (action) -> Void in
				print("present")
			})
		} else {
			self.requestDataAndSetFields(for: email)
		}
		
	}
	
	func requestDataAndSetFields(for email: Mail) {
		let emailRequestURL = "https://sh8.email/rest/mail/\(email.recipient!)/\(email.pk!)/"
		Alamofire.request(emailRequestURL).responseObject { (response: DataResponse<Mail>) in
			guard let email = response.result.value else {
				print("< ERR! > Did not receive data!")
				return
			}
			print("<SYSTEM> Received data!")
			print(email.description)
			DispatchQueue.main.async {
				self.setFields(using: email)
				self.contentView.resizeWebContent()
			}
		}
	}
	
	func requestDataAndSetFields(for email: Mail, using secretCode: String) {
		let emailRequestURL = "https://sh8.email/rest/mail/\(email.recipient!)/\(email.pk!)/"
		let parameters = ["secret_code" : secretCode]
		Alamofire.request(emailRequestURL, method: .post, parameters: parameters).responseObject { (response: DataResponse<Mail>) in
			guard let email = response.result.value else {
				print("< ERR! > Did not receive data!")
				return
			}
			print("<SYSTEM> Received data!")
			print(email.description)
			DispatchQueue.main.async {
				self.setFields(using: email)
				self.contentView.resizeWebContent()
				
			}
		}
	}

	
	/**
		refreshes the UI elements using given `Mail`.
		- Parameter mail: the `Mail` object to set up the UI fields
	*/
	func setFields(using mail: Mail) {
		subjectLabel.text = mail.subject
		senderLabel.text = mail.sender
		recipDateLabel.text = mail.recipDate
		contentView.loadHTMLString(mail.contents!, baseURL: nil)
	}
	
	func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		if navigationType == UIWebViewNavigationType.linkClicked {
			UIApplication.shared.openURL(request.url!)
			return false
		}
		
		return true
	}

}

/*
	Contains
	http://stackoverflow.com/questions/10666484/html-content-fit-in-uiwebview-without-zooming-out
*/

extension UIWebView {
	///Method to fit content of webview inside webview according to different screen size
	func resizeWebContent() {
		let contentSize = self.scrollView.contentSize
		let viewSize = self.bounds.size
		let zoomScale = viewSize.width/contentSize.width
		self.scrollView.minimumZoomScale = zoomScale
		self.scrollView.maximumZoomScale = zoomScale
		self.scrollView.zoomScale = zoomScale
	}
}
