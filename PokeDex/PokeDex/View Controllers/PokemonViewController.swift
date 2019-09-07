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
    
    var apiController: APIController?
    
    var pokemon: User?{
        didSet{
            updateViews()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        SetViews()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    func SetViews(){
        savePokemonButton.isHidden = true
        guard pokemon != nil else {return}
        searchBar.isHidden = true
    }
    
    func updateViews(){
       
        
        guard let pokemon = apiController?.users else {return}
        
        idLabel.text = ""
        nameLabel.text = ""
        idLabel.text = String(pokemon.id)
        nameLabel.text = pokemon.name.capitalized
        
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
        print(abilities)
        abilitiesLabel.text = abilities
        
        if let image = try? Data(contentsOf: pokemon.sprites.frontDefault) {
            imageView.image = UIImage(data: image)
        }
        
    }
    
    @IBAction func savePokemon(_ sender: UIButton) {
        savePokemon()
    }
    
    func savePokemon(){
        guard let pokemon = pokemon else {return}
        APIController.apiController.pokemon.append(pokemon)
    }

        
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        
        
        apiController?.searchForPokemon(with: searchTerm) {_ in
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



