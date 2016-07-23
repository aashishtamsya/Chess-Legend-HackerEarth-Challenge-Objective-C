//
//  ChessLegendTableViewCell.swift
//  ATChessLegend
//
//  Created by Aashish Tamsya on 23/07/16.
//  Copyright © 2016 Aashish Tamsya. All rights reserved.
//

import UIKit

class ChessLegendTableViewCell: UITableViewCell {

    @IBOutlet weak var labelChangeInRating: UILabel!
    @IBOutlet weak var imageViewSelect: UIImageView!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.labelChangeInRating.layer.cornerRadius = 8.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
