//
//  Pokemon.swift
//  PokeWatch
//
//  Created by Caleb Wheeler on 1/7/22.
//


import Foundation
import PokemonAPI
import SwiftyJSON
import Alamofire

class Pokemon {
    var allPokemon: JSON {
        get{
            loadJson(looking: "names")
        }
    }
        
    //Loads the JSON file pokemon_names to the variable allPokemon or another json file
    func loadJson(looking: String) -> JSON{
        var json: JSON? = nil
        if let path = Bundle.main.path(forResource: "pokemon_\(looking)", ofType: "json"){
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
    
    //MARK: - Starter Functions
    func starterPokemon(with starter: String){
        getPokemonInfo(with: starter) { pokemon in
            self.getPokemonEvolutionChain(species: (pokemon.species?.name)!) { ID in
                self.getPokemonEvolution(with: ID) { chain in
                    print("Pog")
                }
            }
        }
    }
    
    
    //MARK: - Functions for not starters

    //Getting a random pokemon and then procedding to get the info of that pokemon
    func getPokemon(){
        let randomMon = allPokemon[String(Int.random(in: 1..<allPokemon.count))]
        getPokemonInfo(with: randomMon["name"].stringValue.lowercased()) { pokemon in
            print(randomMon["name"].stringValue)
            self.getPokemonEvolutionChain(species: (pokemon.species?.name)!){ ID in
                self.getPokemonEvolution(with: ID) { chain in
                    print(chain.chain?.isBaby)
                }
            }
        }
    }
    //Gets general information of the pokemon
    func getPokemonInfo(with pokemon: String, completion: @escaping((PKMPokemon)-> Void)) {
        PokemonAPI().pokemonService.fetchPokemon(pokemon){ result in
            switch result{
            case .success(let Pokemon):
                completion(Pokemon)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //Literally the only way to fuckin ACQUIRE a evolutionID
    //Gets the species and then uses an "algorithm" to find the evolution ID
    func getPokemonEvolutionChain(species: String, completion: @escaping((Int)-> Void)){
        PokemonAPI().pokemonService.fetchPokemonSpecies(species){result in
            switch result{
            case .success(let result):
                var chainLink = result.evolutionChain?.url
                let start = chainLink?.index(chainLink!.startIndex, offsetBy: 0)
                let end = chainLink?.index(chainLink!.startIndex, offsetBy: chainLink!.count-2)
                print(chainLink![start!...end!])
                chainLink = String(chainLink![start!...end!])
                var evolutionIDArray = [Character]()
                for char in chainLink!.reversed(){
                    if char == "/"{
                        break
                    } else{
                        evolutionIDArray.append(char)
                    }
                }
                let evolutionID = Int(String(evolutionIDArray.reversed()))
                completion(evolutionID!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //Gets the actually evolution Chain from the ID I ACQUIRED
    func getPokemonEvolution(with chainID: Int, completion: @escaping((PKMEvolutionChain) -> Void)){
        PokemonAPI().evolutionService.fetchEvolutionChain(chainID){result in
            switch result{
            case .success(let chain):
                completion(chain)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

