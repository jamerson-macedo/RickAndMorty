//
//  RickAndMortyService.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 16/08/24.
//

import Foundation
import Alamofire
import Combine
class RickAndMortyService {
    // retorna o character responsa sem ser [], pois aqui retorna tudo de uma vez
    func getAllCaracters(page : Int)->AnyPublisher<[Character],Error> {
        let url = "https://rickandmortyapi.com/api/character?page=\(page)"
        //validate me confirma se o codifo foi entre 200 e 299
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!) // datatask para requisiçÕes com combine
        // reetorna a response e a data
            .map{$0.data} // extrai a data
            .decode(type: CharacterResponseDTO.self, decoder: JSONDecoder()) // pega a data e decodifica
            .map{$0.results.map{$0.toDomain()}} // o primeiro map pega o result e transforma em CharacterDTO e dps deixa no jeito
            .mapError{ error -> CharacterError in // pega qualquer erro e decodifica em um erro que voce definiu
                if let urlError = error as? URLError{
                    return .networkError(urlError.localizedDescription)
                }else if let decodingError = error as? DecodingError{
                    return .decodingError(decodingError.localizedDescription)
                }else {
                    return .unknownError
                }
                
            }.eraseToAnyPublisher() // serve para esconder o tipo concreto future e retornar um annypublisher
        
    }
}

