//
//  ATUtils.swift
//  ATChessLegend
//
//  Created by Aashish Tamsya on 23/07/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

import UIKit
import ReachabilitySwift

class ATUtils: NSObject {

    static let sharedManager = ATUtils()
    
    
    func checkInternetConnection() -> Bool {
        
        
        var reachability : Reachability!
            
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        }
        catch {
            print("Somethind Went wrong!")
        }
        
        if reachability.isReachable() {
            return true
        }
        else {
            return false
        }
    }
}
