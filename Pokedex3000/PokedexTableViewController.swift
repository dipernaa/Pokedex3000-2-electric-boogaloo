//
//  ViewController.swift
//  Pokedex3000
//
//  Created by Tony DiPerna on 4/22/16.
//  Copyright © 2016 tonydiperna. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class PokedexTableViewController: UITableViewController {
    
    var pokemen: [PokemonModel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPokemen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let controller = navigationController.topViewController as! PokemonDetailViewController

        if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
            controller.pokemon = pokemen[indexPath.row]
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemen?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("PokemonCell", forIndexPath: indexPath) as? PokemonCell else {
            fatalError("WAKA WAKA")
        }
        
        let pokemon = pokemen?[indexPath.row]
        
        cell.lblName.text = pokemon?.name!.capitalizedString ?? "Another Pickachu"
        return cell
    }
    
    func loadPokemen() {
        let getPokemen = GetPokemen()
        getPokemen.request { [weak self] (object) -> () in
            guard let object = object as? [String: AnyObject] else { return }
            
            let results = object["results"]
            self?.pokemen = Mapper<PokemonModel>().mapArray(results)
            self?.tableView.reloadData()
            
        }
    }
}

