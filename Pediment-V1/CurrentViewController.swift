//
//  BillTableViewController.swift
//  Pediment-V1
//
//  Created by Wafeeq on 2/12/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import UIKit

class CurrentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    private var billModel: BillModel = BillModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billModel.HR115parsed.parseBill()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BillTableViewCell
        
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.contentMode = .scaleToFill
        cell.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.sponsorLabel.numberOfLines = 1
        
        cell.titleLabel.text = billModel.HR115parsed.title
        cell.sponsorLabel.text = billModel.HR115parsed.sponsor

        return cell
    }

    @available(iOS 11.0,*)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let aye = UIContextualAction(style: .normal, title: "Vote Aye") { (action, view, nil) in
            print("Vote Aye")
        }
        
        aye.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [aye])
    }

    @available(iOS 11.0,*)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let nay = UIContextualAction(style: .normal, title: "Vote Nay") { (action, view, nil) in
            print("Delete")
        }
        
        nay.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [nay])
    }
}
