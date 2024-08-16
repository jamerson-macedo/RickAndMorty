//
//  RickAndMortyItem.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 16/08/24.
//

import SwiftUI

struct RickAndMortyItem: View {
    var character : Character
    var body: some View {
        VStack(alignment:.center) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            Text(character.name)
                .font(.headline).bold()
                .lineLimit(1)
            Text(character.species)
                .font(.subheadline)
                .lineLimit(1)
        }.frame(width: 150,height: 200)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}


#Preview {
    RickAndMortyItem(character: Character(id: 1, name: "Rick Sanches", status: "Live", species: "brasileiro", type: "", gender: "masculino", origin: Origin(name: "brasil", url: ""), location: Location(name: "Terra", url: ""), image: "https://rickandmortyapi.com/api/character/avatar/361.jpeg", episode: [""], url: "", created: "2020"))
}
