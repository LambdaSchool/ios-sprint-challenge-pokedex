//
//  PokemonViewController.swift
//  PokeDex
//
//  Created by William Chen on 9/6/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var savePokemonButton: UIButton!
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var types: UILabel!
    
    @IBOutlet weak var abilities: UILabel!
    
    let apiController = APIController()
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.isHidden = true
        idLabel.isHidden = true
        typesLabel.isHidden = true
        abilitiesLabel.isHidden = true
        savePokemonButton.isHidden = true
        id.isHidden = true
        types.isHidden = true
        abilities.isHidden = true
        searchBar.delegate = self
 
        // Do any additional setup after loading the view.
    }
    
    func updateViews(){
        nameLabel.isHidden = false
        idLabel.isHidden = false
        typesLabel.isHidden = false
        abilitiesLabel.isHidden = false
        savePokemonButton.isHidden = false
        id.isHidden = false
        types.isHidden = false
        abilities.isHidden = false
        
        guard let pokemon = apiController.users else {return}
        
        idLabel.text = String(pokemon.id)
        nameLabel.text = pokemon.name
        
        var types = ""
        let typeArray = pokemon.types
        
        for type in typeArray {
            types.append("\(type.type.name)")
            types.append("\n")
        }
        
        typesLabel.text = types
        
        var abilities = ""
        let abilityArray = pokemon.abilities
        
        for ability in abilityArray {
            abilities.append("\(ability.ability.name)")
            abilities.append("\n")
        }
        abilitiesLabel.text = abilities
        
        if let image = try? Data(contentsOf: pokemon.sprites.front_default) {
            imageView.image = UIImage(data: image)
        }
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        
        
        apiController.searchForPokemon(with: searchTerm) {_ in
            DispatchQueue.main.async {
                self.updateViews()
            }
            
        }
    }
    
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


