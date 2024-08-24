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
    @Published var selectedCharacter : Character?
    
    // para gerenciar o ciclo de vida
    // evitando vazamento de memoria
    private  var cancelable = Set<AnyCancellable>()
    // instancia do service
    private let service : RickAndMortyService
    // paginação
    private var currentPage = 1
    
    init(service: RickAndMortyService){
        self.service = service
    }
    
    func fetchCharacters(){
        // se a pagina ta carregando
        guard !isloading else {return}
        isloading = true
        service.getAllCaracters(page: currentPage).receive(on: DispatchQueue.main).sink { [weak self] completion  in // weak self serve para a referencia SELF seja fraca ou seja o `view model` pode ser deslocado que n tem vazamento de memoria
            self?.isloading = false
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self?.handleError(error)
                
            }
        } receiveValue: { [weak self] response in
            self?.characters.append(contentsOf: response)
            self?.currentPage += 1
        }.store(in: &cancelable)
        

    }
    func loadMoreCharacters( currentItem : Character?){
        guard shouldLoadMore(currentItem:currentItem) else {return}
        fetchCharacters()
    }
    private var canLoadMoreCharacters:Bool{
        !isloading
    }
    private func handleError(_ error : Error){
        errorMessage = error.localizedDescription
    }
    private func shouldLoadMore(currentItem:Character?)->Bool{
        // tem o item ? então carregue
        guard let currentItem = currentItem else {return true }
        let thresholdIntex = characters.index(characters.endIndex,offsetBy: -5)
        return characters.firstIndex(where: {$0.id == currentItem.id}) == thresholdIntex
    }
}
