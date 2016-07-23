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
    
    func getJSON(URL : NSURL) -> JSON? {
        
        var json : JSON?
        
        if ATUtils.sharedManager.checkInternetConnection() == true {
            let dataFromWeb : NSData = NSData.init(contentsOfURL: URL)!
            if let jsonResponse : JSON = JSON.init(data: dataFromWeb) {
                json = jsonResponse
            }
        }
        return json
    }

}
