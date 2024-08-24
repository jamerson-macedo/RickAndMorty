//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 24/08/24.
//

// CharacterDetailView.swift
import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    
    var body: some View {
        ZStack {
            // Fundo gradiente cobrindo toda a tela
            LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.7), .blue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    // Imagem do Personagem
                    AsyncImage(url: URL(string: viewModel.character.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            .padding(.top)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    // Nome do Personagem
                    Text(viewModel.character.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    // Status
                    HStack {
                        Circle()
                            .fill(statusColor)
                            .frame(width: 14, height: 14)
                        Text(statusText)
                            .font(.headline).bold()
                            .foregroundColor(.white)
                    }
                    
                    // Divider para separar as seções
                    Divider()
                        .background(Color.white.opacity(0.5))
                        .padding(.horizontal)
                    
                    // Organizar as informações em colunas com ícones
                    VStack(spacing: 16) {
                        HStack {
                            InfoCard(title: "Espécie", value: viewModel.character.species, iconName: "leaf.arrow.circlepath")
                            if !viewModel.character.type.isEmpty {
                                InfoCard(title: "Tipo", value: viewModel.character.type.isEmpty ? "N/A" : viewModel.character.type, iconName: "questionmark.circle")
                            }
                        }
                        HStack {
                            InfoCard(title: "Gênero", value: viewModel.character.gender, iconName: genderIcon)
                            InfoCard(title: "Origem", value: viewModel.character.origin.name, iconName: "globe")
                        }
                        InfoCard(title: "Última Localização", value: viewModel.character.location.name, iconName: "mappin.and.ellipse")
                        InfoCard(title: "Criado em", value:Date().formattedDate(from: viewModel.character.created), iconName: "calendar")
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Apareceu em \(viewModel.character.episode.count) episódio(s)")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                           
                        }
                        
                        
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.1))
                        )
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.character.name)
                    .font(.headline)
                    .foregroundColor(.black)  // Garante que o título esteja sempre visível
            }
        }
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
       
    }
    
    // Cor do status
    var statusColor: Color {
        switch viewModel.character.status.lowercased() {
        case "alive":
            return .green
        case "dead":
            return .red
        default:
            return .gray
        }
    }
    private var statusText: String {
        switch viewModel.character.status.lowercased() {
        case "alive":
            return "Vivo"
        case "dead":
            return "Morto"
        case "unknown":
            return "Desconhecido"
        default:
            return viewModel.character.status.capitalized
        }
    }
    
    // Ícone de gênero
    var genderIcon: String {
        switch viewModel.character.gender.lowercased() {
        case "male":
            return "person.fill"
        case "female":
            return "person.fill.viewfinder"
        default:
            return "person.crop.circle.badge.questionmark"
        }
    }
}

// Componente de Cartão de Informação com Ícone
struct InfoCard: View {
    let title: String
    let value: String
    let iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.white)
                .imageScale(.large)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(value)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
            }
        }
        .padding()
        .frame(maxWidth: .infinity)  // Garante que o cartão ocupe metade da tela
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.1))
        )
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}
#Preview {
    CharacterDetailView(viewModel: CharacterDetailViewModel(character: Character(id: 1, name: "jamerson", status: "live", species: "global", type: "ola", gender: "men", origin: Origin(name: "terra", url: ""), location: Location(name: "brasil", url: ""), image: "", episode: [], url: "", created: "32")))
}
