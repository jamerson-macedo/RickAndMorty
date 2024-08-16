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
    func getAllCaracters(page : Int)->AnyPublisher<CharacterResponse,Error> {
        let url = "https://rickandmortyapi.com/api/character?page=\(page)"
        //validate me confirma se o codifo foi entre 200 e 299
        return Future {  promisse in // essa operacao retorna apenas um valor então o future é melhot que o anypublisher
            AF.request(url,method: .get).validate().responseDecodable(of: CharacterResponse.self){ response in
                switch response.result{
                case .success(let characterResponse):
                    print(characterResponse)
                    promisse(.success(characterResponse))
                case .failure(let error):
                    print(error)
                    promisse(.failure(error))
                    
                }
                
                
            }
            
        }.eraseToAnyPublisher() // serve para esconder o tipo concreto future e retornar um annypublisher
    }
}
