//
//  Sports.swift
//  SportsApp
//
//  Created by ola abaza on 4/21/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import Foundation
struct SportsList: Codable {
    var sports: [Sport]?

}

struct Sport: Codable {
    var sportName: String?
    var sportImg: String?
    
    enum CodingKeys: String, CodingKey {
        case sportName = "strSport"
        case sportImg = "strSportThumb"
    }
}




