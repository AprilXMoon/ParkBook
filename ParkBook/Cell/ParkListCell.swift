//
//  ParkListCell.swift
//  ParkBook
//
//  Created by April on 2018/4/8.
//  Copyright © 2018年 April. All rights reserved.
//

import UIKit

class ParkListCell: UITableViewCell {

    @IBOutlet weak var parkImage: UIImageView!
    @IBOutlet weak var parkName: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var parkIntroduction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        parkImage.image = UIImage(named: "defaultPark")
        parkName.text = ""
        name.text = ""
        parkIntroduction.text = ""
    }
    
}
