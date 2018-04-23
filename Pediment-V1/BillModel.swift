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
    var text: String?
    
}

class BillModelXMLParser: NSObject, XMLParserDelegate
{
    private var currentElement: String = ""
    private var currentURL: String = ""
    
    private var FOUNDbill: Bool = false
    private var FOUNDfullName: Bool = false
    private var FOUNDtitle: Bool = false
    private var FOUNDloc: Bool = false
    private var FOUNDtext: Bool = false
    private var FOUNDSWITCHtext: Int = 0
    
    // values retrived from XML file
    var fullName: String = ""
    var title: String = ""
    var loc: [String] = []
    var text: String = ""
    
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
        
        // find text summary
        if elementName == "text" {
            FOUNDtext = true
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
        
        print(FOUNDSWITCHtext)
        if FOUNDtext && FOUNDSWITCHtext == 0{
            text = string
            FOUNDSWITCHtext = 1
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
//        if FOUNDtext {
//            FOUNDtext = false
//        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser)
    {
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
    {
    }
}
