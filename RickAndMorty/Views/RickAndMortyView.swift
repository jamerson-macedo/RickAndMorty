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
    @StateObject var viewmodel = RickAndMortyViewModel()
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView{
            Group{
                if viewmodel.isloading && viewmodel.characters.isEmpty{
                    ProgressView("Loading...")
                }else if let errorMessage = viewmodel.errorMessage{
                    Text("Error : \(errorMessage)")
                }else {
                    ScrollView{
                        LazyVGrid(columns: gridItems,spacing: 16){
                            ForEach(viewmodel.characters){ item in
                                RickAndMortyItem(character: item)
                                    .onAppear{
                                    viewmodel.loadMoreCharacters(currentItem: item)
                                }
                            }
                        }
                    }
                }
            }.navigationTitle("Rick And Morty #\(viewmodel.characters.count)")
                .onAppear{
                    viewmodel.fetchCharacters()
                }
            
        }
    
    }
}

#Preview {
    RickAndMortyView()
}
