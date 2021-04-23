//
//  LeaguesDetialesViewController.swift
//  SportsApp
//
//  Created by ola abaza on 4/22/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import UIKit

class LeaguesDetialesViewController: UIViewController {
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    @IBOutlet weak var teamsCV: UICollectionView!
    @IBOutlet weak var resultsCollection: UICollectionView!
    @IBOutlet weak var upCommingCollection: UICollectionView!
    //var myLeague: FavoriteLeague?
    var myLeague : String?
    var myTeam : String?
    var teams : [Teams]?
    var events = [Events]()
    var upCommingEvents = [Events]()
    
    let coreData = CoreDataModel()
    let indicator = Indicator()
    var legueId : String = "4328"
    var leagueImage : String = ""
    var leagueName : String = ""
    var youtubeLink : String = ""
    
   override func viewDidLoad() {
        super.viewDidLoad()
        myLeague = "4328"
        myTeam = "English%20Premier%20League"
        self.title = "English Premier"
        self.view.backgroundColor = UIColor(named: "background")
        if coreData.isLeagueInFavorate(ID: (legueId)) {
            favoriteButton.image = UIImage(systemName: "heart.fill")
        }else{
            favoriteButton.image = UIImage(systemName: "heart")
        }
        favoriteButton!.tintColor = .red
        self.navigationItem.rightBarButtonItem = favoriteButton
        self.indicator.startAnimating(view: view)
        setupCollectionView()
        //requestUpcomingEvents()
    requestEvents(url: URLs.getUpcommingEventUrl.rawValue,isUpcommingEvent: true)
    requestEvents(url: URLs.getEventDetailsUrl.rawValue,isUpcommingEvent: false)
        requestTeams()
    }
    
    @IBAction func favoriteAction(_ sender: UIBarButtonItem) {
        if coreData.isLeagueInFavorate(ID: (legueId)) {
            favoriteButton.image = UIImage(systemName: "heart")
            coreData.deleteLeague(leagueID: (legueId))
        }else{
            favoriteButton.image = UIImage(systemName: "heart.fill")
           // coreData.addLeague(league: myLeague!)
        }
    }
    
    func requestTeams(){
        if let leagueName = self.myTeam{
            let url = URLs.getTeamUrl.rawValue + leagueName.replacingOccurrences(of: " ", with: "_")
            NetworkServiceModal.instance.getData(url: url) { (myLeagueTeams: TeamModel?, error) in
                    if let myError = error{
                        print(myError)
                    }else{
                        self.teams = myLeagueTeams?.teams
                    }
                    DispatchQueue.main.async {
                        self.teamsCV.reloadData()
                        self.indicator.stopAnimating()
                        if (self.teams == nil) {
                            let image = UIImage(named: "no")
                            let imageView = UIImageView(image: image!)
                            imageView.frame = self.view.frame
                            self.view.addSubview(imageView)
                        }
                    }
                }
            }
    }
  func requestEvents(url:String,isUpcommingEvent:Bool){
        DispatchQueue.global(qos: .background).async {
            if let leagueId = self.myLeague{
                let url = url + leagueId
                NetworkServiceModal.instance.getData(url: url, completion:{(myEvents: EventsModel?,error) in
                    if let myError = error{
                        print(myError)
                    }else{
                        guard let events = myEvents else {return}
                        guard let myEvent = events.events  else { return }
                        if isUpcommingEvent {
                            self.upCommingEvents = myEvent
                        }
                        else{
                            self.events = myEvent }
                        
                    }
                    DispatchQueue.main.async {
                        self.resultsCollection.reloadData()
                        self.upCommingCollection.reloadData()
                        self.indicator.stopAnimating()
                        if (self.events.count == 0 && !isUpcommingEvent || self.upCommingEvents.count == 0 && isUpcommingEvent ) {
                            let image = UIImage(named: "no")
                            let imageView = UIImageView(image: image!)
                            imageView.frame = self.view.frame
                            self.view.addSubview(imageView)
                        }
                    }
                })
            }
            
        }
        
    }
}

extension LeaguesDetialesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func setupCollectionView(){
        teamsCV.delegate = self
        teamsCV.dataSource = self
        resultsCollection.delegate = self
        resultsCollection.dataSource = self
        resultsCollection.register(UINib(nibName: "EventCollectionCell", bundle: nil), forCellWithReuseIdentifier: "EventCollectionCell")
        upCommingCollection.delegate = self
        upCommingCollection.dataSource = self
        upCommingCollection.register(UINib(nibName: "upcommingCollectionCell", bundle: nil), forCellWithReuseIdentifier: "upcommingCollectionCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return upCommingEvents.count
        case 1:
            return events.count
        default:
            if let teams = self.teams{
                return teams.count
            }else{
                return 0
            }
        }
        
    }
    
    func getTeamLogo(id: String) ->String{
        let num = self.teams?.count ?? 0
        for index in 0..<num{
            let team = self.teams![index]
            if(team.idTeam == id){
                return team.strTeamBadge! ?? ""
            }
        }
        return ""
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0 :
            let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcommingCollectionCell", for: indexPath) as! upcommingCollectionCell
            let event = upCommingEvents[indexPath.row]
            eventCell.displayImgs(teamAURL: self.getTeamLogo(id: event.idHomeTeam ?? ""), teamBURL: self.getTeamLogo(id: event.idAwayTeam ?? ""))
            eventCell.displayNames(teamA: event.strHomeTeam ?? "", teamB: event.strAwayTeam ?? "")
            eventCell.displayDateTime(date: event.dateEvent, time: event.strTime)
            eventCell.layer.borderWidth = 2
            eventCell.layer.borderColor = UIColor(named: "light")?.cgColor
            eventCell.layer.cornerRadius = 12
            return eventCell
        case 1:
            let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionCell", for: indexPath) as! EventCollectionCell
            let event = events[indexPath.row]
            eventCell.displayImgs(teamAURL: self.getTeamLogo(id: event.idHomeTeam ?? ""), teamBURL: self.getTeamLogo(id: event.idAwayTeam ?? ""))
            eventCell.displayNames(teamA: event.strHomeTeam ?? "", teamB: event.strAwayTeam ?? "")
            eventCell.displayResults(teamARes: event.intHomeScore, teamBRes: event.intAwayScore)
            eventCell.displayDateTime(date: event.dateEvent, time: event.strTime)
            eventCell.layer.borderWidth = 2
            eventCell.layer.borderColor = UIColor(named: "light")?.cgColor
            eventCell.layer.cornerRadius = 12
            
            return eventCell
        default:
            let teamCell: teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! teamCell
            let team = self.teams![indexPath.row]
            teamCell.updateCell(teamImage: team.strTeamBadge! ?? "")
//            teamCell.layer.borderWidth =  1
//            teamCell.layer.borderColor = UIColor(named: "light")?.cgColor
//            teamCell.layer.cornerRadius = teamCell.frame.size.width/2
//            teamCell.layer.masksToBounds = true
            return teamCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            print("first")
        case 1:
            print("scond")
        default:
            let team = self.teams![indexPath.row]
            //pushToTeamDetailsView(team: team)
        }
    }
    
//    func pushToTeamDetailsView(team: Teams){
//        let teamDetailes = storyboard?.instantiateViewController(withIdentifier: "TeamDetialesViewController") as! TeamDetialesViewController
//        teamDetailes.team = team
//        self.navigationController?.pushViewController(teamDetailes, animated: true)
//    }
//
}
extension LeaguesDetialesViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: collectionView.frame.size.height * 1.2, height: collectionView.frame.size.height - 24)
        
        case 1:
//            return CGSize(width: ((self.view.frame.size.width/2) - 16), height: (self.view.frame.size.width/3))
            return CGSize(width: (collectionView.frame.width) - 26.5 , height: 200)
            
        default:
            return CGSize(width: collectionView.frame.size.width * 0.3, height: collectionView.frame.size.height - 35)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.tag {
        case 3:
            return 24
        default:
            return 8
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
}

