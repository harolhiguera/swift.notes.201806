//
//  BristolItemModel.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/30.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import Foundation


protocol BristolItemPresentable: class {
    var textValue: String? { get }
    var id: String? { get }
    var menuItems: [BristolMenuItemViewPresentable]? { get }
}


class BristolItemViewModel: BristolItemPresentable {
    var menuItems: [BristolMenuItemViewPresentable]? = []
    var textValue: String?
    var id: String? = "0"
    weak var parent: BristolViewDelegate?
    
    init(textValue: String, id: String, parentViewModel: BristolViewDelegate) {
        
        self.textValue = textValue
        self.id = id
        self.parent = parentViewModel
        
        let removeMenuItem = RemoveMenuItemViewModel(parentViewModel: self)
        removeMenuItem.backColour = "ff0000"
        removeMenuItem.title = "Remove"
        let doneMenuItem = DoneMenuItemViewModel(parentViewModel: self)
        doneMenuItem.backColour = "008000"
        doneMenuItem.title = "Done"
        menuItems?.append(contentsOf: [removeMenuItem, doneMenuItem])
    }
}


// ****** ****** Protocol that allows other entities to communicate whith this view directly

protocol BristolItemViewModelDelegate: class {
    func onBristolItemSelected()
    func onBristolItemRemoved()
    func onBristolItemDone()
}

extension BristolItemViewModel: BristolItemViewModelDelegate {
    func onBristolItemSelected() {
        print("Item with id: \(id!) has been selected!!")
    }
    func onBristolItemRemoved() {
        
    }
    
    func onBristolItemDone() {
        
    }
}


// ****** ****** Model for the menu Items

protocol BristolMenuItemViewPresentable {
    var title: String? { get }
    var backColour: String? { get }
}

protocol BristolMenuItemViewDelegate {
    func onMenuItemSelected()
}


class BristolMenuItemViewModel: BristolMenuItemViewPresentable, BristolMenuItemViewDelegate {
    
    var title: String?
    var backColour: String?
    weak var parent: BristolItemViewModelDelegate?
    
    init(parentViewModel: BristolItemViewModelDelegate) {
        parent = parentViewModel
    }
    
    func onMenuItemSelected() {
        // Base class that not requires implementation
    }
}


class RemoveMenuItemViewModel: BristolMenuItemViewModel {
    override func onMenuItemSelected() {
        print("Remove Item Selected!!")
        parent?.onBristolItemRemoved()
    }
}


class DoneMenuItemViewModel: BristolMenuItemViewModel {
    override func onMenuItemSelected() {
        print("Done Item Selected!!")
        parent?.onBristolItemDone()
    }
}
