//
//  String+Extension.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/28.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // Get Value from plist file
    func getValueFromPlist() -> String {
        if
            let file = Bundle.main.path(forResource: "credentials", ofType: "plist"),
            let dictionary = NSDictionary.init(contentsOfFile: file){
            return dictionary.value(forKey: self) as! String
        }
        else {
            return "Not Found"
        }
    }
    
    //  Get Localizable string
    func getLocalizable() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    
    // Estimated Size
    func estimateFrame(fontSize: CGFloat, width: CGFloat) -> CGRect {
        let size = CGSize(width: width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: self).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil)
    }
    
    
    // Estimated Size
    func estimateFrame(font: UIFont, width: CGFloat, lineSpacing: CGFloat, letterSpacing: CGFloat) -> CGRect {
        
        let size = CGSize(width: width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attrs = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            .kern: letterSpacing
            ] as [NSAttributedString.Key : Any]
        
        return NSString(string: self).boundingRect(with: size, options: options, attributes: attrs, context: nil)
        
    }
}
