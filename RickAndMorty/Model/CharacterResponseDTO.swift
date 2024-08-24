//
//  CharacterResponseDTO.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 24/08/24.
//

import Foundation
// RESPOSTA DA API

struct CharacterResponseDTO: Decodable {
    let results: [CharacterDTO]
}

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: OriginDTO
    let location: LocationDTO
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct OriginDTO: Decodable {
    let name: String
    let url: String
}

struct LocationDTO: Decodable {
    let name: String
    let url: String
}
// função para retornar o modelo do objeto certinho
extension CharacterDTO {
    func toDomain() -> Character {
        return Character(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: Origin(name: origin.name, url: origin.url),
            location: Location(name: location.name, url: location.url),
            image: image,
            episode: episode,
            url: url,
            created: created
        )
    }
}
