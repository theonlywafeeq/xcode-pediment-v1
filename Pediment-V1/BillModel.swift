//
//  BillModel.swift
//  Pediment-V1
//
//  Created by Wafeeq on 2/1/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import UIKit

class BillRow: NSObject {
    var BillName:String! = nil
    var BillSponsor:String! = nil
    override init(){}
    init (BillName:String,BillSponsor:String) {
        self.BillName = BillName
        self.BillSponsor = BillSponsor
    }
}

class BillModel: NSObject {
    var data:[BillRow] = []
}
