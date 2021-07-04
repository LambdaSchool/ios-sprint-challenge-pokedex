//
//  PokemonDetailViewController.swift
//  Pokedex Challenge
//
//  Created by Michael Flowers on 1/25/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {

    //MARK: - Properties
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    var pokemonController: PokemonController?
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var types: UILabel!
    @IBOutlet weak var abilities: UILabel!
    @IBOutlet weak var saveButtonProperties: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set the searchBar delegate
       searchBar.delegate = self
    }
    
    //when user taps cell, updateViews when the view will appear again.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    //MARK: - PokemonController functions
    @IBAction func savePokemon(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //search bar delegate function
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //fetch the pokemon
        
        guard let name = searchBar.text, !name.isEmpty else { return }
        pokemonController?.fetchPokemon(with: name, completion: { (error) in
            if let error = error {
                NSLog("Error fetching the pokemon from searchBar: \(error.localizedDescription)")
                return
            }
            //this is where we append it to the array
            DispatchQueue.main.async {
                self.updateViews()
                //I have to display the ui here.
            }
        })
    }

    //MARK: - Custom Functions
    func updateViews(){
        guard let passedInPoke = pokemon else {
            
            //no pokemon was passed in
            pokemonName.isHidden = true
            id.isHidden = true
            types.isHidden = true
            abilities.isHidden = true
            saveButtonProperties.isHidden = true
            title = "Pokemon Search"
            return
        }
        
        //pokemon was passed in
        searchBar.isHidden = true
        saveButtonProperties.isHidden = true
        pokemonName.text = passedInPoke.name
        id.text = String(passedInPoke.id)
        title = passedInPoke.name
//        let stringTypes = passedInPoke.types.fl
//        let a = stringTypes.joinwithSeparator(",")
//        types.text = passedInPoke.types
        
        
    }
}
