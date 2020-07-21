//
//  PokemonViewController.swift
//  PokemonCraigBel
//
//  Created by Craig Belinfante on 7/19/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
    var pokemonController: PokemonController?
    var saveToPS: SavedPokedex?
    var pokemonNames: Pokemon?
    
    @IBOutlet weak var searchforPokemon: UISearchBar!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonAbilities: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBAction func savePokemon(_ sender: UIButton) {
        guard let pokemonController = pokemonController, let pokemonName = pokemonName.text else {return}
        print(pokemonName)
        print(pokemonController)
        guard let savePersistentStore = saveToPS else {return}
        savePersistentStore.saveToPersistentStore()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        getPokemonDetails()
        searchforPokemon.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func getPokemonDetails() {
        guard let pokemonController = pokemonController,
            let names = pokemonNames else { return }
        pokemonController.searchPokemon(for: names) { (result) in
            switch result {
            case .success(let xyz):
                DispatchQueue.main.async {
                    self.updateViews()
                }
                pokemonController.fetchImage(at: xyz.image) { (result) in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.pokemonImage.image = image
                        }
                    }
                }
            case .failure(let error):
                print("Error \(error)")
                
            }
        }
    }
    
    func updateViews() {
        guard let pokemon = pokemonNames else { return }
        title = pokemon.name
        pokemonName.text = pokemon.name
        pokemonID.text = "ID: \(pokemon.id)"
        pokemonType.text = "Type: \(pokemon.types)"
        pokemonAbilities.text = "Abilities: \(pokemon.abilities)"
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let names = pokemonNames else {return}
        guard searchforPokemon.text != nil else {return}
        guard let pokemonAPI = pokemonController else {return}
        pokemonAPI.searchPokemon(for: names) { (result) in
            switch result {
            case .success(let thisResult):
                DispatchQueue.main.async {
                    self.updateViews()
                    print(thisResult)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    /*
     let x : Int = 45
     let xNSNumber = x as NSNumber
     let xString : String = xNSNumber.stringValue
     let characterArray: [Character] = ["J", "o", "h", "n"]
     let string = String(characterArray)
     */
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

