
import Foundation
import UIKit

struct Pokemon: Codable, Comparable
{
	// this is basically the json tree
	// it's hacky, but I don't care to learn the JSON
	// navigation stuff just yet
	struct PokeField: Codable
	{
		struct PokeFieldInner: Codable
		{
			var name:String
		}

		var is_hidden:Bool?
		var ability: PokeFieldInner?
		var type:PokeFieldInner?
	}


	var name:String
	var id:Int
	var abilities:[PokeField]
	var types:[PokeField]

	static func ==(l:Pokemon, r:Pokemon) -> Bool
	{
		return l.id == r.id
	}
	static func <(l:Pokemon, r:Pokemon) -> Bool
	{
		return l.id < r.id
	}

}
