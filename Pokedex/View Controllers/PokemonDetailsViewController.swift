//
//  PokemonDetailsViewController.swift
//  Pokédex
//
//  Created by Jason Modisett on 9/14/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController, UISearchBarDelegate {

    // MARK:- View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        searchBar.setTextColor(color: .white)
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isUserSearching { searchBar.becomeFirstResponder() }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // Private UI updater method
    private func updateViews() {
        guard let pokémonController = pokémonController else { return }
        
        searchBar.alpha = isUserSearching ? 1 : 0
        headerTitle.alpha = isUserSearching ? 0 : 1
        
        guard let pokémon = pokémon else {
            pokemonContainer.alpha = 0
            saveButton.alpha = 0
            return
        }
        
        headerTitle.text = pokémon.name.uppercased()
        headerTitle.kern(0.4)
        pokemonContainer.alpha = 1
        saveButton.alpha = 1
        
        let saveButtonTitle = pokémonController.savedPokémon.contains(pokémon) ? "REMOVE FROM POKÉDEX" : "SAVE TO POKÉDEX!"
        saveButton.setTitle(saveButtonTitle, for: .normal)
        
        pokemonNameLabel.text = pokémon.name.capitalizingFirstLetter()
        pokemonIDLabel.text = "ID: \(pokémon.id)"
        
        let abilities = pokémon.abilities.map { $0.ability.name }
        var abilitiesString = ""
        for i in abilities { abilitiesString.append("\(i), ") }
        abilitiesString.removeLast(2)
        pokemonAbilitiesLabel.text = abilitiesString
        
        let types = pokémon.types.map { $0.type.name }
        var typesString = ""
        for i in types { typesString.append("\(i), ") }
        typesString.removeLast(2)
        pokemonTypesLabel.text = typesString
        
        let imageManager = ImageCacheManager()
        
        imageManager.fetchImage(url: URL(string: pokémon.sprites.frontDefault)!, completion: { image in
            if let image = image {
                DispatchQueue.main.async { self.imageView.image = image }
            }
        })
    }
    
    
    // MARK:- UISearchBarDelegate methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
        guard let pokémonController = pokémonController,
              let searchText = searchBar.text else { return }
        
        pokémonController.searchForPokémon(with: searchText) { (error) -> (Void) in
            if let error = error {
                NSLog("Error searching for Pokémon: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.pokémon = pokémonController.matchedPokémon
                self.updateViews()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchText == " " { view.endEditing(true) }
    }
    
    // MARK:- IBActions
    @IBAction func saveToPokedex(_ sender: Any) {
        guard let pokémonController = pokémonController else { return }
        
        pokémonController.addMatchToPokédex { (error) -> (Void) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func goBackWasPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Properties & types
    var pokémon: Pokémon?
    var pokémonController: PokémonController?
    var isUserSearching: Bool = true

    // MARK:- IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var pokemonContainer: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    // Pokémon details
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
}
