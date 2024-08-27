//
//  FavoritesViewModel.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 27/08/24.
//

import Foundation
import SwiftData
class FavoritesViewModel : ObservableObject{
    @Published var favorites = [Favorite]()
    private var favoriteService = FavoriteService()
    func loadFavorites(context:ModelContext){
        favorites = favoriteService.fetchFavorites(context: context)
    }
    func removeFavorite(_ characterID: Int, context: ModelContext){
        favoriteService.removeFavorite(characterID: characterID, context: context)
    }
}
