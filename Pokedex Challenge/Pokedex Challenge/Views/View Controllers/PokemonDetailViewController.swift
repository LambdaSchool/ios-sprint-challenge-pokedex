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
        //putpokemon in the array to be displayed on the tableViewController
    }
    
    //search bar delegate function
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //fetch the pokemon
    }

    //MARK: - Custom Functions
    func updateViews(){
        guard let passedInPoke = pokemon else {
            
            //no pokemon was passed in
            title = "Pokemon Search"
            searchBar.isHidden = true
            saveButtonProperties.isHidden = true
            return
        }
        
        //pokemon was passed in
        pokemonName.text = passedInPoke.name
        id.text = String(passedInPoke.id)
//        let stringTypes = passedInPoke.types.fl
//        let a = stringTypes.joinwithSeparator(",")
//        types.text = passedInPoke.types
        
        
    }
}
