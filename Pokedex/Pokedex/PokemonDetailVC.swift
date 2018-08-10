
import Foundation
import UIKit

class PokemonDetailVC:UIViewController
{
	var poke:Pokemon!

	@IBOutlet weak var idLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var abilityLabel: UILabel!
	override func viewWillAppear(_ animated: Bool) {
		if poke.id == -1 {
			nameLabel.font = UIFont(name: "Courier", size: 24.0)
			idLabel.font = UIFont(name: "Courier", size: 128.0)
			typeLabel.font = UIFont(name: "Courier", size: 128.0)
			abilityLabel.font = UIFont(name: "Courier", size: 128.0)
			nameLabel.text = "Missingno."
			idLabel.text =   "░░▓"
			typeLabel.text =   "░░▓"
			abilityLabel.text = "░▓▓"
			return
		}

		nameLabel.text = poke.name
		idLabel.text = "ID: \(poke.id)"
		var types:[String] = []
		for type in poke.types {
			if let type = type.type {
				types.append(type.name)
			}
		}

		typeLabel.text = "Types: \(types.joined(separator: ", "))"

		var abilities:[String] = []
		for abil in poke.abilities  {
			if let ability = abil.ability {
				if abil.is_hidden ?? false {
					abilities.append("\(ability.name) (hidden)")
				} else {
					abilities.append(ability.name)
				}
			}
		}
		abilityLabel.text = "Abilities: \(abilities.joined(separator: ", "))"




	}
	@IBAction func savePokemon(_ sender: Any) {
		App.controller.save(poke!)
		navigationController?.popViewController(animated: true)
	}
}
