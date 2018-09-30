//
//  BristolViewController.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/29.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import UIKit


//    ╦  ╦┬┌─┐┬ ┬  ╔╦╗┌─┐┬  ┌─┐┌─┐┌─┐┌┬┐┌─┐
//    ╚╗╔╝│├┤ │││   ║║├┤ │  ├┤ │ ┬├─┤ │ ├┤
//     ╚╝ ┴└─┘└┴┘  ═╩╝└─┘┴─┘└─┘└─┘┴ ┴ ┴ └─┘



protocol BristolViewDelegate: class {
    func onAddItem() // An Item has been added to this view, let's tell the ViewModel
    func onDeleteItem(id: String) // An Item has been deleted to this view, let's tell the ViewModel
    func onDoneItem(id: String)
}




//    ╦  ╦┬┌─┐┬ ┬
//    ╚╗╔╝│├┤ │││
//     ╚╝ ┴└─┘└┴┘


class BristolViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    private var viewModel: BristolViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BristolViewModel(delegate: self)
        tableView.register(UINib(nibName: "BristolTableViewCell", bundle: nil), forCellReuseIdentifier: "BristolTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func onAddItem(_ sender: UIButton) {
        guard let text = textField.text, !text.isEmpty else {
            print("No value entered")
            return
        }
        viewModel?.newBristolItem = text
        // ******** BACKGROUND THREAD *******
        DispatchQueue.global(qos: .background).async {
            self.viewModel?.onAddItem()
        }
    }
}


//    ╔═╗┌─┐┬─┐┌─┐┬┌─┐┌┐┌  ╔╦╗┌─┐┬  ┌─┐┌─┐┌─┐┌┬┐┌─┐┌─┐
//    ╠╣ │ │├┬┘├┤ ││ ┬│││   ║║├┤ │  ├┤ │ ┬├─┤ │ ├┤ └─┐
//    ╚  └─┘┴└─└─┘┴└─┘┘└┘  ═╩╝└─┘┴─┘└─┘└─┘┴ ┴ ┴ └─┘└─┘


extension BristolViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemSelected = viewModel?.items[indexPath.row]
        (itemSelected as? BristolItemViewModelDelegate)?.onBristolItemSelected()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let item = viewModel?.items[indexPath.row]
        var menuActionsList: [UIContextualAction] = []
        
        _ = item?.menuItems?.map({ menuItem in
            let menuAction = UIContextualAction(style: .normal, title: menuItem.title!) { (contextAction, view, success: (Bool) -> (Void)) in
                
                if let delegate = menuItem as? BristolMenuItemViewDelegate {
                    // ******** BACKGROUND THREAD *******
                    DispatchQueue.global(qos: .background).async {
                        delegate.onMenuItemSelected()
                    }
                }
                success(true)
            }
            menuAction.backgroundColor = menuItem.backColour?.hexColor
            menuActionsList.append(menuAction)
        })
        
        return UISwipeActionsConfiguration(actions: menuActionsList)
    }
}


extension BristolViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BristolTableViewCell", for: indexPath) as? BristolTableViewCell
        cell?.configure(withViewModel: (viewModel?.items[indexPath.row])!)
        return cell!
    }
}




extension BristolViewController: BristolViewModelProtocol {
    
    func newItemAddedToViewModel() {
        guard let items = viewModel?.items else { return }
        
        // ******** MAIN THREAD *******
        DispatchQueue.main.sync(execute: { () -> Void in
            self.textField.text = self.viewModel?.newBristolItem
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: items.count - 1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        })
    }
    
    func itemRemoveFromViewModel(at index: Int   ) {
        // ******** MAIN THREAD *******
        DispatchQueue.main.sync(execute: { () -> Void in
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            tableView.endUpdates()
        })
        
    }
}
