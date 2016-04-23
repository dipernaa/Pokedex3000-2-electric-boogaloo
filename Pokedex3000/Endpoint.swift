//
//  Endpoint.swift
//  Pokedex3000
//
//  Created by Tony DiPerna on 4/22/16.
//  Copyright © 2016 tonydiperna. All rights reserved.
//

import Foundation
import Alamofire

let API = "http://pokeapi.co/api/v2"
let POKEMON_ENDPOINT = "pokemon"

protocol Endpoint {
    var endpoint: String { get }
}

extension Endpoint {
    func request(handler: (object: AnyObject?) -> ()) {
        Alamofire.request(Alamofire.Method.GET, "\(endpoint)").responseJSON { (response) -> Void in
            handler(object: response.result.value)
        }
    }
}

class GetByUrl: Endpoint {
    var endpoint = ""
    
    init(withUrl url: String) {
        endpoint = url
    }
}

class GetPokemen: Endpoint {
    var endpoint = "\(API)/\(POKEMON_ENDPOINT)/?limit=1000"
}