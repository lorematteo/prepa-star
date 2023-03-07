//
//  informationsModel.swift
//  Quizz
//
//  Created by matteo on 08/07/2021.
//

import Foundation

class Informations: Identifiable{
    public var exp: Int64 = 0
    public var money: Int64 = 0
    public var quizztotal: Int64 = 0
    public var bonnereptotal: Int64 = 0
    public var mauvaisereptotal: Int64 = 0
    public var tempstotal: Double = 0
    public var earnedbadge: Int64 = 0
}

struct  ExperienceStruct{
    var exp: Int
    var niveau: Int
    var rang: String
    var xpneeded: Int
}

class  Experience{
    
    var rank: [String] = ["Nouveau", "Débutant", "Apprenti", "Novice", "Amateur", "Habitué", "Travailleur", "Doué", "Acharné", "Admissible", "Majorant", "Colleur", "Ingénieur", "Agrégé", "Doctorant", "Scientifique", "Génie"]
    
    func getNiveau(exp: Double) -> Int{
        let result = (sqrt(150 * (2 * Double(exp) + 15)) + 25) / 45
        return Int(result)
    }
    
    func getXPNext(level: Int) -> Int{
        
        let result = pow(Double(45 * level - 25), 2)  / 300 - 15 / 2
        return Int(round(result))
    }
    
    public func getXPInfos(exp: Double) -> ExperienceStruct{
        let level = getNiveau(exp: exp)
        let nextlevelxp = getXPNext(level: level+1)
        let previouslevelxp = getXPNext(level: level)
        return ExperienceStruct(exp: Int(round(exp)) - previouslevelxp, niveau: level - 1, rang: level-1 <= rank.count ? rank[level - 2] : "Légende", xpneeded: nextlevelxp - previouslevelxp)
    }
}
