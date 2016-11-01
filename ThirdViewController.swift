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

    //Also you want your cell identifier globally accessible for 
    //scenarios that may arise later
    let cellIdentifier: String = "BasicCell"    

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
	//From what I can see you are using parseModel.swift to pull in your data for feedItems
	//So I'm assuming that you're data is being pulled in correctly and feedItems.count > 0
	//then you need to reload the tableData, which you almost got right.
	//So this line -> self.myTable.reloadData() will crash the application because you're trying
	//to modify the UI from a background thread which is a no-no.
	//Corrected code would be (because you have the dataSource set to self) -> DispatchQueue.main.async{self.myTable.reloadData()}

        self.myTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         //Return the number of feed items
        return feedItems.count        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

