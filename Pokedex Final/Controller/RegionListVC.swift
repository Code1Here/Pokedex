//
//  RegionListVC.swift
//  Pokedex Final
//
//  Created by Anthony Duran on 4/18/24.
//

import UIKit

class RegionListVC: UITableViewController {
    
    var regionListResponse: RegionList?

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://pokeapi.co/api/v2/region/")!
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url){(data, response, error) in
            if let error = error {
                print("Failure: \(error.localizedDescription)")
            } else {
                if let regionList = self.parse(data: data!) {
                    self.regionListResponse = regionList
                    DispatchQueue.main.async { [self] in
                        self.tableView.reloadData()
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func parse(data:Data) -> RegionList? {
        do {
            let decoder = JSONDecoder()
            let pokemonList = try decoder.decode(RegionList.self, from: data)
            return pokemonList
        } catch {
            print("JSON error: \(error)")
            return nil
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionListResponse?.results.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell", for: indexPath)
        cell.backgroundColor = .black
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        let label = cell.viewWithTag(2) as! UILabel
        label.textColor = .white
        
        let regionStr = regionListResponse?.results[indexPath.row].name.capitalizingFirstLetter()
        label.text = regionStr
        imageView.image = UIImage(named: "\(regionStr ?? "Magikarp").jpg")
        imageView.contentMode = .scaleAspectFill
        
        return cell
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PokemonPerRegionVC
        let regionNameForIDRange = sender as! String
        destination.regionName = regionNameForIDRange
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedRegion = regionListResponse?.results[indexPath.row].name
        performSegue(withIdentifier: "toPokemonPerRegionVC", sender: selectedRegion)
    }

}
