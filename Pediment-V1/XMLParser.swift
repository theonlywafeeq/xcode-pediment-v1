//
//  XMLParser.swift
//  Pediment-V1
//
//  Created by wafeeq on 2/20/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import Foundation

class BillModel {
    var billURL: String = ""
    var billfullName: String = ""
    var billtitle: String = ""
}

class BillXMLParser: NSObject, XMLParserDelegate
{
    var billItems: [BillModel] = []
    
    private var currentElement = ""
    
    private var currenturl: String = ""
    private var currenttitle: String = ""
    private var currentfullName: String = ""
    
    private var SETcurrenttitle: Bool = false
    private var SETcurrentfullName: Bool = false
    
    private var parserCompletionHandler: (([BillModel]) -> Void)?
    
    func parseFeed(url: String, completionHandler: (([BillModel]) -> Void)?)
    {
        currenturl = url
        
        self.parserCompletionHandler = completionHandler
        
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        
        task.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        currentElement = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if currentElement == "title" && SETcurrenttitle == false{
            currenttitle = string
            SETcurrenttitle = true
        }
        
        if currentElement == "fullName" && SETcurrentfullName == false{
            currentfullName = string
            SETcurrentfullName = true
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        let newBillItems = BillModel()
        newBillItems.billURL = currenturl
        newBillItems.billtitle = currenttitle
        newBillItems.billfullName = currentfullName
        
        print("URL")
        print(newBillItems.billURL)
        print("TITLE")
        print(newBillItems.billtitle)
        print("FULLNAME")
        print(newBillItems.billfullName)
        
        print("DONE PARSING")

        self.billItems.append(newBillItems)
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(billItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
    {
        print(parseError.localizedDescription)
    }
}


class HR115XMLParser: NSObject, XMLParserDelegate
{
    var billItems: [String] = []
    
    private var currentElement = ""
    
    private var currentURL: String = ""
    
    private var tagSwitch: Bool = false
    
    func parseFeed(url: String)
    {
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        
        task.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        currentElement = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if (currentElement == "loc" && tagSwitch == false) {
            currentURL = string
            billItems.append(currentURL)
            tagSwitch = true
        }
        else {
            tagSwitch = false
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
    {
        print(parseError.localizedDescription)
    }
}
