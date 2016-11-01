//
//  locationModel.swift
//  Cattle Drive
//
//  Created by Zachary Wiseman on 10/12/16.
//  Copyright © 2016 Zachary Wiseman. All rights reserved.
//
// This Method is a handler method for the data as it is ran through from the database

import Foundation
class locationModel: NSObject{
    //properties in database
    var farmName: String?
    var firstName: String?
    var lastName: String?
    var address: String?
    var city: String?
    var state: String?
    var zipCode: Int?
    var breed: String?
    var name: String?
    var price: Int?
    var tagNumber: Int?
    
    //empty constructor 
    override init(){
        
    }
    
    // constructor for declared variables
    init(farmName: String, firstName: String, lastName: String, address: String, city: String, state: String, zipCode: Int, name: String, breed: String, tagNumber: Int, price: Int){
        self.farmName = farmName
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.name = name
        self.breed = breed
        self.tagNumber = tagNumber
        self.price = price
    }
     //print farm data
    var farm: String {
        return "Farm: \(farmName), First Name: \(firstName), Last Name: \(lastName), Address: \(address), City: \(city), State: \(state), Zip Code: \(zipCode)"
    }
    
    var cows: String {
        return "Name: \(name), Breed: \(breed), Tag Number:\(tagNumber), Price:$\(price)"
    }
}
