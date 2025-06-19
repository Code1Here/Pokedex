//
//  DataStructures.swift
//  Pokedex Final
//
//  Created by Anthony Duran on 4/15/24.
//

import Foundation
import UIKit

let regionMapForID = [
    /**
     Source: https://bulbapedia.bulbagarden.net/wiki/Regional_Pokédex
     */
    "kanto": [0, 151],
    "johto": [151, 251],
    "hoenn": [251, 386],
    "sinnoh": [386, 493],
    "unova": [493, 649],
    "kalos": [649, 721],
    "alola": [721, 807],
    "galar": [807, 896],
    "hisui": [896, 903],
    "paldea": [903, 1023]
]

let regions = ["Kanto","Johto","Hoenn","Sinnoh","Unova","Kalos","Alola","Galar","Hisui","Paldea"]

let typeColorMap = [
    /**
     Source: https://gist.github.com/apaleslimghost/0d25ec801ca4fc43317bcff298af43c3
     */
     "Normal":UIColor(hex: 0xA8A77A),
     "Fire":UIColor(hex: 0xEE8130),
     "Water":UIColor(hex: 0x6390F0),
     "Grass":UIColor(hex: 0x7AC74C),
     "Electric":UIColor(hex: 0xF7D02C),
     "Ice":UIColor(hex: 0x96D9D6),
     "Fighting":UIColor(hex: 0xC22E28),
     "Poison":UIColor(hex: 0xA33EA1),
     "Ground":UIColor(hex: 0xE2BF65),
     "Flying":UIColor(hex: 0xA98FF3),
     "Psychic":UIColor(hex: 0xF95587),
     "Bug":UIColor(hex: 0xA6B91A),
     "Rock":UIColor(hex: 0xB6A136),
     "Ghost":UIColor(hex: 0x735797),
     "Dragon":UIColor(hex: 0x6F35FC),
     "Dark":UIColor(hex: 0x705746),
     "Steel":UIColor(hex: 0xB7B7CE),
     "Fairy":UIColor(hex: 0xD685AD)
]

var favorites = Set<Int>()


