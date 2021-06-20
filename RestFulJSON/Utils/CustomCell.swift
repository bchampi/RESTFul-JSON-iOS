//
//  CustomCell.swift
//  RestFulJSON
//
//  Created by Mac 17 on 6/19/21.
//  Copyright © 2021 deah. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var genderMovieLabel: UILabel!
    @IBOutlet weak var durationMovieLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
