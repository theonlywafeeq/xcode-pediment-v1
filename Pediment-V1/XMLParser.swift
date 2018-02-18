//
//  XMLParser.swift
//  Pediment-V1
//
//  Created by Wafeeq on 2/7/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import Foundation

struct BillItem {
    var fullName: String
    var title: String
}

class FeedParser: NSObject, XMLParserDelegate
{
    private var billItems: [BillItem] = []
    
    private var currentElement = ""
    private var currentTitle: String = ""
    private var currentfullName: String = ""
    
    private var SETfullName: Bool = false
    private var SETtitle: Bool = false
    
    private var parserCompletionHandler: (([BillItem]) -> Void)?
    
    func parseFeed(url: String, completionHandler: (([BillItem]) -> Void)?)
    {
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
        if currentElement == "title" && SETtitle == false {
            currentTitle += string
            SETtitle = true
        }
        
        if currentElement == "fullName" && SETfullName == false {
            currentfullName += string
            SETfullName = true
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        let billItems = BillItem(fullName: currentfullName, title: currentTitle)
        self.billItems.append(billItems)
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(billItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
    {
        print(parseError.localizedDescription)
    }
}
