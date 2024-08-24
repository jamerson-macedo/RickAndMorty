// Character.swift
import Foundation

struct Character: Identifiable {
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

struct Origin {
    let name: String
    let url: String
}

struct Location {
    let name: String
    let url: String
}
