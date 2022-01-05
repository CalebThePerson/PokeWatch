//
//  Pokemon.swift
//  PokeWatch
//
//  Created by Caleb Wheeler on 1/5/22.
//

import Foundation
import PokemonAPI
import SwiftyJSON

class Pokemon {
    var allPokemon: JSON {
        get{
            loadJson()
        }
    }
    
    //Loads the JSON file pokemon_names to the variable allPokemon
    func loadJson() -> JSON{
        var json: JSON? = nil
        if let path = Bundle.main.path(forResource: "pokemon_names", ofType: "json"){
            do {
                let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                json = jsonObj
            } catch let error{
                print("parse error: \(error.localizedDescription)")
            }
        }
        return json!
    }
    
    //Getting a random pokemon and then procedding to get the info of that pokemon
    func getPokemon(){
        let randomMon = allPokemon[String(Int.random(in: 1..<allPokemon.count))]
        getPokemonInfo(with: randomMon["name"].stringValue.lowercased())
    }
    
    //Getting the info of a desired pokemon
    func getPokemonInfo(with pokemon: String){
        var thePokemon:PKMPokemon? = nil
        PokemonAPI().pokemonService.fetchPokemon(pokemon){ result in
            switch result{
            case .success(let Pokemon):
                print(Pokemon)
                thePokemon = Pokemon
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
//        PokemonAPI().evolutionService.fetchEvolutionChain(thePokemon!.id!){ result in
//            switch result{
//            case .success(let chain):
//                print(chain)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
}
