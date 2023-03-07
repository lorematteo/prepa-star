//
//  Question.swift
//  Quizz
//
//  Created by matteo on 13/05/2021.
//

import SwiftUI
import FirebaseFirestoreSwift

// codable model...

struct fbquizz: Identifiable, Codable, Hashable {
    
    //fetching doc id...
    @DocumentID var id: String?
    var matiere: String
    var chapitre: Int
    var name: String
    var auteur: String
    var message: String
    var duration: Int
    var difficulty: Int
    var avgRating: Double
    var numRatings: Int
    var creationDate: Date
    var published: Bool
    
    enum CodingKeys: String,CodingKey {
        case id
        case matiere
        case chapitre
        case name
        case auteur
        case message
        case duration
        case difficulty
        case avgRating
        case numRatings
        case creationDate
        case published
    }
}

struct fbquestion: Identifiable, Codable, Hashable {
    
    //fetching doc id...
    @DocumentID var id: String?
    var question: String
    var a: String
    var b: String
    var c: String
    var answer: String
    var numq: Int
    
    enum CodingKeys: String,CodingKey {
        case id
        case question
        case a = "repa"
        case b = "repb"
        case c = "repc"
        case answer
        case numq
    }
}
