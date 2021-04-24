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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var sportName:String!
    var leagues = [LeaguesInfoModel]()
   // let indicator = Indicator()
    var filteredData :[LeaguesInfoModel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaguesTabelView.delegate = self
        leaguesTabelView.dataSource = self
        searchBar.delegate = self
        filteredData = leagues
        print("hello")
        
        
        self.title = sportName
       // indicator.startAnimating(view: view)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.global(qos: .background).async {
            NetworkServiceModal.instance.getData(url:  urls.getLeaguesListURL , completion:{(myLeague: LeaguesModel?,error) in
                if let myError = error{
                    print("in myError")
                    print(myError)
                }else{
                    print("11111")
                    guard let myLeagues = myLeague else {return}
                    for index in 0 ..< myLeagues.leagues!.count{
                        print("any")
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
                NetworkServiceModal.instance.getData(url:urls.getLeaguesDetailsURL + self.leagues[index].info.idLeague!, completion:{(myLeagueDetailes: LeaguesDetailesModel?,error) in
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
//        let name = self.filteredData[indexPath.section].info.strLeague ?? ""
//        let id = self.filteredData[indexPath.section].info.idLeague ?? ""
//        let image = self.filteredData[indexPath.section].moreInfo.strBadge ?? ""
//        let youtube = self.filteredData[indexPath.section].moreInfo.strYoutube ?? ""
//        let myLeague = FavoriteLeague(id: id, name: name, image: image, youtubeUrl:youtube)
//        tableView.deselectRow(at: indexPath, animated: true)
//        performSegue(withIdentifier: "ShowDetailes", sender: myLeague)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowDetailes" {
//            if let detailesVC = segue.destination as? LeaguesDetialesViewController{
//
//                detailesVC.myLeague = league
//            }
//        }
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

// MARK: Search Bar
extension LeaguesViewController :UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchText == ""{
            filteredData = leagues
        }
        
        filteredData = []
        for i in leagues{
                
            if (i.moreInfo.strLeague?.contains(searchText))!{
                    filteredData.append(i)
                }
        }
        self.leaguesTabelView.reloadData()
        
    }

    
}
