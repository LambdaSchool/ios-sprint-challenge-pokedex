//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by Joel Groomer on 9/14/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {

    @IBOutlet weak var lblPokemonName: UILabel!
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var lblTypes: UILabel!
    @IBOutlet weak var txtvAbilities: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedPokemon: Pokemon? { didSet { updateSelectedPokemonViews() } }
    
    let pokeController = PokeController()
    
    // MARK: - Views

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    func updateSelectedPokemonViews() {
        if let pokemon = selectedPokemon {
            lblPokemonName.text = pokemon.name

            pokeController.getImage(for: pokemon) { (data) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.imgPokemon.image = UIImage(data: data)
                }
            }

            var monsterTypes = ""
            for t in pokemon.types {
                monsterTypes += t.type.name + ", "
            }
            lblTypes.text = monsterTypes.trimmingCharacters(in: .init(charactersIn: ", "))
            
            var abilities = ""
            for a in pokemon.abilities {
                abilities += a.ability.name + ", "
            }
            txtvAbilities.text = abilities.trimmingCharacters(in: .init(charactersIn: ", "))
        } else {
            lblPokemonName.text = "No Pokémon Selected"
            imgPokemon.image = UIImage(named: "nopokemon")
            lblTypes.text = ""
            txtvAbilities.text = ""
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSearch" {
            if let vc = segue.destination as? PokemonSearchViewController {
                vc.pokeController = pokeController
            }
        }
    }
}

extension PokedexViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeController.encounteredPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell") as? PokeCellTableViewCell else { return UITableViewCell() }
        
        cell.pokemon = pokeController.encounteredPokemon[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPokemon = pokeController.encounteredPokemon[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            pokeController.encounteredPokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            selectedPokemon = nil
        }
    }
}
