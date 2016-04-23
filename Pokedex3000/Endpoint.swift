//
//  Endpoint.swift
//  Pokedex3000
//
//  Created by Tony DiPerna on 4/22/16.
//  Copyright © 2016 tonydiperna. All rights reserved.
//

import Foundation
import Alamofire

let API = "http://pokeapi.co/api/v2/"
let POKEMON_ENDPOINT = "pokemon"

protocol Endpoint {
    var method: Alamofire.Method { get }
    var endpoint: String { get }
}

extension Endpoint {
    func request(handler: (object: AnyObject?) -> ()) {
        Alamofire.request(method, "\(API)\(endpoint)").responseJSON { (response) -> Void in
            handler(object: response.result.value)
        }
    }
}

enum Pokemon: Endpoint {
    case Pokemen
    case Pokemon(Int)
    
    var method: Alamofire.Method {
        switch self {
        case Pokemen: return .GET
        case Pokemon: return .GET
        }
    }
    
    var endpoint: String {
        switch self {
        case Pokemen: return "/\(POKEMON_ENDPOINT)/"
        case let Pokemon(id): return "/\(POKEMON_ENDPOINT)/\(id)/"
        }
    }
}