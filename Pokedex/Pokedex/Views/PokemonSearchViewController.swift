//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Angel Buenrostro on 1/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController: PokemonController?
    var searchBool: Bool = false
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                print("This is the didSet func: \(self.pokemon?.name ?? "none")")
                self.updateViews()
                
            }
        }
    }
    
//    var pokes : [Pokemon] = []
    
    
    @IBOutlet weak var search: UISearchBar!
    
    @IBOutlet weak var buttonText: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var spriteImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let pokemon = self.pokemonController!.pokemon else {
            print("There is no pokemon to save")
            return }
        pokemonController?.pokes.append(pokemon)
        let encoder = JSONEncoder()
        let pokeData = pokemonController
        if let encoded = try? encoder.encode(pokeData) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "pokemon")
        }
        print("Name of pokemon in pokes: \(pokemonController?.pokes[0].name ?? "none")")
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        DispatchQueue.main.async {
            self.searchBarSearchButtonClicked(self.search)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            print("Current Pokemon is : \(self.pokemon?.name ?? "none")")
            self.updateViews()
        }
    }
    
    func searchBarSearchButtonClicked(_ search: UISearchBar) {
        searchBool = true
        guard let searchTerm = search.text, !searchTerm.isEmpty else { return }
        
        pokemonController?.searchPokemon(searchTerm: searchTerm, completion: { (error) in
            print("Search Button was Clicked!!!!!")
            
            DispatchQueue.main.async {
                
                self.pokemon = (self.pokemonController!.pokemon)
                
                self.updateViews()
                print("Pokemon Name: \(self.pokemon?.name)")
                print("\(self.pokemonController?.pokemon!.name)")
            }
        })
    }
    
    
    func updateViews(){
        
        guard let pokemon = searchBool == true ? pokemon : self.pokemonController?.pokemon! else { return }
//        guard let pokemon = pokemon else {
//            print("Pokemon var is nil")
//            return
//        }
//
//        guard let pokemon = self.pokemonController?.pokemon! else {
//            print("Pokemon var is nil")
//            return
//        }
        
        searchBool = !searchBool
       
        self.nameLabel.text = capitalizeString(string: pokemon.name)
            let url = pokemon.sprites["front_default"]
            if let data = try? Data(contentsOf: url!!){
                    spriteImage.image = UIImage(data: data)
                }
        self.idLabel.text = ("ID: \(String(pokemon.id))")
//        let abilitiesDictionary = pokemon.abilities[0]
//        let layerAbilities = abilitiesDictionary["ability"]
//        let secondLayerAbilities = layerAbilities["name"]
        var index = 0
        var abilities = pokemon.abilities.count > 1 ? "Abilities: " : "Ability: "
        while index < pokemon.abilities.count {
            if index > 0 {
                abilities.append(contentsOf: ", ")
            }
            guard let ability = pokemon.abilities[index].ability else { return }
            var capitalizedName :String = ""
            capitalizedName.append(contentsOf: ability.name!.prefix(1).uppercased())
            capitalizedName.append(contentsOf: ability.name!.dropFirst())
            abilities.append(contentsOf: capitalizedName)
            index += 1
        }
        
        var indexTypes = 0
        var types = pokemon.types.count > 1 ? "Types: " : "Type: "
        while indexTypes < pokemon.types.count {
            if indexTypes > 0 {
                types.append(contentsOf: ", ")
            }
            guard let type = pokemon.types[indexTypes].type else { return }
            var capitalizedName :String = ""
            capitalizedName.append(contentsOf: type.name!.prefix(1).uppercased())
            capitalizedName.append(contentsOf: type.name!.dropFirst())
            types.append(contentsOf: capitalizedName)
            indexTypes += 1
        }
        
        self.abilitiesLabel.text = abilities
        self.typesLabel.text = types
        self.buttonText.setTitle("Save Pokemon", for: .normal)
        
    }
    
    
    
    

    func capitalizeString(string: String) -> String{
        var capitalized : String = ""
        capitalized.append(contentsOf: string.prefix(1).uppercased())
        capitalized.append(contentsOf: string.dropFirst())
        return capitalized
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "saveSegue" {
//            let destinationVC = segue.destination as! PokedexTableViewController
//            destinationVC.pokemonController = pokemonController!
//            destinationVC.pokes = pokes
//        }
//    }
    

}
