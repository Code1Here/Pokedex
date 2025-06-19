//
//  PokeballVC.swift
//  Pokedex Final
//
//  Created by Anthony Duran on 4/25/24.
//

import UIKit

class PokeballVC: UIViewController {

    @IBOutlet weak var pokeballLatch: UIButton!
    @IBOutlet weak var magikImg: UIImageView!
    @IBOutlet weak var pikaImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pikaImg.image = UIImage(named: "Pikachu3.png")
        pikaImg.contentMode = .scaleAspectFill
        pikaImg.contentMode = .top
        
        magikImg.image = UIImage(named: "Magikarp.png")
        magikImg.contentMode = .scaleAspectFill
        magikImg.contentMode = .top
        
        pokeballLatch.center = view.center
        loadFavorites()
    }

}
