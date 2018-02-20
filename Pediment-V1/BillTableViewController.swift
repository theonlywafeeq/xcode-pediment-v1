//
//  BillTableViewController.swift
//  Pediment-V1
//
//  Created by Wafeeq on 2/12/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import UIKit

class BillTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var tableView: UITableView!
    
    let hr115XMLParser = HR115XMLParser()
    let billXMLParser = BillXMLParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private func fetchData()
    {
        hr115XMLParser.parseFeed(url: "https://www.gpo.gov/smap/bulkdata/BILLSTATUS/115hr/sitemap.xml")
        
        print("it is taking a while")
        
        sleep(15)
        
        print("-------------------")
        
        for i in 0..<hr115XMLParser.billItems.count {
            print("NEW ITEM")
            sleep(1)
            print(hr115XMLParser.billItems[i])
            sleep(1)
        }
        
        print(billXMLParser.billItems.count)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hr115XMLParser.billItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BillTableViewCell
        
        //cell.titleLabel.text = billXMLParser.billItems[indexPath.row].billtitle
        //cell.sponsorLabel.text = billXMLParser.billItems[indexPath.row].billfullName
        
        return cell
    }
}
