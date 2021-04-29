//
//  FavoriteModel.swift
//  SportsApp
//
//  Created by ola abaza on 4/28/21.
//  Copyright © 2021 Norhan. All rights reserved.
//

import Foundation

struct FavoriteModel {
    var id: String?
    var name: String?
    var image: String?
    var youtubeUrl: String?
    
    init(id: String, name: String, image: String, youtubeUrl: String) {
        self.id = id
        self.name = name
        self.image = image
        self.youtubeUrl = youtubeUrl
    }
}
