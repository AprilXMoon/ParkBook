//
//  OtherPlaceCell.swift
//  ParkBook
//
//  Created by April on 2018/4/8.
//  Copyright © 2018年 April. All rights reserved.
//

import UIKit

class OtherPlaceCell: UICollectionViewCell {
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        placeName.text = ""
        placeImage.image = UIImage(named:"defaultPark")
    }
}
