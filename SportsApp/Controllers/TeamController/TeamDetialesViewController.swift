//
//  TeamDetialesViewController.swift
//  SportsApp
//
//  Created by Norhan on 4/24/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import UIKit

class TeamDetialesViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var teamLogoImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    var team : Teams?
   
    override func viewDidLoad() {
        super.viewDidLoad()
       // teamLogoImage.maskCircle()
        self.setupView()
        self.title = teamName

    }
    func setupView(){
        if let team = self.team {
            if let teamImgUrl = team.strTeamBadge {
                let img = NSURL(string: teamImgUrl ?? "")! as URL
                self.teamLogoImage.sd_setImage(with: img, completed: nil)
            }
            self.teamNameLabel.text = team.strTeam ?? ""
            self.descriptionText.text = team.strDescriptionEN ?? ""
        }
    }

    @IBAction func faceBookButton(_ sender: Any) {
        
        guard let socialLink = (team?.strFacebook) else { return}
        pushToSocialView(link: socialLink)

    }
    
    
    @IBAction func instgramButton(_ sender: Any) {
        
        guard let socialLink = (team?.strInstagram) else { return}
        pushToSocialView(link: socialLink)
            
    }
    @IBAction func twitterButton(_ sender: Any) {
        
        guard let socialLink = (team?.strTwitter) else { return}
        pushToSocialView(link: socialLink)
         
    }

    func pushToSocialView(link: String){
        let SocialView = storyboard?.instantiateViewController(withIdentifier: "SocialViewController") as! SocialViewController
        SocialView.link = link
        self.navigationController?.pushViewController(SocialView, animated: true)
    }
    
}

extension UIImageView {
    public func maskCircle() {
      self.contentMode = UIView.ContentMode.scaleAspectFill
      self.layer.cornerRadius = self.frame.height / 2
      self.layer.masksToBounds = false
      self.clipsToBounds = true
    }
    

}
