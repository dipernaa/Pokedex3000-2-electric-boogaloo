//
//  TypeModel.swift
//  Pokedex3000
//
//  Created by Tony DiPerna on 4/23/16.
//  Copyright © 2016 tonydiperna. All rights reserved.
//

import Foundation
import ObjectMapper

struct TypeModel: Mappable {
    var slot: Int?
    var name: String?
    var url: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        slot <- map["slot"]
        name <- map["type.name"]
        url <- map["type.url"]
    }
}