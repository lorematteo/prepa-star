//
//  leaderboard.swift
//  Quizz
//
//  Created by matteo on 14/07/2021.
//

import SwiftUI
import FirebaseFirestoreSwift

// codable model...

struct dbuser: Identifiable, Codable, Hashable {
    
    // fetching doc id...
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var filiere: String
    var prepa: String
    var weeklyscore: Int
    var bimonthlyscore: Int
    var monthlyscore: Int
    var icon: String
    var color: String
    
    // declare the coding keys with respect to firebase firestore key...
    
    enum CodingKeys: String,CodingKey {
        case name
        case filiere
        case prepa
        case weeklyscore
        case bimonthlyscore
        case monthlyscore
        case icon
        case color
    }
    
}

struct fbreward: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String? = UUID().uuidString
    var username: String
    var reward: Int
    var claimed: Bool
    
    enum CodingKeys: String,CodingKey {
        case username
        case reward
        case claimed
    }
}
