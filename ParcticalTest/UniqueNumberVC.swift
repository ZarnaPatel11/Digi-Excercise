//
//  UniqueNumberVC.swift
//  ParcticalTest
//
//  Created by Zarna M. Patel on 04/09/17.
//  Copyright © 2017 Zarna M. Patel. All rights reserved.
//

import UIKit

class UniqueNumberVC: UIViewController, UITableViewDataSource {

    // Mark :- Variable declaration
    let reuseIdentifier = "Cell"
    var uNumber = [String]()
    let defaults = UserDefaults.standard
    var un = [String]()
    
    //let defaults = UserDefaults.standard
    
    
    // Mark :- Outlet
    @IBOutlet weak var tableOutlet: UITableView!
    
    // Mark :- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blur5.jpg")!)
        self.tableOutlet.backgroundColor = UIColor.clear
        un = UserDefaults.standard.array(forKey: "uniqueNum") as! [String]
        print(un)
    }
    
    // Mark :- TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return un.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = ("Count of  is \(String(describing: un[indexPath.row]))")
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 1.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1)
        },completion: { finished in
            UIView.animate(withDuration: 1.2, animations: {
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        })
        cell.backgroundColor = UIColor.clear
        return cell
    }
}
