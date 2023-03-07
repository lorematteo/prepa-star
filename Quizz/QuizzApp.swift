//
//  QuizzApp.swift
//  Quizz
//
//  Created by matteo on 13/05/2021.
//

import SwiftUI
import Firebase

@main
struct QuizzApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("username") var username: String = ""
    @State var rewardavailable: Bool = false
    @State var rewardvalue: Int = 0
    var body: some Scene {
        WindowGroup {
            ContentView()
                .alert(isPresented: $rewardavailable, content: {
                    Alert(title: Text("Bravo, tu viens remporter \(rewardvalue) pièces !"), message: Text("Pour les récupérer clique simplement sur accepter, de rien :)"), dismissButton: .destructive(Text("Accepter"), action: {
                        Leaderboard().claimReward(username: username) { success in
                            if success{
                                DB_Manager().MoneyIncrement(nbr: Int64(rewardvalue))
                            }
                        }
                    }
                    ))
                })
                .onAppear(perform: {
                    Leaderboard().checkRewardAvailable(username: username) { reward in
                        if reward > 0{
                            rewardvalue = reward
                            rewardavailable.toggle()
                        }
                    }
                })
        }
    }
}

/// initializing firebase...

class AppDelegate: NSObject,UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        Auth.auth().signInAnonymously()
        return true
    }
}
