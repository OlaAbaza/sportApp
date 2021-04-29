//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by ola abaza on 4/28/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet weak var leaguesTabelView: UITableView!
        
    var leagues = [FavoriteModel]()
    var isConected: Bool?
    
    override func viewDidLoad() {
        leaguesTabelView.delegate = self
        leaguesTabelView.dataSource = self
        self.title = "Favorite"
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        let coreData = CoreDataModel()
        leagues = []
        leagues = coreData.gitAllData()
        leaguesTabelView.reloadData()
    }
}

extension FavoriteViewController :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaguesTabelView.dequeueReusableCell(withIdentifier: "LeaguesCell", for: indexPath) as! LeaguesTableCell
        let youtubeLink = leagues[indexPath.section].youtubeUrl!
        if (youtubeLink.isEmpty){
            cell.youtubeButton.isHidden = true
        } else {
            cell.youtubeButton.isHidden = false
            cell.youtubeButton.tag = indexPath.section
        }
        cell.actionBlock = {
            let newViewController =  self.storyboard?.instantiateViewController(withIdentifier: "YoutubeViewController") as! YoutubeViewController
            newViewController.youtubeLink = self.leagues[indexPath.section].youtubeUrl!
                        self.navigationController?.pushViewController(newViewController, animated: true)
            }
        let name = leagues[indexPath.section].name ?? "no name"
        let image = leagues[indexPath.section].image ?? " no"
        cell.setUpLeaguesTableCell(leagueName: name, imageName: image, youtubeLink: youtubeLink)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard NetworkServiceModal.instance.checkInternet() else {
            print("No internet")
            self.showAlert()
            return
        }
            let name = self.leagues[indexPath.section].name ?? ""
            let id = self.leagues[indexPath.section].id ?? ""
            let image = self.leagues[indexPath.section].image ?? ""
            let youtube = self.leagues[indexPath.section].youtubeUrl ?? ""
        
            let myLeague = FavoriteModel(id: id, name: name, image: image, youtubeUrl:youtube)
            
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "ShowDetailes", sender: myLeague)
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailes" {
            if let detailesVC = segue.destination as? LeaguesDetialesViewController{
                let league = sender as? FavoriteModel
                detailesVC.myLeagues = league
            }
        }
    }
    func showAlert() {
        let alert = UIAlertController(title: "Warning!", message: "Check Your Connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension FavoriteViewController{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.frame.size.width * 0.3)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
}
