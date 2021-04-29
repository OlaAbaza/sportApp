//
//  MockNetworkManger.swift
//  unitTestingDay2Tests
//
//  Created by ola abaza on 4/22/21.
//


import Foundation
@testable import SportsApp

class MockNetworkManager{
    
    
    var shouldReturnError : Bool
    
    init(shouldReturnError : Bool) {
        
        self.shouldReturnError = shouldReturnError
    }
    
    var error : Error!
  
    
    let mockSportsJSONResponse = [ "sports":[
              
        [
                 "idSport":"102",
                 "strSport":"Soccer",
                 "strFormat":"TeamvsTeam",
                 "strSportDescription":"Association football, more commonly known as football or soccer, is a team sport played between two teams of eleven players with a spherical ball. It is played by 250 million players in over 200 countries and dependencies, making it the world's most popular sport. The game is played on a rectangular field with a goal at each end. The object of the game is to score by getting the ball into the opposing goal.\r\n\r\nPlayers are not allowed to touch the ball with their hands or arms while it is in play, unless they are goalkeepers (and then only when within their penalty area). Other players mainly use their feet to strike or pass the ball, but may also use any part of their body except the hands and the arms. The team that scores the most goals by the end of the match wins. If the score is level at the end of the game, either a draw is declared or the game goes into extra time or a penalty shootout depending on the format of the competition. The Laws of the Game were originally codified in England by The Football Association in 1863. Association football is governed internationally by the International Federation of Association Football (FIFA; French: Fédération Internationale de Football Association), which organises World Cups for both men and women every four years."
              ],
              [
                 "idSport":"105",
                 "strSport":"Baseball",
                 "strFormat":"TeamvsTeam",
                 "strSportDescription":"Baseball is a bat-and-ball game played between two teams of nine players each who take turns batting and fielding. The batting team attempts to score runs by hitting a ball (that is thrown by the opposing team's pitcher) with a bat swung by the batter, and then running counter-clockwise around a series of four bases: first, second, third, and home plate. A run is scored when a player advances around the bases and touches home plate.\r\n\r\nPlayers on the batting team take turns hitting against the pitcher of the fielding team, which tries to prevent runs by getting hitters out in any of several ways. A player on the batting team who reaches a base safely can later attempt to advance to subsequent bases during teammates' turns batting, such as on a hit or by other means. The teams switch between batting and fielding whenever the fielding team records three outs. One turn batting for both teams, beginning with the visiting team, constitutes an inning. A game is composed of nine innings, and the team with the greater number of runs at the end of the game wins. If scores are tied at the end of nine innings, extra innings are usually played. Baseball has no game clock, although most games end in the ninth inning.\r\n\r\nBaseball evolved from older bat-and-ball games already being played in England by the mid-18th century. This game was brought by immigrants to North America, where the modern version developed. By the late 19th century, baseball was widely recognized as the national sport of the United States. Baseball is currently popular in North America and parts of Central and South America, the Caribbean, and East Asia, particularly in Japan, South Korea, and Taiwan."
              ]
            ]
]

enum ResponseError : Error {
    case responseWithError
}


    
func getSports(url: String, completion: @escaping (SportsList?, Error?) -> ()) {
        
        
        var sports : SportsList!
        
        
        do{
            
            let sportData = try JSONSerialization.data(withJSONObject: mockSportsJSONResponse, options: .fragmentsAllowed)
            
            
            sports = try JSONDecoder().decode(SportsList.self, from: sportData)
       
            
        }catch let error{
            
            print(error.localizedDescription)
            
        }
        
        
        if shouldReturnError{
            
            completion(nil , ResponseError.responseWithError)
            
        }else{
           // print(movies)
            completion(sports , nil)
        }
       
        
        
    }
    
    
    
}

