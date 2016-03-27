//
//  CustomCell.swift
//  OneDriveClient
//
//  Created by Peter Daukintis on 26/03/2016.
//  Copyright © 2016 Peter Daukintis. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
