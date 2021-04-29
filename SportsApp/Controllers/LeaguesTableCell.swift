//
//  LeaguesTableViewCell.swift
//  SportsApp
//
//  Created by Norhan on 4/21/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import UIKit
import SDWebImage

class LeaguesTableCell: UITableViewCell {
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueIView: UIView!
    
    var youtubeLink: String = ""
    var actionBlock: (() -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpLeaguesTableCell(leagueName: String, imageName: String, youtubeLink: String) {
        leagueIView!.layer.borderWidth = 1
        leagueIView!.layer.borderColor = UIColor(named: "border")?.cgColor
        leagueIView!.layer.masksToBounds = false
        leagueIView!.layer.cornerRadius = leagueIView.frame.size.height/2
        leagueIView!.clipsToBounds = true
        
        leagueNameLabel.text = leagueName
        //leagueNameLabel.textColor = UIColor(named: "light")
        leagueImage.sd_setImage(with: URL(string: imageName), placeholderImage: UIImage(named: "no"))
        self.youtubeLink = youtubeLink
    }

    @IBAction func youtubeButton(_ sender: Any) {
        actionBlock?()

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


