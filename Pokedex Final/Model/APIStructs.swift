//
//  APIStructs.swift
//  Pokedex Final
//
//  Created by Anthony Duran on 4/17/24.
//

import Foundation

struct RegionList: Codable {
    var results: [Region]
}

struct Region: Codable {
    let name: String
    let url: String
}

struct ListOfPokemon: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct PokeStats: Codable {
    let abilities: [Abilities]
    let id: Int
    let moves: [Moves]
    let name: String
    let types: [Types]
}
struct Types: Codable {
    let type: _Type
}

struct _Type: Codable {
    let name: String
    let url: String
}

struct Abilities: Codable {
    let ability: Ability
    let is_hidden: Bool
    let slot: Int
}

struct Ability: Codable{
    let name: String
    let url: String
}

struct Moves: Codable {
    let move: Move
}

struct Move: Codable {
    let name: String
    let url: String
}

