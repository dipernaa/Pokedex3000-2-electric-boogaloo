//
//  PokemonDetailViewController.swift
//  Pokedex3000
//
//  Created by Tony DiPerna on 4/23/16.
//  Copyright © 2016 tonydiperna. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class PokemonDetailViewController: UIViewController {
    
    var pokemon: PokemonModel?
    var detailedPokemon: PokemonDetailModel?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = pokemon {
            title = item.name!.capitalizedString
            loadDetails(item.url!)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadDetails(url: String) {
        let getByUrl = GetByUrl(withUrl: url)
        getByUrl.request { [weak self] (object) -> () in
            guard let object = object as? [String: AnyObject] else { return }
            
            self?.detailedPokemon = Mapper<PokemonDetailModel>().map(object)
            
            if let height = self?.detailedPokemon?.height {
                self?.lblHeight.text = "\((height/10.0))m"
            }
            if let weight = self?.detailedPokemon?.weight {
                self?.lblWeight.text = "\((weight/10.0))kg"
            }
            
            if let checkedUrl = NSURL(string: (self?.detailedPokemon?.sprite)!) {
                self?.imageView.contentMode = .ScaleAspectFit
                self?.downloadImage(checkedUrl)
            }
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in completion(data: data, response: response, error: error) }.resume()
    }
    
    func downloadImage(url: NSURL){
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                self.imageView.image = UIImage(data: data)
            }
        }
    }

    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}