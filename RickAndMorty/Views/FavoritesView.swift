//
//  FavoritesView.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 27/08/24.
//

import SwiftUI
import SwiftData
struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel = FavoritesViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            
            VStack{
                if viewModel.favorites.isEmpty{
                    Text("Nenhum personagem disponivel")
                }
                List(viewModel.favorites) { favorite in
                    HStack {
                        AsyncImage(url: URL(string: favorite.image)) { image in
                            image.resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Text(favorite.name)
                            .font(.headline)
                    }.swipeActions(edge: .trailing){
                        Button(role: .destructive) {
                            viewModel.removeFavorite(favorite.id, context: modelContext)
                        } label: {
                            Label("Remover", systemImage: "trash")
                        }
                    }
                }
                .onAppear {
                    viewModel.loadFavorites(context: modelContext)
                }
                
                .navigationTitle("Favoritos")
                
            }.toolbar{
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            }
        }
    }
}

#Preview {
    FavoritesView()
}
