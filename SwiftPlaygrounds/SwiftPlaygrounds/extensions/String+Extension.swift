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
    
    // Get HexColour from String (Enter only digits)
    
    var hexColor: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    
}
