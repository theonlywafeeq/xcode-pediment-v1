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
    @IBOutlet weak var tableView: UITableView!
    
    var billModel: [BillModel] = []
    private var billModelXMLParser: BillModelXMLParser = BillModelXMLParser()
    private var numOfBills = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billModelXMLParser.parseFeed(url: "https://www.gpo.gov/smap/bulkdata/BILLSTATUS/115hr/sitemap.xml")
        sleep(2)
        
        for index in 0..<numOfBills {
            
            var newBillModel: BillModel = BillModel()
            
            newBillModel.link = billModelXMLParser.loc[index]
            
            billModelXMLParser.parseFeed(url: billModelXMLParser.loc[index])
            sleep(UInt32(1))
            
            newBillModel.title = billModelXMLParser.title
            newBillModel.sponsor = billModelXMLParser.fullName
            newBillModel.text = billModelXMLParser.text
            
            billModel.append(newBillModel)
            
            print("\(numOfBills - index) seconds remaining...")
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.rowHeight = UITableViewAutomaticDimension
            
            print(billModel[index].link!)
            print(billModel[index].title!)
            print(billModel[index].sponsor!)
            print(billModel[index].text!)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfBills
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BillTableViewCell
        
        cell.titleLabel.text = billModel[indexPath.row].title
        cell.sponsorLabel.text = billModel[indexPath.row].sponsor
        
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.lineBreakMode = .byWordWrapping
    
        print("CELL - \(indexPath.row)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CELL - \(indexPath.row)")
        print("CLICKED BILL \(indexPath.row)")
        
        performSegue(withIdentifier: "segue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let CellViewController = segue.destination as! CellViewController
            CellViewController.billTitle = billModel[(tableView.indexPathForSelectedRow?.row)!].title
            CellViewController.billSponsor = billModel[(tableView.indexPathForSelectedRow?.row)!].sponsor
            CellViewController.billFullSummary = billModel[(tableView.indexPathForSelectedRow?.row)!].text
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("CELL - \(indexPath.row)")
        print("unclicked")
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
