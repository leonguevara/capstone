//
//  MenuCellController.swift
//  capstone
//
//  Created by León Felipe Guevara Chávez on 7/15/16.
//  Copyright © 2016 León Felipe Guevara Chávez. All rights reserved.
//

import UIKit

class MenuCellController: UITableViewCell {

    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuOption: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
