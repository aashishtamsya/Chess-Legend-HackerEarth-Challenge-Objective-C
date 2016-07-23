//
//  ChessLegend.swift
//  ATChessLegend
//
//  Created by Aashish Tamsya on 23/07/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

import UIKit

class ChessLegend: NSObject {

    var name : String = String()
    var rating : Int = Int()
    
    override init() {
        self.name = "No Name"
        self.rating = 0
    }
    
    init(name : String, rating : Int) {
        self.name = name
        self.rating = rating
    }
    
}
