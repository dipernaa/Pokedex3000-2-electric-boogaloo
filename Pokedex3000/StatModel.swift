//
//  StatModel.swift
//  Pokedex3000
//
//  Created by Tony DiPerna on 4/23/16.
//  Copyright © 2016 tonydiperna. All rights reserved.
//

import Foundation
import ObjectMapper

struct StatModel: Mappable {
    var base: Int?
    var name: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        base <- map["base_stat"]
        name <- map["stat.name"]
    }
}