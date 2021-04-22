//
//  Leagues.swift
//  SportsApp
//
//  Created by Norhan on 4/21/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import Foundation

struct LeaguesModel : Codable {
    let leagues : [Leagues]?

    enum CodingKeys: String, CodingKey {

        case leagues = "leagues"
    }
}

struct Leagues : Codable {
    
    let idLeague : String?
    let strLeague : String?
    let strSport : String?

    enum CodingKeys: String, CodingKey {

        case idLeague = "idLeague"
        case strLeague = "strLeague"
        case strSport = "strSport"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idLeague = try values.decodeIfPresent(String.self, forKey: .idLeague)
        strLeague = try values.decodeIfPresent(String.self, forKey: .strLeague)
        strSport = try values.decodeIfPresent(String.self, forKey: .strSport)
    }
    init(){
        idLeague = ""
        strLeague = ""
        strSport = ""
    }

}

class LeaguesInfoModel: NSObject {
    public var info: Leagues = Leagues()
    public var moreInfo: LeaguesDetailes = LeaguesDetailes()
    public var youTubeID: String?
}
