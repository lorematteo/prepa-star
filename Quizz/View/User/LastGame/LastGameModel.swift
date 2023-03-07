//
//  LastGameSave.swift
//  Quizz
//
//  Created by matteo on 03/07/2021.
//

import Foundation

class DernierQuizz: Identifiable {
    var id: Int64 = 0
    var matiere: String = ""// Physique
    var filiere: String = ""// MP
    var chap: Int64 = 0// 1
    var chapname: String = ""// Mécanique
    var score: Int64 = 0// 5
}

class QuestionResume: Identifiable {
    var id: Int64 = 0
    var question: String = ""
    var answer: String = ""
}

struct DernierQuizzStruct {
    var id: Int64 = 0
    var matiere: String = ""// Physique
    var filiere: String = ""// MP
    var chap: Int64 = 0// 1
    var chapname: String = ""// Mécanique
    var score: Int64 = 0// 5
}

struct QuestionResumeStruct {
    var id: Int64 = 0
    var question: String = ""
    var answer: String = ""
}
