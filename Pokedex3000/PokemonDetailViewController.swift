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
    
    @IBOutlet weak var defaultView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblPlaceholder: UILabel!
    
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
            
            let goodX = (self?.lblPlaceholder.frame.origin.x)!
            let goodSpacing = (self?.lblWeight.frame.origin.y)! - (self?.lblHeight.frame.origin.y)!
            var rollingY = (self?.lblWeight.frame.origin.y)! + (self?.lblHeight.frame.height)!

            if let stats = self?.detailedPokemon?.stats {
                rollingY = rollingY + (self?.lblPlaceholder.frame.height)!
                let label = UILabel(frame: CGRectMake(goodX, rollingY, (self?.view.frame.width)!, 21))
                label.textAlignment = NSTextAlignment.Left
                label.attributedText = self?.createUnderline("Stats")
                self?.defaultView.addSubview(label)
                rollingY = rollingY + label.frame.height
                
                for stat in stats {
                    let label = UILabel(frame: CGRectMake(goodX, rollingY, (self?.view.frame.width)!, 21))
                    label.textAlignment = NSTextAlignment.Left
                    label.text = "\(stat.name!.capitalizedString): \(stat.base!)"
                    self?.defaultView.addSubview(label)
                    rollingY = rollingY + goodSpacing
                }
            }
            
            if let types = self?.detailedPokemon?.types {
                types.sort {
                    return $0.slot > $1.slot
                }
                
                rollingY = rollingY + (self?.lblPlaceholder.frame.height)!
                let label = UILabel(frame: CGRectMake(goodX, rollingY, (self?.view.frame.width)!, 21))
                label.textAlignment = NSTextAlignment.Left
                label.attributedText = self?.createUnderline("Types")
                self?.defaultView.addSubview(label)
                rollingY = rollingY + label.frame.height
                
                for type in types {
                    let label = UILabel(frame: CGRectMake(goodX, rollingY, (self?.view.frame.width)!, 21))
                    label.textAlignment = NSTextAlignment.Left
                    label.text = "\(type.name!.capitalizedString)"
                    self?.defaultView.addSubview(label)
                    rollingY = rollingY + goodSpacing
                }
            }
            
            
            if let abilities = self?.detailedPokemon?.abilities {
                abilities.sort {
                    return $0.slot > $1.slot
                }
                
                rollingY = rollingY + (self?.lblPlaceholder.frame.height)!
                let label = UILabel(frame: CGRectMake(goodX, rollingY, (self?.view.frame.width)!, 21))
                label.textAlignment = NSTextAlignment.Left
                label.attributedText = self?.createUnderline("Abilities")
                self?.defaultView.addSubview(label)
                rollingY = rollingY + label.frame.height
                
                for ability in abilities {
                    let label = UILabel(frame: CGRectMake(goodX, rollingY, (self?.view.frame.width)!, 21))
                    label.textAlignment = NSTextAlignment.Left
                    label.text = "\(ability.name!.capitalizedString)"
                    self?.defaultView.addSubview(label)
                    rollingY = rollingY + goodSpacing
                }
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
    
    func createUnderline(label: String) -> NSAttributedString {
        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
        return NSAttributedString(string: "\(label)", attributes: underlineAttribute)
    }

    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}