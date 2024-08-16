//
//  RickAndMortyViewModel.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 16/08/24.
//

import Foundation
import Combine
class RickAndMortyViewModel : ObservableObject{
    // quando o viewmodel tem a referencia do service eles criam uma referencia forte
    // e se a viewfechar o viewmodel sai e a referencia e perdida, por isso usa weal self
    @Published var characters  = [Character]()
    @Published var isloading = false
    @Published var errorMessage :String? = nil
    
    // para gerenciar o ciclo de vida
    // evitando vazamento de memoria
    var cancelable = Set<AnyCancellable>()
    private let service = RickAndMortyService()
    // paginação
    private var currentPage = 1
    private var totalPages = 1
    
    func fetchCharacters(){
        // se a pagina ta carregando ou a pagina atual é menor que o total
        guard !isloading && currentPage <= totalPages else {
            return
        }
        isloading = true
        service.getAllCaracters(page: currentPage).sink { [weak self] completion  in // weak self serve para a referencia SELF seja fraca ou seja o `view model` pode ser deslocado que n tem vazamento de memoria
            self?.isloading = false
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                
            }
        } receiveValue: { [weak self] response in
            self?.characters.append(contentsOf: response.results)
            self?.currentPage += 1
            self?.totalPages = response.info.pages
        }.store(in: &cancelable)
        

    }
    func loadMoreCharacters( currentItem : Character?){
        // se não o item não é null ele passa se n chama mais
        guard let currentItem = currentItem else {
            fetchCharacters()
            return
        }
        // pega os 5 ultimos itens da lista para ja carregar antes de chegar no final
        let thresholdIndex = characters.index(characters.endIndex,offsetBy: -5)
        // se o item que ta mostrando é o igual o 5 ultimo item
        if characters.firstIndex(where: {$0.id == currentItem.id}) == thresholdIndex{
            fetchCharacters()
        }
    }
}
