import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Model.shared.pokemon
        Model.shared.updateHandler = { self.tableView.reloadData() }
    }
    
    // work to do when this object is released back to memory
    //Cleaning up after ourselves...kind of like setting a text field to an empty string.
    deinit {
        Model.shared.updateHandler = nil
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        Model.shared.search(for: searchTerm)
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.numberOfPokemon()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.reuseIdentifier, for: indexPath) as? PokemonCell
            else {
                fatalError("Unable to retrieve and cast cell")
        }
        
        //Get person
        let pokemon = Model.shared.pokemon(at: indexPath.row)
        
        cell.nameLabel.text = pokemon.name
        cell.IDLabel.text = "ID: \(pokemon.ID)"
        cell.abilityLabel.text = "Ability: \(pokemon.ability)"
        cell.typeLabel.text = "Type: \(pokemon.types)"
        //cell.image?.images = pokemon.sprites
        
        
        
        return cell
    }
    
    
//    @IBAction func add() {
//        guard let searchBar = tableView.searchB
//            else { return }
//
//        guard let name = cell.searchBar.text, !name.isEmpty
//            else { return }
//
//        // If nil, set it to the empty string (ensure that we ahve a string and not nil
//        let cohort = cell.cohortField.text ?? ""
//
//        // construct a person
//        let person = Person(name: name, cohort: cohort)
//
//        // Clear the textField after entered and saved
//        cell.nameField.text = ""
//        cell.cohortField.text = ""
//
//        // add to the model
//        Model.shared.addNewPerson(person: person) {
//            self.tableView.reloadData()
//        }
    
    
}
