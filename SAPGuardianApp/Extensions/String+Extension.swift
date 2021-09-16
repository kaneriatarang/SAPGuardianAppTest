//
//  StringExtension.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import UIKit

extension String {
    //MARK:- String with HTML to NSAttributedString
    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString? {

        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "color: #\(color.hexString!) !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
                "}</style> \(self)"

            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }

            var attributedText: NSMutableAttributedString!
            attributedText = try NSMutableAttributedString(data: data,
                                                           options: [.documentType: NSAttributedString.DocumentType.html,
                                                                     .characterEncoding: String.Encoding.utf8.rawValue],
                                                           documentAttributes: nil)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            return attributedText
        } catch {
            print("error: ", error)
            return nil
        }
    }
}
