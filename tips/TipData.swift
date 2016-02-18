//
//  TipData.swift
//  tips
//
//  Created by Matthew Leonard on 2/16/16.
//  Copyright © 2016 matteleonard. All rights reserved.
//

import Foundation

class TipData {
    class var sharedInstance: TipData {
        struct Static {
            static var instance: TipData?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = TipData()
        }
        
        return Static.instance!
    }
    
    
    var defaultTipValue = 0.2
    var tipindex = 1
}