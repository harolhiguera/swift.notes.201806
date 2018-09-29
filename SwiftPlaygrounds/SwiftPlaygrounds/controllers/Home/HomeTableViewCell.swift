//
//  HomeTableViewCell.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/29.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    let marginV = CGFloat(8)
    let marginH = CGFloat(16)

    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var text_description: UITextView!
    
    @IBOutlet weak var constrain_description_h: NSLayoutConstraint!
    @IBOutlet weak var constrain_title_h: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(title: String, description: String, deviceWidth: CGFloat) {
        
        self.label_title.text = title
        self.text_description.text = description
        let titleHeight = title.estimateFrame(fontSize: self.label_title.font.pointSize, width: deviceWidth - marginH * 2).height
        let descriptionHeight = description.estimateFrame(fontSize: self.label_title.font.pointSize, width: deviceWidth - marginH * 2).height
        
        self.constrain_title_h.constant = titleHeight
        self.constrain_description_h.constant = descriptionHeight
        
    }
    
}
