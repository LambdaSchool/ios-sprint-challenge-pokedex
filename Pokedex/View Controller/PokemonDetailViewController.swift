//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by alfredo on 1/26/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        updateViews()
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
     //MARK: - IBActions
     
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        pokedexController?.pokedex[pokemon!.name]?.favorite.toggle()
        delegate?.updateSavedPokemon()
        switch true{
        case sender.titleLabel?.text == "Save Pokemon":
            sender.setTitle("Unsave Pokemon", for: .normal)
        case sender.titleLabel?.text == "Unsave Pokemon":
            sender.setTitle("Save Pokemon", for: .normal)
        default:
            break
        }
    }
    //MARK: - Properties
    
    var pokedexController: PokedexController?
    var pokemon: PokedexEntry?
    var delegate: SavePokemon?
    
    //MARK: - Methods
    
    func updateViews(){
        guard let _ = pokemon else { return }
        guard let _ = abilitiesLabel else { return }
        guard let _ = idLabel else { return }
        guard let _ = pokemonImage else { return }
        guard let _ = typesLabel else { return }
        
        abilitiesLabel.text = "Abilities: \(pokemon!.getAbilitiesAsString())"
        if let id = pokemon?.id{
            idLabel.text = "ID: \(id)"
        }
        if let image = getImage(){
            pokemonImage.image = image
        }
        if let types = pokemon?.getTypesString(){
            typesLabel.text = "Types: \(types)"
        }
        navigationBar?.title = pokemon?.name
    }
    func getImage() -> UIImage?{
        var image: UIImage?
        let urlString: String
//        guard let urlString = pokemon!.images.front_shiny else { return }
        
        switch true {
        case pokemon?.images.front_shiny != nil:
            urlString = pokemon!.images.front_shiny!
        case pokemon?.images.front_shiny_female != nil:
            urlString = pokemon!.images.front_shiny_female!
        case pokemon?.images.front_female != nil:
            urlString = pokemon!.images.front_female!
        case pokemon?.images.back_shiny_female != nil:
            urlString = pokemon!.images.back_shiny_female!
        case pokemon?.images.back_shiny != nil:
            urlString = pokemon!.images.back_shiny!
        case pokemon?.images.back_female != nil:
            urlString = pokemon!.images.back_female!
        case pokemon?.images.back_default != nil:
            urlString = pokemon!.images.back_default!
        default:
            return nil
        }
        let url = NSURL(string: urlString) as! URL
        if let imageData: NSData = NSData(contentsOf: url) {
            image = UIImage(data: imageData as Data)
        }
        return image
    }
}
