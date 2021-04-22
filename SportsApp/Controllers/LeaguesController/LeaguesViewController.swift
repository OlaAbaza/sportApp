//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Norhan on 4/21/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import UIKit

class LeaguesViewController: UIViewController {

    @IBOutlet weak var leaguesTabelView: UITableView!
    
    
    var sportName:String!
    var leagues = [LeaguesInfoModel]()
   // let indicator = Indicator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         leaguesTabelView.delegate = self
         leaguesTabelView.dataSource=self
        print("hello")
        
        
        self.title = sportName
       // indicator.startAnimating(view: view)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.global(qos: .background).async {
            NetworkServiceModal.instance.getData(url: URLs.getLeaguesListURL, completion:{(myLeague: LeaguesModel?,error) in
                if let myError = error{
                    print("in myError")
                    print(myError)
                }else{
                    guard let myLeagues = myLeague else {return}
                    for index in 0 ..< myLeagues.leagues!.count{
                        
                            let league: LeaguesInfoModel = LeaguesInfoModel()
                            league.info = myLeagues.leagues![index]
                            self.leagues.append(league)
                        
                    }
                    self.getMoreInfo()
                    print("else")
                    DispatchQueue.main.async {
                        self.leaguesTabelView.reloadData()
                        //self.indicator.stopAnimating()
                    }
                }
            })
        }
    }
    private func getMoreInfo(){
          DispatchQueue.global(qos: .background).async {
              for index in 0..<self.leagues.count{
                NetworkServiceModal.instance.getData(url:URLs.getLeaguesDetailsURL + self.leagues[index].info.idLeague!, completion:{(myLeagueDetailes: LeaguesDetailesModel?,error) in
                      if let myError = error{
                          print(myError)
                      }else{
                          guard let leagues = myLeagueDetailes?.leagues else{return}
                          self.leagues[index].moreInfo = leagues[0]
                      }
                      DispatchQueue.main.async {
                          self.leaguesTabelView.reloadData()
                      }
                  })
              }

          }

    }

}


extension LeaguesViewController :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaguesTabelView.dequeueReusableCell(withIdentifier: "LeaguesTableCell", for: indexPath) as! LeaguesTableCell
        
        
        let youtubeLink = leagues[indexPath.section].moreInfo.strYoutube!
        
        if (youtubeLink.isEmpty){
            cell.youtubeButton.isHidden = true
        } else {
            cell.youtubeButton.isHidden = false
            cell.youtubeButton.tag = indexPath.section
        }

        let name = leagues[indexPath.section].moreInfo.strLeague ?? "no name"
        let image = leagues[indexPath.section].moreInfo.strBadge ?? " no"
        cell.setUpLeaguesTableCell(leagueName: name, imageName: image, youtubeLink: youtubeLink)

//        cell.layer.borderWidth = 4
//        cell.layer.borderColor = UIColor(named: "light")?.cgColor
//        cell.backgroundColor = UIColor(named: "light")
//        cell.layer.cornerRadius = 32
//        cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner,.layerMaxXMinYCorner]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }
    
    
}

extension LeaguesViewController{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.frame.size.width * 0.3)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
}
