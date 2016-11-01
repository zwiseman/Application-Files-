//
//  ThirdViewController.swift
//  Cattle Drive
//
//  Created by Zachary Wiseman on 9/28/16.
//  Copyright © 2016 Zachary Wiseman. All rights reserved.
//  my animals

import UIKit

class ThirdViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, parseModelProtocal  {
    @IBOutlet weak var add1: UIButton!
    @IBOutlet weak var add2: UIButton!
    @IBOutlet weak var myTable: UITableView!
    var feedItems: NSArray = NSArray()
    var selectedLocation : locationModel = locationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //set delegates and initialize homeModel
        
        self.myTable.delegate = self
        self.myTable.dataSource = self
        
        let ParseModel = parseModel()
        ParseModel.delegate = self
        ParseModel.downloadItems()
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.myTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         //Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the location to be shown
        let item: locationModel = feedItems[indexPath.row] as! locationModel
        // Get references to labels of cell
        myCell.textLabel!.text = item.address
        
        return myCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

