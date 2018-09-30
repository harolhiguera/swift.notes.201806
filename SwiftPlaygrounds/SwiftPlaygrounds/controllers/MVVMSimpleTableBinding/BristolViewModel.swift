//
//  BristolViewModel.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/29.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import Foundation

// Data Items
protocol BristolItemPresentable {
    var textValue: String? { get }
    var id: String? { get }
}

struct BristolItemViewModel: BristolItemPresentable {
    var textValue: String?
    var id: String? = "0"
}

protocol BristolItemViewModelDelegate {
    func onBristolItemSelected()
}

extension BristolItemViewModel: BristolItemViewModelDelegate {
    func onBristolItemSelected() {
        print("Item with id: \(id!) has been selected!!")
    }
}













protocol BristolViewDelegate {
    func onAddItem()
}
protocol BristolViewModelProtocol: class {
    func reloadTableView()
}


class BristolViewModel {
    weak var delegate: BristolViewModelProtocol?
    var newBristolItem: String?
    var items:[BristolItemPresentable] = []
    
    init(delegate: BristolViewModelProtocol) {
        self.delegate = delegate
        let item1 = BristolItemViewModel(textValue: "Washing socks on Sunday", id: "1")
        let item2 = BristolItemViewModel(textValue: "Walking on a Dream", id: "2")
        let item3 = BristolItemViewModel(textValue: "Going abroad", id: "3")
        
        items.append(contentsOf: [item1, item2, item3])
    }
}



extension BristolViewModel: BristolViewDelegate {
    func onAddItem() {
        guard let newValue = newBristolItem else{ return }
        print("New Bristol Value received in View Model: \(newValue)")
        let newItem = BristolItemViewModel(textValue: newValue, id: "\(items.count + 1)")
        self.items.append(newItem)
        self.newBristolItem = ""
        self.delegate?.reloadTableView()
    }
}
