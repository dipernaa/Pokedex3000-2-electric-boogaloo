//
//  ViewController.swift
//  Pokedex3000
//
//  Created by Tony DiPerna on 4/22/16.
//  Copyright © 2016 tonydiperna. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var pokemen: [PokemonModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemen?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("PokemonCell", forIndexPath: indexPath) as? PokemonCell else {
            fatalError("THIS SHOULD NEVER HAPPEN")
        }
        
        let pokemon = pokemen?[indexPath.row]
        
        cell.lblNumber.text = pokemon?.number ?? "lol"
        cell.lblName.text = pokemon?.name ?? "Another Pickachu"
        return cell
    }
    
    func loadRoutes() {
        let getRoutes = GetRoutes()
        getRoutes.request { [weak self] (object) -> () in
            guard let object = object as? [String: AnyObject] else {
                return
            }
            
            let results = object["bustime-response"]!["routes"]
            print(results)
            self?.routes = Mapper<RouteModel>().mapArray(results)
            self?.tableView.reloadData()
            
        }
    }
}

