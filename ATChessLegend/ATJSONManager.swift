//
//  ATJSONManager.swift
//  ATChessLegend
//
//  Created by Aashish Tamsya on 23/07/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

import UIKit
import ReachabilitySwift
import SwiftyJSON

class ATJSONManager: NSObject {
    
    static let sharedManager = ATJSONManager()
    
    func getJSONData(URL : NSURL) {
        
        if ATUtils.sharedManager.checkInternetConnection() == true {
            
            let dataFromWeb : NSData = NSData.init(contentsOfURL: URL)!
            
            let jsonResponse = JSON.init(data: dataFromWeb)
            
            let legends = jsonResponse["legend"]
            
        }
        
        
    }

}
