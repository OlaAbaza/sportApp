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
        super.awakeFromNib()       // Initialization code
        //        teamImg.contentMode = UIView.ContentMode.scaleAspectFill
//        teamImg.layer.cornerRadius = min(self.frame.size.width ,self.frame.size.height  ) / 2
//        teamImg.layer.masksToBounds = false
//        teamImg.clipsToBounds = true
        
    }
    
    func updateCell(teamImage: String){
        let img = NSURL(string: teamImage)! as URL
        self.teamImg.sd_setImage(with: img, completed: nil)
    }
   
    
}
//extension UIImageView {
//    public func maskCircle() {
//      self.contentMode = UIView.ContentMode.scaleAspectFill
//      self.layer.cornerRadius = self.frame.height / 2
//      self.layer.masksToBounds = false
//      self.clipsToBounds = true
//    }
//}
