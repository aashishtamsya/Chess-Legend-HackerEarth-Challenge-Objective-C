//
//  ATUtils.swift
//  ATChessLegend
//
//  Created by Aashish Tamsya on 23/07/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

import UIKit
import ReachabilitySwift
import FCFileManager

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
    
    func getFilePathForDatabase(databaseName: String) -> String
    {
        let docDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectoryPath = docDir[0]
        let databasePath = documentDirectoryPath + "/\(databaseName)"
        print(databasePath)
        return databasePath
    }
    
    func copyDatabase() {
        
        let sourcePath : String = FCFileManager.pathForMainBundleDirectoryWithPath(kDatabaseName)
        let destinationPath : String = FCFileManager.pathForDocumentsDirectoryWithPath(kDatabaseName)
        
        let isSourceExist : Bool = FCFileManager.existsItemAtPath(sourcePath)
        let isDestinationExist : Bool = FCFileManager.existsItemAtPath(destinationPath)
        
        if isSourceExist == true {
            
            if isDestinationExist == true {
                print("Database Already Copied!")
            }
            else {
                
                do {
                    try FCFileManager.copyItemAtPath(sourcePath, toPath: destinationPath, error: (
                    
                    print("ERROR!")
                    ))
                }
                catch {
                    print("error while copying database.")
                }
            }
        }
        else {
            print("No Database found in Main Bundle.")
        }
        
        
    }
}
