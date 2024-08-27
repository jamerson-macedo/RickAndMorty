//
//  CharacterResponse.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 16/08/24.
//

import Foundation

// MARK: - Character Model

struct Character: Identifiable, Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Origin Model
struct Origin: Decodable {
    let name: String
    let url: String
}

// MARK: - Location Model
struct Location: Decodable {
    let name: String
    let url: String
}

// MARK: - CharacterResponse Model
struct CharacterResponse: Decodable {
    let info: Info
    let results: [Character]
}

// MARK: - Info Model for Pagination
struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
