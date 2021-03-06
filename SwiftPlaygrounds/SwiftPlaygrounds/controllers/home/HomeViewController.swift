//
//  ViewController.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/28.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import UIKit


struct ProjectTasks {
    var number: Int
    var title: String
    var description: String
}

class HomeViewController: UIViewController {
    
    lazy var bristolViewController: BristolViewController = { return BristolViewController(nibName: "BristolViewController", bundle: nil) }()
    lazy var loginViewController: LoginViewController = { return LoginViewController(nibName: "LoginViewController", bundle: nil) }()
    
    
    var tasks = [ProjectTasks]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks.append(contentsOf: [
            ProjectTasks(number: 0, title: "task.01.title".getLocalizable(), description: "task.01.description".getLocalizable()),
            ProjectTasks(number: 1, title: "task.02.title".getLocalizable(), description: "task.02.description".getLocalizable())
        ])
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        // Get Value from plist file
        print("ApiKey is: \(Global.getApiKey())")
        
    }

    func getViewController(index: Int) -> UIViewController {
        switch index {
        case 0:
            return self.bristolViewController
        default:
            return self.loginViewController
        }
    }
    
}







extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: false)
        let vc = getViewController(index: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}







extension HomeViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "HomeTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeTableViewCell  else {
            fatalError("Not likely")
        }
        cell.setUp(title: tasks[indexPath.row].title, description: tasks[indexPath.row].description,deviceWidth: self.getDeviceWidth())
        return cell
    }
    
   
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let marginV = CGFloat(8)
        let marginH = CGFloat(16)
        
        let titleFontSize = CGFloat(17)
        let descriptionFontSize = CGFloat(14)
        
        let titleHeight = tasks[indexPath.row].title.estimateFrame(fontSize: titleFontSize, width: getDeviceWidth() - marginH * 2).height
        let descriptionHeight = tasks[indexPath.row].description.estimateFrame(fontSize: descriptionFontSize, width: getDeviceWidth() - marginH * 2).height
        return titleHeight + descriptionHeight + marginV * 4
    }
    
}

