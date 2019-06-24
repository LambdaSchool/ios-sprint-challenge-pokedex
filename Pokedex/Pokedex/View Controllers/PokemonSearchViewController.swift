//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Stephanie Bowles on 6/2/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    @IBOutlet weak var spriteView: UIImageView!
    
    @IBOutlet weak var pokeIDLabel: UILabel!
    @IBOutlet weak var pokeTypesLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var stackLabelFrame: UIView!
    @IBOutlet weak var spriteFrameView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    var pokemonController : PokemonController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        pokeNameLabel.text = ""
        saveButton.setTitle("", for: .normal)
        setUpAppearances()
        updateViews()
        // Do any additional setup after loading the view.
    }
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    func updateViews() {
        guard let pokemon = pokemon else {return}
        pokeNameLabel.text = pokemon.name.capitalized
        let id = String(pokemon.id)
        pokeIDLabel.text = "ID: \(id)"
        let type: [String] = pokemon.types.map { $0.type.name }
        pokeTypesLabel.text = "Type(s): \(type.joined(separator: ", "))"
        let abilities: [String] = pokemon.abilities.map { $0.ability.name }
        abilitiesLabel.text = "Abilities: \(abilities.joined(separator: "\n"))"
        guard let url = URL(string: pokemon.sprites.front_default),
            let pokemonImageData = try? Data(contentsOf: url) else { return }
        spriteView.image = UIImage(data: pokemonImageData)
        saveButton.setTitle("Save Pokemon", for: .normal)
        showResultAppearances()
        
        
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        pokemonController?.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
  
    
  
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        print("Search clicked")
        
        pokemonController?.fetchPokemon(for: searchTerm, completion: { (result, error) in
            if error != nil {
                NSLog("Error searching for: \(String(describing: error))")
            }
            self.pokemon = result
            DispatchQueue.main.async {
                self.updateViews()
                self.searchBar.text = ""
            }
        })
        
        
    }
    
    private func setUpAppearances() {
        view.backgroundColor = .black
        
    }
    private func showResultAppearances() {
        spriteView.backgroundColor = .white
        spriteView.layer.cornerRadius = 5.0
        spriteFrameView.backgroundColor = .gray
        spriteFrameView.layer.borderColor = UIColor.gray.cgColor
        spriteFrameView.layer.borderWidth = 20.0
        spriteFrameView.layer.cornerRadius = 10.0
        
        stackLabelFrame.backgroundColor = AppearanceHelper.pokeRed
        stackLabelFrame.layer.cornerRadius = 10.0
        
        pokeNameLabel.backgroundColor = AppearanceHelper.pokeRed
        pokeNameLabel.textColor = #colorLiteral(red: 0.9372316741, green: 0.9406467823, blue: 0.9562381028, alpha: 1)
        
        pokeIDLabel.textColor = #colorLiteral(red: 0.9372316741, green: 0.9406467823, blue: 0.9562381028, alpha: 1)
        pokeIDLabel.backgroundColor = AppearanceHelper.pokeRed
        pokeIDLabel.layer.cornerRadius = 10.0
        
        pokeTypesLabel.textColor = #colorLiteral(red: 0.9372316741, green: 0.9406467823, blue: 0.9562381028, alpha: 1)
        pokeTypesLabel.backgroundColor = AppearanceHelper.pokeRed
        pokeTypesLabel.layer.cornerRadius = 10.0
        
        abilitiesLabel.textColor = #colorLiteral(red: 0.9372316741, green: 0.9406467823, blue: 0.9562381028, alpha: 1)
        abilitiesLabel.backgroundColor = AppearanceHelper.pokeRed

        saveButton.backgroundColor = AppearanceHelper.pokeBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 30
    }
 
}
