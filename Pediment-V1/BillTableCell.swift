//
//  BillTableCell.swift
//  Pediment-V1
//
//  Created by Wafeeq on 2/12/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import UIKit

class BillTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var sponsorLabel:UILabel!
    
    var item: RSSItem! {
        didSet {
            titleLabel.text = item.title
            sponsorLabel.text = item.fullName
        }
    }
}
