//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Craig Belinfante on 1/4/21.
//

import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    //Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonAbilities: UILabel!
    @IBOutlet weak var saveButtonLabel: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        if pokemon != nil {
            searchBar.isHidden = true
            saveButtonLabel.isHidden = true
            updateViews()
        }
    }
    
    //Save Action
    @IBAction func savePokemonButtonPressed(_ sender: UIButton) {
        guard let pokemon = pokemon, let pokemonController = pokemonController else {return}
        pokemonController.pokemonList.append(pokemon)
        print("saved: \(pokemon)")
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        
        if let pokemon = pokemon {
            
            DispatchQueue.main.async {
                self.pokemonNameLabel.text = pokemon.name.capitalized
                self.pokemonID.text = "\(pokemon.id)"
                self.pokemonType.text = "\(pokemon.types.joined(separator: ", "))"
                self.pokemonAbilities.text = "\(pokemon.ability.joined(separator: ", "))"
                
                let url = URL(string: "\(pokemon.image)")!
                if let data = try? Data(contentsOf: url) {
                    self.pokemonImage.image = UIImage(data: data)
                }
            }
        } else {
            DispatchQueue.main.async {
                self.pokemonNameLabel.isHidden = true
                self.pokemonID.isHidden = true
                self.pokemonType.isHidden = true
                self.pokemonAbilities.isHidden = true
                self.pokemonImage.isHidden = true
                self.idLabel.isHidden = true
                self.typeLabel.isHidden = true
                self.abilityLabel.isHidden = true
                self.saveButtonLabel.isHidden = true
            }
        }
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchBar.resignFirstResponder()
        guard let pokemonController = pokemonController else { return }
        pokemonController.fetchPokemon(with: searchText) { (result) in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
            }
        }        
    }
}

