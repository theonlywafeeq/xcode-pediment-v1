//
//  UserItem.swift
//  Pediment-V1
//
//  Created by wafeeq on 5/15/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import Foundation

struct UserItem {
    
    let name: String
    var aye: [String] = []
    var nay: [String] = []
    
    init(name: String, vote: String) {
        self.name = name
        if vote == "aye" {
            self.aye.append(vote)
        }
        if vote == "nay" {
            self.nay.append(vote)
        }
    }
    
    func returnVote() -> Any{
        return [
            "name": name,
            "aye": aye,
            "nay": nay
        ]
    }
    
}
