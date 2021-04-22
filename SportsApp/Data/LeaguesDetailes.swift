//
//  LeaguesDetailesModel.swift
//  SportsApp
//
//  Created by Norhan on 4/21/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import Foundation


struct LeaguesDetailesModel:  Codable {
    let leagues : [LeaguesDetailes]?

    enum CodingKeys: String, CodingKey {

        case leagues = "leagues"
    }

}

struct LeaguesDetailes : Codable {
    
    let strLeague : String?
    let strYoutube : String?
    let strBadge : String?
    

    enum CodingKeys: String, CodingKey {

        case strLeague = "strLeague"
        case strYoutube = "strYoutube"
        case strBadge = "strBadge"
    
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        strLeague = try values.decodeIfPresent(String.self, forKey: .strLeague)
        strYoutube = try values.decodeIfPresent(String.self, forKey: .strYoutube)
        strBadge = try values.decodeIfPresent(String.self, forKey: .strBadge)
        
    }
    init(){
         
         strLeague = ""
         strYoutube = ""
         strBadge = ""
         
    }

}

