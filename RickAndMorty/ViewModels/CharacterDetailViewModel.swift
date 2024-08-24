//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 24/08/24.
//

import Foundation
class CharacterDetailViewModel : ObservableObject{
    @Published var character : Character
    init(character: Character) {
        self.character = character
    }
}
