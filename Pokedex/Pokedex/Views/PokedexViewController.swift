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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func updateSelectedPokemonViews() {
        guard let pokemon = selectedPokemon else { return }
        
        lblPokemonName.text = pokemon.name
        // TODO: set pokemon image here
        
        var monsterTypes: String
        for t in pokemon.types {
            monsterTypes += t.type.name + ", "
        }
        lblTypes.text = monsterTypes
        
        var abilities: String
        for a in pokemon.abilities {
            abilities += a.ability.name + ", "
        }
        txtvAbilities.text = abilities
    }
}

extension PokedexViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeController.encounteredPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
