//
//  PokemonDetailModel.swift
//  Pokedex3000
//
//  Created by Tony DiPerna on 4/23/16.
//  Copyright © 2016 tonydiperna. All rights reserved.
//

import Foundation
import ObjectMapper

struct PokemonDetailModel: Mappable {
    var id: Int?
    var name: String?
    var weight: Double?
    var height: Double?
    var sprite: String?
    var abilities: [AbilityModel]?
    var stats: [StatModel]?
    var types: [TypeModel]?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        weight <- map["weight"]
        height <- map["height"]
        sprite <- map["sprites.front_default"]
        abilities <- map["abilities"]
        stats <- map["stats"]
        types <- map["types"]
    }
}