//
//  ViewController.swift
//  Pediment-V1
//
//  Created by Wafeeq on 1/31/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import UIKit

//HI XCOde
//I made this comment on GitHub

class ViewController: UITableViewController, XMLParserDelegate {

    var billModel = BillModel()
    var billRow = BillRow()
    var currentContent = String()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billModel.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        let row = indexPath.row
        let bn = billModel.data[row].BillName
        let bs = billModel.data[row].BillSponsor
        let billName = String(format: bn!)
        let billSponsor = String(format: bs!)
        cell.textLabel?.text = billName
        cell.detailTextLabel?.text = billSponsor
        return cell
    }
    
    func beginParsing(urlString:String) {
        guard let myURL = NSURL(string:urlString) else {
            print("URL not defined properly")
            return
        }
        guard let parser = XMLParser(contentsOf: myURL as URL) else {
            print("Cannot Read Data")
            return
        }
        parser.delegate = self
        billModel = BillModel()
        if !parser.parse(){
            print("Data Errors Exist:")
            let error = parser.parserError!
            print("Error Description:\(error.localizedDescription)")
            print("Error reason:\(error.localizedFailureReason)")
            print("Line number: \(parser.lineNumber)")
        }
    
        tableView.reloadData()
    }
    
    //TODO: do this task below
    //FIXME: row below
    
    //MARK: NSXMLParser delegates
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        print("Beginning tag: <\(elementName)>")
        if elementName == "row"{
            billRow = BillRow()
        }
        currentContent = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

