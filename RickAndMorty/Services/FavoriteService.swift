import SwiftData
import SwiftUI
class FavoriteService {
    
    func addFavorite(characterID: Int,name : String, image:String, context: ModelContext) {
        let newFavorite = Favorite(id: characterID, name: name, image: image)
        context.insert(newFavorite)
        try? context.save()
        notification(characterName: name)
    }

    func removeFavorite(characterID: Int, context: ModelContext) {
        let descriptor = FetchDescriptor<Favorite>(
            predicate: #Predicate { $0.id == characterID }
        )
        
        if let favorite = try? context.fetch(descriptor).first {
            context.delete(favorite)
            try? context.save()
        }
        
    }
    func isFavorite(characterId:Int,context:ModelContext) ->Bool{
        let descriptor = FetchDescriptor<Favorite>(
            predicate: #Predicate{$0.id == characterId})
        return (try? context.fetch(descriptor))?.isEmpty == false
    }
  

    func fetchFavorites(context: ModelContext) -> [Favorite] {
        let descriptor = FetchDescriptor<Favorite>()
        return (try? context.fetch(descriptor)) ?? []
    }
    private func notification(characterName : String){
        let content = UNMutableNotificationContent()
        content.title = "Novo Favorito"
        content.body = "\(characterName) foi adicionado aos seus favoritos"
        
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request){ error in
            if let error = error{
                print(error.localizedDescription)
            }else {
                print("adicionado")
            }
            
        }
        
    }
}
