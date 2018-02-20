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
    
    let feedParser = FeedParser()
    let rssBillParser = RSSBillParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private func fetchData()
    {
        rssBillParser.parseFeed(url: "https://www.gpo.gov/smap/bulkdata/BILLSTATUS/115hr/sitemap.xml")
        
        for i in 0..<rssBillParser.billCount {
            feedParser.parseFeed(url: rssBillParser.billURL[i])
        }
        
        print(rssBillParser.billCount)
        print(rssBillParser.billURL)
        
        /*feedParser.parseFeed(url: "https://www.gpo.gov/fdsys/bulkdata/BILLSTATUS/115/s/BILLSTATUS-115s999.xml")*/
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("----------I WANT TO SEE----------")
        print(feedParser.billItems.count)
        return feedParser.billItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BillTableViewCell
        
        feedParser.parseFeed(url: rssBillParser.billURL[indexPath.row])
        
        cell.titleLabel.text = feedParser.billItems[indexPath.row].title
        cell.sponsorLabel.text = feedParser.billItems[indexPath.row].fullName
        
        return cell
    }
}
