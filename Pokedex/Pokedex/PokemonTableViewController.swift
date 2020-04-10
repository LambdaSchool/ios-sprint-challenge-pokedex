//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Hunter Oppel on 4/10/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class PokemonTableViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
        
    private lazy var dataSource = makeDataSource()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        update()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPokemon" {
            guard let detailVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow
                else { return }
            
            detailVC.pokemon = PokemonDetailViewModel.pokemon[indexPath.row]
        }
    }

}

extension PokemonTableViewController {
    enum Section {
        case main
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Section, String> {
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, name in
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
            
            cell.textLabel?.text = name
            
            return cell
        }
    }
    
    private func update() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: false)
        var pokemonNames = [String]()
        for pokemon in PokemonDetailViewModel.pokemon {
            pokemonNames.append(pokemon.name.uppercased())
        }
        snapshot.appendItems(pokemonNames)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
