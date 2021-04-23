//
//  URLs.swift
//  SportsApp
//
//  Created by ola abaza on 4/21/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import Foundation

enum URLs : String {
    case getSportsListURL = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
    case legueNameUrl = "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php"
    case lequeDetailsUrl = "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id="
    case getEventDetailsUrl = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="
    case getUpcommingEventUrl =
"https://www.thesportsdb.com/api/v1/json/1/eventsround.php?r=38&s=2020-2021&id="
    case getTeamUrl = "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l="
    case TeamDetailsIDUrl = "https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id="
}
