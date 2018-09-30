//
//  BristolItemModel.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/30.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import Foundation


protocol BristolItemPresentable {
    var textValue: String? { get }
    var id: String? { get }
}

struct BristolItemViewModel: BristolItemPresentable {
    var textValue: String?
    var id: String? = "0"
}


// Protocol that allows other entities to communicate whith this view directly

protocol BristolItemViewModelDelegate {
    func onBristolItemSelected()
}

extension BristolItemViewModel: BristolItemViewModelDelegate {
    func onBristolItemSelected() {
        print("Item with id: \(id!) has been selected!!")
    }
}
