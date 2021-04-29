//
//  Teams.swift
//  SportsApp
//
//  Created by ola abaza on 4/23/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import Foundation

struct Teams : Codable {
    
    let idTeam : String?
    let strTeam : String?
    let strTeamShort : String?
    let strAlternate : String?
    let intFormedYear : String?
    let strSport : String?
    let strWebsite : String?
    let strFacebook : String?
    let strTwitter : String?
    let strInstagram : String?
    let strDescriptionEN : String?
    let strGender : String?
    let strCountry : String?
    let strTeamBadge : String?
    let strTeamJersey : String?
    let strTeamLogo : String?
    let strTeamBanner : String?
    let strYoutube : String?


}
struct TeamModel : Codable {
    let teams : [Teams]?

}
