//
//  ActivityLog.swift
//  Quizz
//
//  Created by matteo on 03/07/2021.
//

import Foundation


struct ActivityLogStruct {
    var date: Date
    var daystring: String
    var quizznbr: Int64
    var duration: Double
    var reussiteperc: Double
}

class ActivityLog: Identifiable {
    var date: Date = Date()
    var daystring: String = ["Dimanche", "Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"][Date().get(.weekday)-1]
    var quizznbr: Int64 = 0
    var duration: Double = 0
    var reussiteperc: Double = 0
}
