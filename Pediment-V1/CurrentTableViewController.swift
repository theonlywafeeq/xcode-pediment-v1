class CurrentTableViewController {
  var bills: [Bill] = []
  var billNumber = String()
  var billType = String()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let path = NSBundle.mainBundle().URLForResource("bills", withExtension: "xml")
      if let parser = NSXMLParser(contentsOfUrl: path) {
        parser.delegate = self
        parser.parse()
      }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let bill = bills[indexPath.row]

        cell.textLabel?.text = bill.billNumber
        cell.detailTextLabel?.text = bill.billType

        return cell
    }
    
    // 1
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        eName = elementName
        if elementName == "bill" {
            billNumber = String()
            billType = String()
        }
    }

    // 2  
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "bill" {
          let bill = Bill()
          bill.billNumber = billNumber
          bill.billType = billType

          bills.append(bill)
        }
    }

    // 3
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        let data = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())

        if (!data.isEmpty) {
            if eName == "billNumber" {
                billNumber += data
            } else if eName == "billType" {
                billType += data
            }
        }
    }
}
