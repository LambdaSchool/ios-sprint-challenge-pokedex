//
//  PokeDetailViewController.swift
//  Pokedex
//
//  Created by Madison Waters on 12/9/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class PokeDetailViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateViews()
    }
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    var pokedex: [Pokemon] = [] {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var spriteImage: UIImageView!
    
    @IBAction func save(_ sender: Any) {
        self.updateViews()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        searchBar.text = ""
        
            Pokedex.searchForPokemon(with: searchTerm.lowercased()) { (pokedex, error) in
                if let error = error {
                    NSLog("Error fetching Pokemon: \(error)")
                    
                DispatchQueue.global().async {
                    guard let pokemon = self.pokemon else { return }
                    Model.shared.addPokemon(pokemon: pokemon)
                    
                    self.pokedex = Model.shared.pokedex
                    self.updateViews()
                    print("1: \(Model.shared.pokedex)")
                    return
                }
                //self.pokedex = Model.shared.pokedex
                //self.updateViews()
                print("2: \(Model.shared.pokedex)")
            }
//            self.pokedex = Model.shared.pokedex
//            self.updateViews()
            print("3: \(Model.shared.pokedex)")
        }
        self.updateViews()
        print("4")
        
    }
    
    func updateViews() {
        guard let pokemon = pokemon,
            isViewLoaded else { return }
        
        navigationItem.title = pokemon.name
        nameLabel.text = "Front view of \(pokemon.name.capitalized)"
        idLabel.text = "Id: \(pokemon.id)"
        
        let abilities = pokemon.abilities.map { $0.ability.name }
        var abilityString = ""
        for index in abilities { abilityString.append("\(index) ") }
        abilitiesLabel.text = "Abilities: \(abilityString) "
        
        let types = pokemon.types.map {$0.type.name}
        var typeString = ""
        for index in types { typeString.append("\(index) ") }
        typesLabel.text = "Types: \(typeString) "
        
        let urlToImage = pokemon.sprites.frontDefault
        let imageURL = URL(string: urlToImage)!
        spriteImage.load(url: imageURL)
        
    }
}
