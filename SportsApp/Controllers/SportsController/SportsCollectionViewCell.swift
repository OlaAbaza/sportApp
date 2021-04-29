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
    @IBOutlet private weak var sportImage: UIImageView!
    @IBOutlet private weak var nameLabelView: UIView!
    @IBOutlet private weak var sportNameLabel: UILabel!
    
    func setUpSportsCollectionCell(sport: Sport) {
        //print(sportName)
        sportNameLabel.text = sport.sportName
        sportImage.sd_setImage(with: URL(string: sport.sportImg!), placeholderImage: UIImage(named: "no"))
        
        
    }
}
