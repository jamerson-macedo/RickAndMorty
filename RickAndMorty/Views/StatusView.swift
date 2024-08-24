//
//  StatusView.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 24/08/24.
//

import SwiftUI

struct StatusView: View {
    let status: String
    
    var body: some View {
        HStack {
            Circle()
                .fill(statusColor)
                .frame(width: 10, height: 10)
            
            Text(statusText)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
    
    private var statusColor: Color {
        switch status.lowercased() {
        case "alive":
            return .green
        case "dead":
            return .red
        case "unknown":
            return .gray
        default:
            return .gray
        }
    }
    
    private var statusText: String {
        switch status.lowercased() {
        case "alive":
            return "Vivo"
        case "dead":
            return "Morto"
        case "unknown":
            return "Desconhecido"
        default:
            return status.capitalized
        }
    }
}
