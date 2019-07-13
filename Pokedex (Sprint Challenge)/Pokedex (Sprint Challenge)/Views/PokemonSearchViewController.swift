//
//  PokemonSearchViewController.swift
//  Pokedex (Sprint Challenge)
//
//  Created by Nathan Hedgeman on 7/12/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    //Properties
    var pokemon: Pokemon?
    var pokemonController: PokemonController?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    //Labels
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idDetailsLabel: UILabel!
    
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var typeDetailsLabel: UILabel!
    
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var abilityDetailsLabel: UILabel!
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initialView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    //Handles searching and updating the UI with an Image and filled out lables
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let searchPoke = searchBar.text else { return }
        
        pokemonController?.searchForPokemon(pokemonName: searchPoke, completion: { (result) in
            
            if let pokemonSearched = try? result.get() {
                
                //Gives a value to the controller view's optional "pokemon" property
                self.pokemon = pokemonSearched
                
                DispatchQueue.main.async {
                    self.updateViews(with: pokemonSearched)
                }
            }
        })
        
        //Unwarped the controller views pokemon property to be used to fetch the image
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
            
            guard let pokemon = pokemon else { return }
            pokemonController?.pokemonList.append(pokemon)
            navigationController?.popViewController(animated: true)
        
    }
    
    func updateViews(with pokemon: Pokemon) {
        
        saveButton.alpha = 1
        
        self.nameLabel.text = pokemon.name
        
        self.idLabel.text = "ID:"
        self.idDetailsLabel.text = "\(pokemon.id)"
        
        self.typesLabel.text = "Type:"
        self.typeDetailsLabel.text = pokemon.types.first?.type.name
        
        
        self.abilityLabel.text = "Abilities:"
        self.abilityDetailsLabel.text = pokemon.abilities.first?.ability.name
        
        pokemonController?.fetchImage(at: pokemon.sprites.frontDefault, completion: { (imageResult) in
            if let image = try? imageResult.get() {
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
                
            }
        })
    }
    
    func initialView() {
        let x = ""
        idLabel.text = x
        idDetailsLabel.text = x
        typesLabel.text = x
        typeDetailsLabel.text = x
        abilityLabel.text = x
        abilityDetailsLabel.text = x
        nameLabel.text = x
        
        saveButton.alpha = 0
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //let searchVC = segue.destination as? PokemonTableViewController
        
        
        // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
    
    
}
