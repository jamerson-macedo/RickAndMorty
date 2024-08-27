//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Jamerson Macedo on 16/08/24.
//

import SwiftUI
import SwiftData
@main
struct RickAndMortyApp: App {
    // verificando se foi inicalizado com sucesso
//    init() {
//            do {
//                let modelContainer = try ModelContainer(for: Favorite.self)
//                print("ModelContainer initialized successfully")
//            } catch {
//                print("Failed to initialize ModelContainer: \(error)")
//            }
//        }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appdelegate
    init(){
        requestNotificationPermission()
    }
    var body: some Scene {
        WindowGroup {
            RickAndMortyView(viewmodel: RickAndMortyViewModel(service: RickAndMortyService()))
                .modelContainer(for:[Favorite.self])
        }
    }
    private func requestNotificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]){ granted, error in
            if let error = error {
                print(error.localizedDescription)
            }else {
                print(granted)
            }
        }
    }
}
class AppDelegate : NSObject,UIApplicationDelegate,UNUserNotificationCenterDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner,.sound])
    }
}
