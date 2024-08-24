//
//  RickAndMortyItem.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 16/08/24.
//

import SwiftUI

struct RickAndMortyItem: View {
    let character: Character
    @State private var isPressed = false
   
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 100)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .transition(.scale.combined(with: .opacity))
                        .animation(.easeInOut(duration: 0.3), value: UUID())
                case .failure:
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                @unknown default:
                    EmptyView()
                }
            }
            Text(character.name)
                .font(.headline)
                .lineLimit(1)
                .foregroundColor(.primary)
            Text(character.species)
                .font(.subheadline)
                .lineLimit(1)
                .foregroundColor(.secondary)
            StatusView(status: character.status)
        }
        .frame(width: 150, height: 200)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
      
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}


#Preview {
    RickAndMortyItem(character: Character(id: 1, name: "Rick Sanches", status: "Live", species: "brasileiro", type: "", gender: "masculino", origin: Origin(name: "brasil", url: ""), location: Location(name: "Terra", url: ""), image: "https://rickandmortyapi.com/api/character/avatar/361.jpeg", episode: [""], url: "", created: "2020"))
}
