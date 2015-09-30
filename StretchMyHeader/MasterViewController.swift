//
//  MasterViewController.swift
//  StretchMyHeader
//
//  Created by Katherine Peterson on 2015-09-29.
//  Copyright © 2015 KatieExpatriated. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    var kTableHeaderHeight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
         kTableHeaderHeight = headerView.frame.size.height
        self.updateHeaderView()
        
        let dayTimePeriodFormatter = NSDateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMMM d"
        let date = NSDate()
        let dateString = dayTimePeriodFormatter.stringFromDate(date)
        
        UIApplication.sharedApplication().statusBarHidden = true
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        let climate:NewsItem = NewsItem.init(category: "World", headline: "Climate change protests, divestments meet fossil fuels realities")
        let scotland:NewsItem = NewsItem.init(category: "Europe", headline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'")
        let airstrike:NewsItem = NewsItem.init(category: "Middle East", headline: "Airstrikes boost Islamic State, FBI director warns more hostages possible")
        let nigeria:NewsItem = NewsItem.init(category: "Africa", headline: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim")
        let despite:NewsItem = NewsItem.init(category: "Asia Pacific", headline: "Despite UN ruling, Japan seeks backing for whale hunting")
        let official:NewsItem = NewsItem.init(category: "Americas", headline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria")
        let south:NewsItem = NewsItem.init(category: "World", headline: "South Africa in $40 billion deal for Russian nuclear reactors")
        let one:NewsItem = NewsItem.init(category: "Europe", headline: "'One million babies' created by EU student exchanges")
        objects = [climate, scotland, airstrike, nigeria, despite, official, south, one]
        
        dateLabel.text = dateString
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NewsItem
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! HeadlineCell

        let object = objects[indexPath.row] as! NewsItem
        cell.setCellContents(object)
        self.updateHeaderView()
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func updateHeaderView () {
        tableView.contentInset = UIEdgeInsetsMake(kTableHeaderHeight-30, 0, 0, 0)
        let headerOriginFrame = CGRectMake(0, 30-kTableHeaderHeight, tableView.bounds.size.width, headerView.frame.size.height)
        headerView.frame = headerOriginFrame
        
        if tableView.contentOffset.y < 30-kTableHeaderHeight {
            let frame = CGRectMake(headerView.frame.origin.x, tableView.contentOffset.y, headerView.frame.size.width, -tableView.contentOffset.y+30)
            headerView.frame = frame
        }
        
        addDiagonalMaskToImage()
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.updateHeaderView()
    }
    
    func addDiagonalMaskToImage () {
        let maskLayer = CAShapeLayer ()
        let trianglePath = UIBezierPath ()
        trianglePath.moveToPoint(CGPointMake(headerView.frame.origin.x, headerView.frame.origin.y))
        trianglePath.addLineToPoint(CGPointMake(headerView.frame.size.width, headerView.frame.origin.y))
        trianglePath.addLineToPoint(CGPointMake(headerView.frame.size.width, headerView.frame.size.height))
        trianglePath.addLineToPoint(CGPointMake(headerView.frame.origin.x, headerView.frame.size.height - 30))
        trianglePath.closePath()
        maskLayer.fillColor = UIColor.whiteColor().CGColor
        maskLayer.backgroundColor = UIColor.clearColor().CGColor
        maskLayer.path = trianglePath.CGPath
        headerView.layer.mask = maskLayer
    }
    
}

