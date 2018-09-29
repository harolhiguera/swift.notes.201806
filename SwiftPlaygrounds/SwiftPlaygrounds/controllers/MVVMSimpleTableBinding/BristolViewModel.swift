//
//  BristolViewModel.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/29.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import Foundation

// Presenter
protocol TodoItemPresentable {
    var textValue: String? { get }
    var id: String? { get }
}

struct TodoItemViewModel: TodoItemPresentable {
    var textValue: String?
    var id: String? = "0"
}

// Actions that come towoards the View Controller
protocol TodoItemViewDelegate {
    func onTodoItemAdded() -> ()
}


struct TodoViewModel: TodoItemViewDelegate {
    
    var newTodoItem: String?
    var items:[TodoItemPresentable] = []
    
    init() {
        let item1 = TodoItemViewModel(textValue: "Washing socks on Sunday", id: "1")
        let item2 = TodoItemViewModel(textValue: "Walking on a Dream", id: "2")
        let item3 = TodoItemViewModel(textValue: "Going abroad", id: "3")
        
        items.append(contentsOf: [item1, item2, item3])
    }
    
    
    
    
    func onTodoItemAdded() {
        
    }
}
