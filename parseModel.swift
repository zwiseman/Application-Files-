//
//  parseModel.swift
//  Cattle Drive
//
//  Created by Zachary Wiseman on 10/12/16.
//  Copyright © 2016 Zachary Wiseman. All rights reserved.
//

import Foundation

protocol parseModelProtocal: class {
    func itemsDownloaded(items: NSArray)
}

class parseModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: parseModelProtocal!
    
    var data = Data()
    
    func downloadItems() {
        let urlPath: String = "http://zwiseman.com/farmAppService.php"
        let url = URL(string: urlPath)
        let urlRequest = URLRequest(url: url!)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest)
        
        task.resume()
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.data.append(data);
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            print("failed to dowload data")
        }else {
            print("Data downloaded")
            self.parseJSON()
        }
        
    }
    
    func parseJSON() {
        
        var jsonResult: NSMutableArray = NSMutableArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: self.data, options:[]) as! NSMutableArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement: NSDictionary = NSDictionary()
        let locations: NSMutableArray = NSMutableArray()
        
        for i in jsonResult
        {
            
            jsonElement = jsonResult[i as! Int] as! NSDictionary
            
            let location = locationModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let name = jsonElement["Name"] as? String,
                let address = jsonElement["Address"] as? String,
                let city = jsonElement["City"] as? String,
                let state = jsonElement["State"] as? String
            {
                
                location.name = name
                location.address = address
                location.city = city
                location.state = state
                
            }
            
            locations.add(location)
            
            DispatchQueue.main.asynchronously(execute: { () -> Void in
                
                self.delegate.itemsDownloaded(items: locations)
                
            })
            
        }
        
    }
    
}
