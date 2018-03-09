////
////  XMLParser.swift
////  Pediment-V1
////
////  Created by wafeeq on 2/20/18.
////  Copyright © 2018 The Only Wafeeq. All rights reserved.
////
//
//import Foundation
//
//class BillModel {
//    var billURL: String = ""
//    var billfullName: String = ""
//    var billtitle: String = ""
//}
//
//class BillXMLParser: NSObject, XMLParserDelegate
//{
//    var billItemsArray: [BillModel] = []
//    var billItem = BillModel()
//
//    private var currentElement = ""
//
//    private var currentURL: String = ""
//    private var currenttitle: String = ""
//    private var currentfullName: String = ""
//
//    private var FOUNDcurrentTitle: Bool = false
//    private var FOUNDcurrentFullName: Bool = false
//
//    //private var parserCompletionHandler: (([BillModel]) -> Void)?
//
//    func parseFeed(url: String/*, completionHandler: (([BillModel]) -> Void)?*/)
//    {
//        currentURL = url
//
//        //self.parserCompletionHandler = completionHandler
//
//        let request = URLRequest(url: URL(string: url)!)
//        let urlSession = URLSession.shared
//        let task = urlSession.dataTask(with: request) { (data, response, error) in
//            guard let data = data else {
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//
//                return
//            }
//
//            let parser = XMLParser(data: data)
//            parser.delegate = self
//            parser.parse()
//        }
//
//        task.resume()
//    }
//
//    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
//    {
//        currentElement = elementName
//    }
//
//    func parser(_ parser: XMLParser, foundCharacters string: String)
//    {
//        //print()
//        //print("LINE NUMBER \(parser.lineNumber) || STRING VALUE \(string)")
//        //print()
//
//        billItem.billURL = currentURL
//
//        if currentElement == "title" && FOUNDcurrentTitle == false {
//            currenttitle = string
//            FOUNDcurrentTitle = true
//
//            billItem.billtitle = currenttitle
//        }
//        else {
//            FOUNDcurrentTitle = false
//        }
//
//        if currentElement == "fullName" && FOUNDcurrentFullName == false {
//            currentfullName = string
//            FOUNDcurrentFullName = true
//
//            billItem.billfullName = currentfullName
//        }
//        else {
//            FOUNDcurrentFullName = false
//        }
//    }
//
//    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
//    {
//    }
//
//    func parserDidEndDocument(_ parser: XMLParser)
//    {
//        billItemsArray.append(billItem)
//    }
//
//    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
//    {
//        print(parseError.localizedDescription)
//    }
//}
//
//
//class HR115XMLParser: NSObject, XMLParserDelegate
//{
//    var billItems: [String] = []
//
//    private var currentElement = ""
//
//    private var currentURL: String = ""
//
//    private var tagSwitch: Bool = false
//
//    func parseFeed(url: String)
//    {
//        let request = URLRequest(url: URL(string: url)!)
//        let urlSession = URLSession.shared
//        let task = urlSession.dataTask(with: request) { (data, response, error) in
//            guard let data = data else {
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//
//                return
//            }
//
//            let parser = XMLParser(data: data)
//            parser.delegate = self
//            parser.parse()
//        }
//
//        task.resume()
//    }
//
//    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
//    {
//        currentElement = elementName
//    }
//
//    func parser(_ parser: XMLParser, foundCharacters string: String)
//    {
//        if (currentElement == "loc" && tagSwitch == false) {
//            currentURL = string
//            self.billItems.append(currentURL)
//            tagSwitch = true
//        }
//        else {
//            tagSwitch = false
//        }
//    }
//
//    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
//    {
//    }
//
//    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
//    {
//        print(parseError.localizedDescription)
//    }
//}

