
import Foundation
import UIKit

typealias CompletionHandler = (String?) -> Void
enum App
{
	static let baseURL = URL(string:"https://pokeapi.co/api/v2/pokemon/")!
	static var controller = PokemonController()
}

func buildRequest(_ ids:[String], _ httpMethod:String, _ data:Data?=nil) -> URLRequest
{
	var url = App.baseURL
	for id in ids {
		url.appendPathComponent(id)
	}
	var req = URLRequest(url: url)
	req.httpMethod = httpMethod
	req.httpBody = data
	return req
}
