//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Cody Morley on 4/10/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //call updateViews
    }
   
    func updateViews() {
        nameLabel.text = pokemon?.name
        idLabel.text = String("\(pokemon?.id)")
        
        var imageURL: URL?
        if let imageURLString = pokemon?.sprites.front_default {
            imageURL = URL(string: imageURLString)!
        }
            
        do {
            let imageData = try Data(contentsOf: imageURL!)
            let image = UIImage(data: imageData)
            imageView.image = image
        } catch {
            print("error loading image \(error) \(error.localizedDescription)")
        }
        
        var typeNames: [String] = []
        
        for type in pokemon?.types.count {
            typeNames.append(pokemon?.types[type].type.name)
        }
        
        var typesString = typeNames.joined(separator: ", ")
        typesLabel.text = typesString
        
    }

}
