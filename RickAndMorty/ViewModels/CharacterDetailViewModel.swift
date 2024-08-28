//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 24/08/24.
//

import Foundation
import SwiftUI
import SwiftData
class CharacterDetailViewModel : ObservableObject{
    
    @Published var character : Character
    private var favoriteService = FavoriteService()
    @Published var isFavorite : Bool = false
    init(character: Character,context :ModelContext) {
        self.character = character
        self.isFavorite = favoriteService.isFavorite(characterId: character.id,context: context)
        
    }
    func toggleFavorite(context:ModelContext){
        if isFavorite{
            favoriteService.removeFavorite(characterID: character.id, context: context)
        }else {
            favoriteService.addFavorite(characterID: character.id, name: character.name, image: character.image, context: context)
        }
        isFavorite.toggle()
    }
}
