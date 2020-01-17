//
//  DetailViewController.swift
//  PokeDex
//
//  Created by Kenny on 1/17/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var pokemon: Pokemon?
    var searchedPokemon: Pokemon? {
        didSet {
            updateUI()
        }
    }
    var pokemonController: PokemonTrainer?
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        print("tapped")
    }
    //pokemon var with didset to
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupViews()
    }

    func setupViews() {
        if pokemon == nil {
            nameLabel.isHidden = true
            idLabel.isHidden = true
            typesLabel.isHidden = true
            abilitiesLabel.isHidden = true
            saveButton.isHidden = true
            saveButton.isUserInteractionEnabled = false
        }
        
        updateUI()
    }
    
    func updateUI() {
        guard let pokemon = searchedPokemon else {return}
        if nameLabel.isHidden { //if this is hidden, so are other elements
            nameLabel.isHidden = false
            idLabel.isHidden = false
            typesLabel.isHidden = false
            abilitiesLabel.isHidden = false
            saveButton.isHidden = false
            saveButton.isUserInteractionEnabled = true
            //TODO: Hide save button if pokemon is in saved List
            //        saveButton.isHidden = true
            //        saveButton.isUserInteractionEnabled = false
        }
        
        //fill in UI elements
        title = pokemon.name
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = "Types: \(prettyPrintTypes(typeArray: pokemon.types))"
        abilitiesLabel.text = "Abilities: \(prettyPrintAbilities(abilitiesArray: pokemon.abilities))"
        let imageUrl = URL(string: pokemon.picture.url)
        pokemonController?.getPokemonPicture(url: imageUrl, completion: { (pictureData) in
            guard let pictureData = pictureData else {
                print("no picture data")
                return
            }
            let image = UIImage(data: pictureData)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        })
    }
    
    func prettyPrintTypes(typeArray: [Types]) -> String {
        var returnString = ""
        for (index, value) in typeArray.enumerated() {
            if index < typeArray.count - 1 {
                returnString.append("\(value.type.name), ")
            } else {
                returnString.append(value.type.name)
            }
        }
        return returnString
    }
    
    func prettyPrintAbilities(abilitiesArray: [Abilities]) -> String {
        var returnString = ""
        for (index, value) in abilitiesArray.enumerated() {
            if index < abilitiesArray.count - 1 {
                returnString.append("\(value.ability.name), ")
            } else {
                returnString.append(value.ability.name)
            }
        }
        return returnString
    }
    
    func getPokemonFromUrl(url: String) {
        let url = URL(string: url)
        print(url)
        pokemonController?.getPokemonFromURL(url: url) { (pokemon) in
            print(pokemon)
            guard let pokemon = pokemon else {return}
            DispatchQueue.main.async {
                self.searchedPokemon = pokemon
                self.searchBar.resignFirstResponder()
            }
        }
    }
    
}

extension DetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("clicked")
        guard let searchText = searchBar.text,
            searchText != "",
            let pokeDataArray = pokemonController?.pokeDataArray
        else {return}
        for pokemonData in pokeDataArray {
            if pokemonData.name == searchText {
                print(pokemonData.url)
                getPokemonFromUrl(url: pokemonData.url)
            }
        }
    }
}

