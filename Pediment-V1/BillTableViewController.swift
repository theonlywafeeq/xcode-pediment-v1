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
    
    var viewBillItems: [BillModel] = []
    
    private var billItems: [BillModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private func fetchData()
    {
        hr115XMLParser.parseFeed(url: "https://www.gpo.gov/smap/bulkdata/BILLSTATUS/115hr/sitemap.xml")
        
        print()
        print("-------------------")
        print()
        
        print("It is taking a while")
        
        print()
        print("-------------------")
        print()
        
        for index in 0..<10 {
            sleep(1)
            print("Count ", index + 1)
        }
        
        print()
        print("-------------------")
        print()
        
        for index in 0..<100 {
            print()
            print("NEW ITEM \(index)")
            print()

            billXMLParser.parseFeed(url: hr115XMLParser.billItems[index])
            
            sleep(1)
            
            /*
            for index in 0..<3 {
                sleep(1)
                print("Count ", index + 1)
            }*/
            
            print(billXMLParser.billItemsArray[index].billtitle)
            print(billXMLParser.billItemsArray[index].billfullName)
            print(billXMLParser.billItemsArray[index].billURL)
            
            var newViewBillItem = BillModel()
            
            newViewBillItem.billtitle = billXMLParser.billItemsArray[index].billtitle
            newViewBillItem.billfullName = billXMLParser.billItemsArray[index].billfullName
            newViewBillItem.billURL = billXMLParser.billItemsArray[index].billURL
            
            viewBillItems.append(newViewBillItem)
            
            print()
            print("END ITEM")
            print()
        }
        
        //print(billXMLParser.billItems.count)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billXMLParser.billItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BillTableViewCell
        
        print(indexPath.row)
        print(viewBillItems[indexPath.row].billtitle)
        print(viewBillItems[indexPath.row].billfullName)
        print(viewBillItems[indexPath.row].billURL)
        
        
        cell.titleLabel.text = viewBillItems[indexPath.row].billtitle
        cell.sponsorLabel.text = viewBillItems[indexPath.row].billfullName
        
        return cell
    }
}
