//
//  teamCell.swift
//  SportsApp
//
//  Created by ola abaza on 4/23/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import UIKit

class teamCell: UICollectionViewCell {
    
  
    @IBOutlet weak var teamImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(teamImage: String){
        let img = NSURL(string: teamImage)! as URL
        self.teamImg.sd_setImage(with: img, completed: nil)
    }
   
    
}
