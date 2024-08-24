//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 16/08/24.
//

import SwiftUI

struct RickAndMortyView: View {
    // pra não perder a referencia e ser recriado é melhor usar o StateObject
    // se p viewmodel fosse passado como parametro para a lista ai sim usaria o Observed
    @StateObject var viewmodel : RickAndMortyViewModel
    @State private var searchText = ""
    
    let gridItems = [GridItem(.flexible()),GridItem(.flexible())]
    var filteredCharacters : [Character]{
        if searchText.isEmpty{
            return viewmodel.characters
        }else {
            return viewmodel.characters.filter{$0.name.lowercased().contains(searchText.lowercased())}
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 20) {
                        ForEach(filteredCharacters) { character in
                            NavigationLink(
                                destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character)),
                                label: {
                                    RickAndMortyItem(character: character)
                                        .frame(width: 150, height: 200)
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                       
                                })
                            .buttonStyle(PlainButtonStyle())
                            .onAppear {
                                viewmodel.loadMoreCharacters(currentItem: character)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Rick and Morty")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewmodel.fetchCharacters()
            }
        }
    }
}
#Preview {
    RickAndMortyView(viewmodel: RickAndMortyViewModel(service: RickAndMortyService()))
}
