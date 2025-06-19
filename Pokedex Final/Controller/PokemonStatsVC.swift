//
//  PokemonStatsVC.swift
//  Pokedex Final
//
//  Created by Anthony Duran on 5/1/24.
//

import UIKit

protocol PokemonStatsDelegate: AnyObject {
    func PokemonStatsVC(_ controller: PokemonStatsVC, add_id: Int)
    func PokemonStatsVC(_ controller: PokemonStatsVC, remove_id: Int)
}

class PokemonStatsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var delegate: PokemonStatsDelegate?
    
    var statsURL: String = ""
    var offset: Int = 0
    var faved: Bool = false
    
    @IBOutlet weak var heart: UIButton!
    @IBOutlet weak var id_and_name: UILabel!
    @IBOutlet weak var sprite: UIImageView!
    @IBOutlet weak var type1: UIImageView!
    @IBOutlet weak var type2: UIImageView!
    @IBOutlet weak var abilities: UILabel!
    @IBOutlet weak var moves: UITableView!
    
    var pokeStats: PokeStats?
    var downloadSprite: URLSessionDownloadTask?
    var id: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !faved { heart.setTitle("🤍", for: .normal) }
        else { heart.setTitle("❤️", for: .normal) }
        
        moves.dataSource = self
        moves.delegate = self
        
        let url = URL(string: statsURL)!
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url){(data, response, error) in
            if let error = error {
                print("Failure: \(error.localizedDescription)")
            } else {
                if let pokemonStats = self.parse(data: data!) {
                    self.pokeStats = pokemonStats
                    DispatchQueue.main.async { [self] in
                        updateUI(pokeStats: pokemonStats)
                    }
                }
            }
        }
        dataTask.resume()
        
    }
    
    func parse(data:Data) -> PokeStats? {
        do {
            let decoder = JSONDecoder()
            let pokemonStats = try decoder.decode(PokeStats.self, from: data)
            return pokemonStats
        } catch {
            print("JSON error: \(error)")
            return nil
        }
    }

    func updateUI(pokeStats: PokeStats){
        id = pokeStats.id
        // Name
        self.id_and_name.text = "\(id). \(pokeStats.name.capitalizingFirstLetter())"
        
        // Image
        let spritesURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(pokeStats.id).png"
        
        if let url = URL(string: spritesURL){
            downloadSprite = self.sprite.loadImage(url: url)
        }
        
        // Types
        let type1Name = pokeStats.types[0].type.name.capitalizingFirstLetter()
        self.type1.image = UIImage(named: "\(type1Name).jpg")
//      typeColor(color: type1Name)
        changeBackgroundColor(of: self.view, to: typeColorMap[type1Name]!)
        
        if pokeStats.types.count > 1 {
            let type2Name = pokeStats.types[1].type.name.capitalizingFirstLetter()
            self.type2.image = UIImage(named: "\(type2Name).jpg")
//          typeColor(color: type2Name)
            changeBackgroundColor(of: self.sprite, to: typeColorMap[type2Name]!)
        }
        
        // Abilities
        self.abilities.text! += "\n"
        var i = 1
        for stats in pokeStats.abilities{
            abilities.text! += "\n  \(i).  \(stats.ability.name.capitalizingFirstLetter())"
            i += 1
        }
        
        // Reload Moves tableView
        self.moves.reloadData()
    }
    
    // Moves
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Moves", for: indexPath)
        var cellContent = cell.defaultContentConfiguration()
        cellContent.text = "\(indexPath.row + 1).  \(pokeStats?.moves[indexPath.row].move.name.capitalizingFirstLetter() ?? "Tackle")"
        cell.contentConfiguration = cellContent
        return cell
    }


    
    func changeBackgroundColor(of view: UIView, to color: UIColor) {
        view.backgroundColor = color
    }
    
    func changeBackgroundColor(of imageView: UIImageView, to color: UIColor) {
        imageView.backgroundColor = color
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeStats?.moves.count ?? 1
    }
    
    @IBAction func heartClicked(_ sender: Any) {
        if heart.currentTitle == "🤍" {
            heart.setTitle("❤️", for: .normal)
            delegate?.PokemonStatsVC(self, add_id: id)
        } else {
            heart.setTitle("🤍", for: .normal)
            delegate?.PokemonStatsVC(self, remove_id: id)
        }
        
    }
}

/**
 NOTES: Was going to use this but that was before I needed to change the color of more than one view.
 
 func typeColor(color: String){
//        let color = pokeStats?.types[0].type.name.capitalizingFirstLetter()
//
//        var color2: String = ""
//        if (pokeStats?.types.count)! > 1 {
//            color2 = (pokeStats?.types[1].type.name.capitalizingFirstLetter())!
//        }
     switch color {
     case "Normal":
         self.view.backgroundColor = UIColor(hex: 0xA8A77A)
     case "Fire":
         self.view.backgroundColor = UIColor(hex: 0xEE8130)
     case "Water":
         self.view.backgroundColor = UIColor(hex: 0x6390F0)
     case "Grass":
         self.view.backgroundColor = UIColor(hex: 0x7AC74C)
     case "Electric":
         self.view.backgroundColor = UIColor(hex: 0xF7D02C)
     case "Ice":
         self.view.backgroundColor = UIColor(hex: 0x96D9D6)
     case "Fighting":
         self.view.backgroundColor = UIColor(hex: 0xC22E28)
     case "Poison":
         self.view.backgroundColor = UIColor(hex: 0xA33EA1)
     case "Ground":
         self.view.backgroundColor = UIColor(hex: 0xE2BF65)
     case "Flying":
         self.view.backgroundColor = UIColor(hex: 0xA98FF3)
     case "Psychic":
         self.view.backgroundColor = UIColor(hex: 0xF95587)
     case "Bug":
         self.view.backgroundColor = UIColor(hex: 0xA6B91A)
     case "Rock":
         self.view.backgroundColor = UIColor(hex: 0xB6A136)
     case "Ghost":
         self.view.backgroundColor = UIColor(hex: 0x735797)
     case "Dragon":
         self.view.backgroundColor = UIColor(hex: 0x6F35FC)
     case "Dark":
         self.view.backgroundColor = UIColor(hex: 0x705746)
     case "Steel":
         self.view.backgroundColor = UIColor(hex: 0xB7B7CE)
     case "Fairy":
         self.view.backgroundColor = UIColor(hex: 0xD685AD)
     default:
         print("Value is something else")
     }
 }
}



 */
