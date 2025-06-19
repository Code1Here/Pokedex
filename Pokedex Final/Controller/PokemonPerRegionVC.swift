//
//  PokemonPerRegionVC.swift
//  Pokedex Final
//
//  Created by Anthony Duran on 4/18/24.
//

import UIKit

class PokemonPerRegionVC: UITableViewController, PokemonStatsDelegate {
    
    func PokemonStatsVC(_ controller: PokemonStatsVC, add_id: Int) {
        favorites.insert(add_id)
        self.tableView.reloadData()
        saveFavorites()
    }
    func PokemonStatsVC(_ controller: PokemonStatsVC, remove_id: Int) {
        favorites.remove(remove_id)
        self.tableView.reloadData()
        saveFavorites()
    }
    
    var regionName: String = ""
    var listOfPokemon: ListOfPokemon?
    var downloadSprite: URLSessionDownloadTask?
    var images: [UIImage]!
    var regionOffset: Int = 0
    
    var sprite: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray4
        
        let offset = regionMapForID[regionName]?[0] ?? 0
        let limit = regionMapForID[regionName]?[1] ?? 152
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=\(offset)&limit=\(limit)")!
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url){(data, response, error) in
            if let error = error {
                print("Failure: \(error.localizedDescription)")
            } else {
                if let pokemonList = self.parse(data: data!) {
                    self.listOfPokemon = pokemonList
                    self.regionOffset = (regionMapForID[self.regionName]?[0] ?? 0)
                    DispatchQueue.main.async { [self] in
                        self.tableView.reloadData()
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func parse(data:Data) -> ListOfPokemon? {
        do {
            let decoder = JSONDecoder()
            let pokemonList = try decoder.decode(ListOfPokemon.self, from: data)
            return pokemonList
        } catch {
            print("JSON error: \(error)")
            return nil
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let range = regionMapForID[regionName] else { return 151 }
        return range[1] - range[0]
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = regionOffset + indexPath.row + 1
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath) as! PokeCell
        cell.backgroundColor = .systemGray6
        
        var pokemonName = listOfPokemon?.results[indexPath.row].name.capitalizingFirstLetter()
        if favorites.contains(id) {
            if var unwrapped = pokemonName { unwrapped += " ❤️"; pokemonName = unwrapped }
        }
         
        let spritesURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(id).png")!
        
        cell.configure(imageURL: spritesURL, text: pokemonName ?? "")
        return cell

    }
    
    // MARK: - Navigation

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destination = segue.destination as! PokemonStatsVC
            let selectedPokemon = sender as! (url: String, id: Int)
            destination.statsURL = selectedPokemon.url
            destination.offset = regionOffset
            destination.delegate = self
            if favorites.contains(selectedPokemon.id) {
                destination.faved = true
            }
        }
    
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let selectedPokeURL = listOfPokemon?.results[indexPath.row].url
            guard tableView.cellForRow(at: indexPath) is PokeCell else { return }
            performSegue(withIdentifier: "toPokemonStatsVC", sender: (url: selectedPokeURL, id: regionOffset + indexPath.row + 1))
        }
    
}


