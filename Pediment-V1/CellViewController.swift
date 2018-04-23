//
//  CellViewController.swift
//  Pediment-V1
//
//  Created by wafeeq on 4/16/18.
//  Copyright © 2018 The Only Wafeeq. All rights reserved.
//

import UIKit
import Foundation

class CellViewController: UIViewController
{
    var billTitle: String?
    var billSponsor: String?
    var billFullSummary: String?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sponsorLabel: UILabel!
    @IBOutlet weak var fullSummaryLabel: UILabel!
    
    override func viewDidLoad() {
        titleLabel.text = billTitle
        sponsorLabel.text = billSponsor
        fullSummaryLabel.text = billFullSummary
    }
}
