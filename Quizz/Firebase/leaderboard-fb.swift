//
//  leaderboardmodel.swift
//  Quizz
//
//  Created by matteo on 14/07/2021.
//

import SwiftUI
import Firebase

class Leaderboard: ObservableObject {
    
    @Published var top10ALL : [dbuser] = []
    @Published var top10Fil : [dbuser] = []
    @Published var top10Classe : [dbuser] = []
    
    private var db = Firestore.firestore()
    
    func getTop10ALL(){
        
        // since were having only one set in firestore so were going to fetch that one only...
        // you can add round 2,3... into firestore and can be fetched...
        // change this to set...
        db.collection("leaderboard").order(by: "weeklyscore", descending: true).limit(to: 9).getDocuments { (snap, err) in
            
            guard let data = snap else{print(err?.localizedDescription ?? ""); return}
            
            DispatchQueue.main.async {
                
                self.top10ALL = data.documents.compactMap({ (doc) -> dbuser? in return try? doc.data(as: dbuser.self)
                })
            }
        }
    }
    
    func getTop10Filiere(filiere: String){
        
        // since were having only one set in firestore so were going to fetch that one only...
        // you can add round 2,3... into firestore and can be fetched...
        // change this to set...
        db.collection("leaderboard").whereField("filiere", isEqualTo: filiere).order(by: "bimonthlyscore", descending: true).limit(to: 9).getDocuments { (snap, err) in
            
            guard let data = snap else{print(err?.localizedDescription ?? ""); return}
            
            DispatchQueue.main.async {
                
                self.top10Fil = data.documents.compactMap({ (doc) -> dbuser? in return try? doc.data(as: dbuser.self)
                })
            }
        }
    }
    
    func getTop10Classe(filiere: String, prepa: String){
        // since were having only one set in firestore so were going to fetch that one only...
        // you can add round 2,3... into firestore and can be fetched...
        // change this to set...
        db.collection("leaderboard").whereField("prepa", isEqualTo: prepa).whereField("filiere", isEqualTo: filiere).order(by: "monthlyscore", descending: true).limit(to: 9).getDocuments { (snap, err) in
            
            guard let data = snap else{print(err?.localizedDescription ?? ""); return}
            
            DispatchQueue.main.async {
                
                self.top10Classe = data.documents.compactMap({ (doc) -> dbuser? in return try? doc.data(as: dbuser.self)
                })
            }
        }
    }
    
    func addUser(user: dbuser, completion: @escaping(String) -> Void){
        var ref: DocumentReference? = nil
        do {
            ref = try db.collection("leaderboard").addDocument(from: user)
        }
        catch {
            print(error.localizedDescription)
        }
        completion(ref?.documentID ?? "")
    }
    
    func checkUsernameAvailability(username: String, completion: @escaping(Bool) -> Void) {
        
        db.collection("leaderboard").whereField("name", isEqualTo: username).limit(to: 1).getDocuments { (snap, err) in
            if let err = err {
                print("error getting document: \(err)")
                completion(false)
            } else if (snap?.isEmpty)! {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func incrementUserScore(userID: String, score: Int){
        self.db.collection("leaderboard").document(userID).updateData(["weeklyscore": FieldValue.increment(Double(score))])
        self.db.collection("leaderboard").document(userID).updateData(["bimonthlyscore": FieldValue.increment(Double(score))])
        self.db.collection("leaderboard").document(userID).updateData(["monthlyscore": FieldValue.increment(Double(score))])
    }
    
    func getUserScores(userID: String, completion: @escaping([Int]) -> Void){
        db.collection("leaderboard").document(userID).getDocument { (snap, err) in
            if let document = snap, document.exists {
                let scores = [document.get("weeklyscore") as! Int, document.get("bimonthlyscore") as! Int, document.get("monthlyscore") as! Int]
                completion(scores)
            } else {
                print("unable to find document : \(userID)")
            }
        }
    }
    
    func getWeekNum(completion: @escaping(Int) -> Void){
        db.collection("generalinfos").document("week").getDocument { (snap, err) in
            if let document = snap, document.exists {
                completion(document.get("number") as! Int)
            } else {
                print("unable to find document : week")
            }
        }
    }
    
    func updateUserProfil(userID: String, newicon: String, newcolor: String, completion: @escaping(Bool) -> Void){
        db.collection("leaderboard").document(userID).updateData(["icon": newicon, "color": newcolor]){ error in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func updateUser(userID: String, newusername: String, newfiliere: String, completion: @escaping(Bool) -> Void){
        db.collection("leaderboard").document(userID).updateData(["name": newusername, "filiere": newfiliere]) { error in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func checkRewardAvailable(username: String, completion: @escaping(Int) -> Void){
        
        db.collection("rewardcenter").whereField("username", isEqualTo: username).whereField("claimed", isEqualTo: false).limit(to: 1).getDocuments { (snap, err) in
            guard let documents = snap?.documents else {
                print("No documents")
                completion(0)
                return
            }
            let _ = documents.map { (snap) in
                let data = snap.data()
                let reward = data["reward"] as? Int ?? 0
                let username = data ["username"] as? String ?? ""
                print(reward, username)
                completion(reward)
            }
        }
    }
    
    func claimReward(username: String, completion: @escaping(Bool) -> Void){
        db.collection("rewardcenter").document(username).updateData(["claimed": true]) { error in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
