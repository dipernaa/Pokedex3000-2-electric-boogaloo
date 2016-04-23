//
//  PokemonDetailViewController.swift
//  Pokedex3000
//
//  Created by Tony DiPerna on 4/23/16.
//  Copyright © 2016 tonydiperna. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: PokemonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = pokemon {
            title = item.name
            loadDetails(item.url!)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadDetails(url: String) {
        let getByUrl = GetByUrl(withUrl: url)
        getByUrl.request { [weak self] (object) -> () in
            guard let object = object as? [String: AnyObject] else {
                return
            }
            
            let results = object["results"]
            self?.pokemen = Mapper<PokemonModel>().mapArray(results)
        }
    }

    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}