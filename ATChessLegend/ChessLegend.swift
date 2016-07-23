//
//  ChessLegend.swift
//  ATChessLegend
//
//  Created by Aashish Tamsya on 23/07/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChessLegend: NSObject {

    var chess_id : Int = Int()
    var name : String = String()
    var rating : Float = Float()
    var changeInRating : Float = Float()
    
    override init() {
        self.name = "No Name"
        self.rating = 0
        self.changeInRating = 0
        self.chess_id = 0
    }
    
    init(name : String, rating : Float) {
        self.name = name
        self.rating = rating
        self.changeInRating = 0
        self.chess_id = 0
    }
    
    init(rating: Float) {
        let previousRating : Float = self.rating
        self.rating = rating
        self.changeInRating = rating - previousRating
    }
    
    init(chess_id: Int, name : String, rating : Float, changeInRating : Float) {
        self.name = name
        self.chess_id = chess_id
        self.rating = rating
        self.changeInRating = changeInRating
        
    }
    
    
    class func buildLegend(json:JSON) -> ChessLegend {
        
        let rating : Float = json["rating"].float!
        let name : String = json["name"].string!
        return ChessLegend.init(name: name, rating: rating)
    }
    
    class func buildLegends(rootJSON : JSON) {
        
        
        var allChessLegends : [ChessLegend] = [ChessLegend]()
        
        if let legends = (rootJSON["legends"].array?.map{ return ChessLegend.buildLegend($0) }) {
            allChessLegends = legends
        }
        
        if totalRow >= 20 {
            print("Data Already in database")
        }
        else {
            for legendModel in allChessLegends {
                
                ATDatabaseManager.getDatabaseInstance().addChessLegend(legendModel)
                
            }
        }
    }
    
}
