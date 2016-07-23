//
//  ATDatabaseManager.swift
//  ATChessLegend
//
//  Created by Aashish Tamsya on 23/07/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

import UIKit
import FMDB


let kDatabaseName : String = "ATChessLegend.sqlite"
let sharedInstance         = ATDatabaseManager()

class ATDatabaseManager: NSObject {

    var database : FMDatabase? = nil
    
    class func getDatabaseInstance() -> ATDatabaseManager {
        
        if sharedInstance.database == nil {
            sharedInstance.database = FMDatabase.init(path: ATUtils.sharedManager.getFilePathForDatabase(kDatabaseName))
            return sharedInstance
        }
        return sharedInstance
    }
    
    func addChessLegend(chessLegendModel: ChessLegend) -> Bool
    {
        sharedInstance.database!.open()

        let isDataInserted = sharedInstance.database!.executeUpdate("INSERT INTO LEGENDS (name, rating, changeinrating) VALUES (?, ?, ?)", withArgumentsInArray: [chessLegendModel.name, chessLegendModel.rating,chessLegendModel.changeInRating])
        
        sharedInstance.database!.close()
        
        return isDataInserted
    }
    
    func fetchAllChessLegends() -> [ChessLegend] {
        
        sharedInstance.database!.open()
        
        var allChessLegends = [ChessLegend]()
        
        let resultSet : FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM LEGENDS", withArgumentsInArray:nil)
        
        if resultSet != nil {
            
            while resultSet.next() {
                let chessLegendModel : ChessLegend = ChessLegend.init(chess_id: Int(resultSet.intForColumn("id")), name: resultSet.stringForColumn("name"), rating: Float(resultSet.doubleForColumn("rating")), changeInRating: Float(resultSet.doubleForColumn("changeinrating")))
                 allChessLegends.append(chessLegendModel)
            }
        }
        
        sharedInstance.database!.close()
        
        return allChessLegends
        
    }
   
    func updateChessLegend(chessLegendModel : ChessLegend) -> Bool {
        
        sharedInstance.database!.open()
        
        let isDataUpdated = sharedInstance.database!.executeUpdate("UPDATE LEGENDS SET rating = ?, changeinrating = ? WHERE name = ?", withArgumentsInArray: [chessLegendModel.rating,chessLegendModel.changeInRating,chessLegendModel.name])
        
        sharedInstance.database!.close()
        
        return isDataUpdated
    }
    
    func deleteChessLegend(chessLegendModel : ChessLegend) -> Bool {
        sharedInstance.database?.open()
        
        let isDataDeleted = sharedInstance.database!.executeUpdate("DELETE FROM LEGENDS WHERE name = ?", withArgumentsInArray: [chessLegendModel.name])
        
        sharedInstance.database?.close()
        
        return isDataDeleted
    }
    
    func getTableRows() {
        sharedInstance.database!.open()

        
        let sqlStatement = "SELECT COUNT(id) as TOTAL FROM LEGENDS"
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(sqlStatement, withArgumentsInArray: nil)
        if resultSet.next() {
            let rowCount = resultSet.intForColumnIndex(0)
            NSLog("Table Rows = %d",rowCount)
            totalRow = rowCount
        }
        sharedInstance.database!.close()
    }
}
