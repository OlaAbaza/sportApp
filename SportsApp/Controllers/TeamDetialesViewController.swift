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
    
    var teamId  = "133604"
    var teamName = ""
    var data = [TeamsDetails]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
        teamLogoImage.maskCircle()
        self.serviceCall()
        self.title = teamName

        // Do any additional setup after loading the view.
    }
    
    func serviceCall(){
      //if
        let url = URLs.getTeamUrl.rawValue + teamId.replacingOccurrences(of: " ", with: "_")
        NetworkServiceModal.instance.getData(url: url)
        { (sport: TeamIDModel?, error) in
            if let error = error {
                print(error)
            }else{
                
                guard let datasports = sport else { return  }
                if let teamDetails = (datasports.teams){
                    self.data = teamDetails
                }
                
                DispatchQueue.main.async {
                    self.teamNameLabel.text = self.data[0].strTeam
                    self.descriptionText.text = self.data[0].strDescriptionEN
                    
                    if let teamImgUrl = self.data[0].strTeamBadge{
                        let img = NSURL(string: teamImgUrl )! as URL
                        self.teamLogoImage.sd_setImage(with: img, completed: nil)
                    }
                    
                }
            }
            
        }
        
    }
    
 

    @IBAction func faceBookButton(_ sender: Any) {
        
        let socialLink = (data[0].strFacebook ?? "")!
        pushToSocialView(link: socialLink)

    }
    
    
    @IBAction func instgramButton(_ sender: Any) {
        
        let socialLink = (data[0].strInstagram ?? "")!
        pushToSocialView(link: socialLink)
            
    }
    @IBAction func twitterButton(_ sender: Any) {
        
        let socialLink = (data[0].strTwitter ?? "")!
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
