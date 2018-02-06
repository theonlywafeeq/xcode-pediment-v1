//
//  ViewController.swift
//  Pediment-V1
//
//  Created by Wafeeq on 1/31/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, XMLParserDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell.textLabel?.text = "Title"
        cell.detailTextLabel?.text = "Subtitle"
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

