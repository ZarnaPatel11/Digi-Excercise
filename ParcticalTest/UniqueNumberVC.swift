//
//  UniqueNumberVC.swift
//  ParcticalTest
//
//  Created by Zarna M. Patel on 04/09/17.
//  Copyright © 2017 Zarna M. Patel. All rights reserved.
//

import UIKit

class UniqueNumberVC: UIViewController, UITableViewDataSource {

    let reuseIdentifier = "Cell"
    var uNumber = [String]()
    
    @IBOutlet weak var tableOutlet: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blur5.jpg")!)
        self.tableOutlet.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uNumber.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = ("Count of  is \(uNumber[indexPath.row])") as? String
        return cell
    }
}
