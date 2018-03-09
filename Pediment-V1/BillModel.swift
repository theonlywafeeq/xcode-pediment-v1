//
//  BillModel.swift
//  Pediment-V1
//
//  Created by wafeeq on 3/7/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import Foundation

struct BillModel {
    
    private var link: String
    private var title: String
    private var sponsor: String
    
    private var xmlParser: BillModelXMLParser
    private var parser: XMLParser
    
    
    mutating func parseBill() {
        xmlParser.parseFeed("https://www.gpo.gov/fdsys/bulkdata/BILLSTATUS/115/hr/BILLSTATUS-115hr82.xml")
        sponsor = xmlParser.fullName
        title = xmlParser.title
    }
}

class BillModelXMLParser: NSObject, XMLParserDelegate
{
    private var currentElement: String
    private var currentURL: String
    
    // Use these booleans to search for fullName.
    private var FOUNDbill: Bool = false
    private var FOUNDsponsors: Bool = false
    private var FOUNDitem: Bool = false
    private var FOUNDfullName: Bool = false
    
    // Use these booleans to search for title.
    private var FOUNDtitles: Bool = false
    private var FOUNDtitleType: Bool = false
    private var FOUNDtitle: Bool = false
    
    // values retrived from XML file
    var fullName: String
    var title: String
    
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
            
            /// parse our xml data
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        
        task.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        if elementName == "bill" {
            FOUNDbill = true
        }
        
        // find sponsor
        if elementName == "sponsors" && FOUNDbill {
            FOUNDsponsors = true
        }
        
        if elementName == "item" && FOUNDbill && FOUNDsponsors {
            FOUNDitem = true
        }
        
        if elementName == "fullName" && FOUNDbill && FOUNDsponsors && FOUNDitem {
            FOUNDfullName = true
        }
        
        // find title
        if elementName == "titles" && FOUNDbill {
            FOUNDtitles = true
        }
        
        if elementName == "item" && FOUNDbill && FOUNDtitles {
            FOUNDitem = true
        }
        
        if elementName == "titleType" && FOUNDbill && FOUNDtitles && FOUNDitem {
            FOUNDtitleType = true
        }
        
        if elementName == "title" && FOUNDbill && FOUNDtitles && FOUNDitem && FOUNDtitleType {
            FOUNDtitle = true
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if currentElement == "fullName" && FOUNDfullName {
            fullName = string
        }
        
        if currentElement == "title" && FOUNDtitle {
            title = string
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if FOUNDfullName {
            FOUNDbill = false
            FOUNDsponsors = false
            FOUNDitem = false
            FOUNDfullName = false
        }
        
        if FOUNDtitle {
            FOUNDbill = false
            FOUNDtitles = false
            FOUNDitem = false
            FOUNDtitleType = false
            FOUNDtitle = false
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser)
    {
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
    {
    }
 
}
