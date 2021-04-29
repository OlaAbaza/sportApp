//
//  SportsCollectionViewCell.swift
//  SportsApp
//
//  Created by ola abaza on 4/21/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import UIKit
import SDWebImage
class SportsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var nameLabelView: UIView!
    @IBOutlet weak var sportNameLabel: UILabel!
    
    func setUpSportsCollectionCell(sportName: String, imageName: String) {
        print(sportName)
        sportNameLabel.text = sportName
      sportImage.sd_setImage(with: URL(string: imageName), placeholderImage: UIImage(named: "no"))
        
      nameLabelView.backgroundColor = UIColor(named: "light")?.withAlphaComponent(0.8)
     nameLabelView.layer.cornerRadius = 20
     nameLabelView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
}
