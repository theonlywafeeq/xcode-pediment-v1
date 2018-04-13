//
//  BillModel.swift
//  Pediment-V1
//
//  Created by wafeeq on 3/7/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import Foundation

struct BillModel {
    
    var link: String?
    var title: String?
    var sponsor: String?
    
}

class BillModelXMLParser: NSObject, XMLParserDelegate
{
    private var currentElement: String = ""
    private var currentURL: String = ""
    
    private var FOUNDbill: Bool = false
    private var FOUNDfullName: Bool = false
    private var FOUNDtitle: Bool = false
    private var FOUNDloc: Bool = false
    
    // values retrived from XML file
    var fullName: String = ""
    var title: String = ""
    var loc: [String] = []
    
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
        // find sponsor
        if elementName == "fullName" {
            FOUNDfullName = true
        }
        
        // find title
        if elementName == "title" {
            FOUNDtitle = true
        }
        
        // find url
        if elementName == "loc" {
            FOUNDloc = true
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if FOUNDfullName {
            fullName = string
        }
        
        if FOUNDtitle {
            title = string
        }
        
        if FOUNDloc {
            loc.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if FOUNDfullName {
            FOUNDfullName = false
        }
        
        if FOUNDtitle {
            FOUNDtitle = false
        }
        
        if FOUNDloc {
            FOUNDloc = false
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser)
    {
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
    {
    }
}
