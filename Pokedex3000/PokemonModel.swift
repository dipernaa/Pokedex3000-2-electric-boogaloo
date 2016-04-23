//
//  PokemonModel.swift
//  Pokedex3000
//
//  Created by Tony DiPerna on 4/22/16.
//  Copyright © 2016 tonydiperna. All rights reserved.
//

import Foundation
import ObjectMapper

struct PokemonModel: Mappable {
    var name: String?
    var url: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        url <- map["url"]
    }
}