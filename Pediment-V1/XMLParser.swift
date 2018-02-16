//
//  XMLParser.swift
//  Pediment-V1
//
//  Created by Wafeeq on 2/7/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import Foundation

var SETfullName: Bool = false
var SETtitle: Bool = false

struct RSSItem {
    var fullName: String
    var title: String
}

class FeedParser: NSObject, XMLParserDelegate
{
    private var rssItems: [RSSItem] = []
    private var currentElement = ""
    
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentfullName: String = "" {
        didSet {
            currentfullName = currentfullName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var parserCompletionHandler: (([RSSItem]) -> Void)?
    
    func parseFeed(url: String, completionHandler: (([RSSItem]) -> Void)?)
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
    
    // MARK: - XML Parser Delegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentfullName = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        print("----------NEW LINE----------")
        print(currentElement)
        
        if currentElement == "title" && SETtitle == false {
            currentTitle += string
            SETtitle = true
            print("YOU GOT IT")
            print(currentElement)
        }
        
        if currentElement == "fullName" && SETfullName == false {
            currentfullName += string
            SETfullName = true
            print("YOU GOT IT")
            print(currentElement)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "item" {
            let rssItem = RSSItem(fullName: currentfullName, title: currentTitle)
            self.rssItems.append(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
    {
        print(parseError.localizedDescription)
    }
}
