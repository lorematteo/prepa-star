//
//  QuestionViewModel.swift
//  Quizz
//
//  Created by matteo on 13/05/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class FirebaseQuizz: ObservableObject {
    @Published var quizzliste : [fbquizz] = []
    @Published var questions: [fbquestion] = []
    @Published var lastquizz: [fbquizz] = []
    
    let db = Firestore.firestore()
    
    func getLastQuizz(filiere: String, matiere: String, chapitre: Int){
        db.collection(filiere).whereField("published", isEqualTo: true).whereField("matiere", isEqualTo: matiere).whereField("chapitre", isEqualTo: chapitre).order(by: "creationDate", descending: true).limit(to: 1).getDocuments { (snap, err) in
            guard let data = snap else{return}
            
            DispatchQueue.main.async {
                self.lastquizz = data.documents.compactMap({ (doc) -> fbquizz? in
                    return try? doc.data(as: fbquizz.self)
                    })
            }
        }
    }
    
    func getQuizzListe(filiere: String, matiere: String, chapitre: Int, completion: @escaping(Bool) -> Void){
        
        db.collection(filiere).whereField("published", isEqualTo: true).whereField("matiere", isEqualTo: matiere).whereField("chapitre", isEqualTo: chapitre).order(by: "creationDate", descending: true).getDocuments { (snap, err) in
            
            guard let data = snap else{completion(false); return}
            
            DispatchQueue.main.async {
                completion(true)
                self.quizzliste = data.documents.compactMap({ (doc) -> fbquizz? in
                    return try? doc.data(as: fbquizz.self)
                })
            }
        }
    }
    
    func getQuestions(filiere: String, quizzid: String){
        db.collection(filiere).document(quizzid).collection("questions").order(by: "numq", descending: false).getDocuments{(snap, err) in
            
            guard let data = snap else{return}
            
            DispatchQueue.main.async {
                withAnimation(.spring()){
                    self.questions = data.documents.compactMap({ (doc) -> fbquestion? in return try? doc.data(as: fbquestion.self)
                    })
                }
            }
        }
    }
    
    func checkCanRate(filiere: String, quizzid: String, userid: String, completion: @escaping(Bool) -> Void){
        db.collection(filiere).document(quizzid).collection("ratings").whereField("userid", isEqualTo: userid).limit(to: 1).getDocuments{ (snap, err) in
            if let err = err {
                print("error checking canRate: \(err)")
            } else if (snap?.isEmpty)! {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func rateQuizz(filiere: String, quizzid: String, userid: String, rating: Int){
        db.collection(filiere).document(quizzid).collection("ratings").document().setData(["userid": userid, "rating": rating]){ error in
            if let error = error {
                print("Error writing document: \(error)")
            }
        }
    }
}
