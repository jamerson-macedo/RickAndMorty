//
//  Favorite.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 27/08/24.
//

import Foundation
import SwiftData

@Model
class Favorite : Identifiable{
    var id :Int
    var name : String
    var image:String
    init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
