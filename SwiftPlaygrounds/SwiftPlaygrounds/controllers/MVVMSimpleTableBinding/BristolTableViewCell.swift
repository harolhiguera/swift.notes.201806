//
//  BristolTableViewCell.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/29.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import UIKit

class BristolTableViewCell: UITableViewCell {

    
    @IBOutlet weak var label_index: UILabel!
    @IBOutlet weak var label_item: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    /// This function is to config the cell using View Model
    ///
    /// - Parameter viewModel: The presentable of this view model
    func configure(withViewModel viewModel: BristolItemPresentable) {
        self.label_index.text = viewModel.id
        self.label_item.text = viewModel.textValue
    }
}
