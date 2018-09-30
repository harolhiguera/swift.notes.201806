//
//  BristolViewController.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/29.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import UIKit

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
        viewModel?.onAddItem()
    }
}




extension BristolViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemSelected = viewModel?.items[indexPath.row]
        (itemSelected as? BristolItemViewModelDelegate)?.onBristolItemSelected()
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
    func reloadTableView() {
        guard let items = viewModel?.items else { return }
        textField.text = viewModel?.newBristolItem
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: items.count - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
}
