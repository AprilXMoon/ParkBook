//
//  ParkInfoModel.swift
//  ParkBook
//
//  Created by April on 2018/4/6.
//  Copyright © 2018年 April. All rights reserved.
//

import UIKit

class ParkInfoModel: NSObject {
    
    var parkName: String?
    var name: String?
    var buildingYear: String?
    var openTime: String?
    var parkImage: String?
    var parkIntroduction: String?
    
    init (parkDict: Dictionary<String, String>) {
        
        if let parkName = parkDict["ParkName"] {
            self.parkName = parkName
        }
        
        if let name = parkDict["Name"] {
            self.name = name
        }
        
        if let buildingYear = parkDict["YearBuilt"] {
            self.buildingYear = buildingYear
        }
        
        if let openTime = parkDict["OpenTime"] {
            self.openTime = openTime
        }
        
        if let parkImage = parkDict["Image"] {
            self.parkImage = parkImage
        }
        
        if let introduction = parkDict["Introduction"] {
            self.parkIntroduction = introduction
        }
        
    }

}
