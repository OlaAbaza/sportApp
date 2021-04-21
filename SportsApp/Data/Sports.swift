//
//  Sports.swift
//  SportsApp
//
//  Created by ola abaza on 4/21/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import Foundation
struct SportsList: Codable {
    let sports: [Sport]?

}

struct Sport: Codable {
    let sportName: String?
    let sportImg: String?
    
    enum CodingKeys: String, CodingKey {
        case sportName = "strSport"
        case sportImg = "strSportThumb"
    }
}




