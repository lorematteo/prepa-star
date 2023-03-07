//
//  Models.swift
//  Quizz
//
//  Created by matteo on 11/07/2021.
//

import Foundation


struct BadgeStruct {
    var id: Int64 = 0
    var filiere: String
    var image: String
    var title: String
    var description: String
    var reward: Int64
    var unlocked : Bool
    var claimed : Bool
}

class Badge: Identifiable {
    public var id: Int64 = 0
    public var filiere: String = ""
    public var image: String = ""
    public var title: String = ""
    public var description: String = ""
    public var reward: Int64 = 0
    public var unlocked : Bool = false
    public var claimed : Bool = false
}


struct FiliereStruct {
    var name: String
    var sousfiliere: String
}

class Filiere: Identifiable {
    public var name: String = ""
    public var sousfiliere: String = ""
}

struct MatiereStruct {
    var title: String
    var filiere: String
    var shortTitle: String
    var sousfiliere: String
    var descf: String
    var descsf: String
}

class Matiere: Identifiable {
    public var title: String = ""
    public var filiere: String = ""
    public var shortTitle: String = ""
    public var sousfiliere: String = ""
    public var descf: String = ""
    public var descsf: String = ""
}

struct ChapitreStruct {
    var id: Int64 = 0
    var name: String
    var matiere: String
    var filiere: String
    var num: Int64
}

class Chapitre: Identifiable {
    public var id: Int64 = 0
    public var name: String = ""
    public var matiere: String = ""
    public var filiere: String = ""
    public var num: Int64 = 0
}

struct QuestionStruct: Hashable {
    var id: Int64 = 0
    var filiere: String
    var matiere: String
    var chap: Int64
    var numq: Int64
    var question: String
    var a: String
    var b: String
    var c: String
    var answer: String
}

class Question: Identifiable {
    public var id: Int64 = 0
    public var filiere: String = ""
    public var matiere: String = ""
    public var chap: Int64 = 0
    public var numq: Int64 = 0
    public var question: String = ""
    public var a: String = ""
    public var b: String = ""
    public var c: String = ""
    public var answer: String = ""
}

struct AvatarColor: Identifiable {
    var id: Int = 0
    var type: String
    var name: String
    var set: String
    var unlocked: Bool
    var rarity: String
    var price: Int64
}
