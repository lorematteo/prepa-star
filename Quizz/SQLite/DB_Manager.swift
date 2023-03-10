//
//  File.swift
//  Quizz
//
//  Created by matteo on 06/07/2021.
//

import Foundation
import SQLite


class DB_Manager {
    private var db: Connection!
    
    private var badges: Table!
    private var id: Expression<Int64>!
    private var filiere: Expression<String>!
    private var title: Expression<String>!
    private var description: Expression<String>!
    private var image: Expression<String>!
    private var reward: Expression<Int64>!
    private var unlocked: Expression<Bool>!
    private var claimed: Expression<Bool>!
    
    private var lastquizz: Table!
    // private var id: Expression<Int64>!
    private var matiere: Expression<String>!
    // private var filiere: Expression<String>!
    private var chap: Expression<Int64>!
    private var chapname: Expression<String>!
    private var score: Expression<Int64>!
    
    private var questionssave: Table!
    // private var id: Expression<Int64>!
    private var question: Expression<String>!
    private var answer: Expression<String>!
    
    private var activitylogs: Table!
    private var date: Expression<Date>!
    private var daystring: Expression<String>!
    private var quizznbr: Expression<Int64>!
    private var duration: Expression<Double>!
    private var reussiteperc: Expression<Double>!
    
    private var informations: Table!
    // private var id: Expression<Int64>!
    private var exp: Expression<Int64>!
    private var money: Expression<Int64>!
    private var quizztotal: Expression<Int64>!
    private var bonnereptotal: Expression<Int64>!
    private var mauvaisereptotal: Expression<Int64>!
    private var tempstotal: Expression<Double>!
    private var earnedbadge: Expression<Int64>!
    
    private var tabfilieres: Table!
    private var name: Expression<String>!
    // private var sousfiliere: Expression<String>!
    
    private var tabmatieres: Table!
    // private var matiere: Expression<String>!
    // private var filiere: Expression<String>!
    // private var title: Expression<String>!
    private var shortTitle: Expression<String>!
    private var sousfiliere: Expression<String>!
    private var descf: Expression<String>!
    private var descsf: Expression<String>!
    
    private var tabchapitres: Table!
    // private var id: Expression<Int64>!
    // private var name: Expression<String>!
    // private var matiere: Expression<String>!
    // private var filiere: Expresssion<String>!
    private var num: Expression<Int64>!
    
    private var tabquestions: Table!
    // private var id: Expression<Int64>!
    // private var filiere: Expression<String>!
    // private var matiere: Expression<String>!
    // private var chap: Expression<Int64>!
    private var numq: Expression<Int64>!
    // private var question: Expression<String>!
    private var a: Expression<String>!
    private var b: Expression<String>!
    private var c: Expression<String>!
    // private var answer: Expression<String>!
    
    private var tabavatarscolors: Table!
    // private var id: Expression<Int64>!
    private var type: Expression<String>!
    // private var name: Expression<String>!
    private var set: Expression<String>!
    // private var unlocked: Expression<Bool>!
    private var rarity: Expression<String>!
    private var price: Expression<Int64>!
    
    private var newshistory: Table!
    private var quizzid: Expression<String>!
    
    
    init () {
        do {
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            // creating database connection
            db = try Connection("\(path)/badges.sqlite3")
            
            // creating table object
            badges = Table("badges")
            lastquizz = Table("lastquizz")
            questionssave = Table("questionssave")
            activitylogs = Table("activitylogs")
            informations = Table("informations")
            tabfilieres = Table("tabfiliere")
            tabmatieres = Table("tabmatiere")
            tabchapitres = Table("tabchapitres")
            tabquestions = Table("tabquestions")
            tabavatarscolors = Table("tabavatarscolors")
            newshistory = Table("newhistory")
            
            // create instances of each column
            id = Expression<Int64>("id")
            filiere = Expression<String>("filiere")
            title = Expression<String>("title")
            description = Expression<String>("description")
            image = Expression<String>("image")
            reward = Expression<Int64>("reward")
            unlocked = Expression<Bool>("unlocked")
            claimed = Expression<Bool>("claimed")
            
            matiere = Expression<String>("matiere")
            chap = Expression<Int64>("chap")
            chapname = Expression<String>("chapname")
            score = Expression<Int64>("score")
            
            question = Expression<String>("question")
            answer = Expression<String>("answer")
            
            date = Expression<Date>("date")
            daystring = Expression<String>("daystring")
            quizznbr = Expression<Int64>("quizznbr")
            duration = Expression<Double>("duration")
            reussiteperc = Expression<Double>("reussiteperc")
            
            exp = Expression<Int64>("exp")
            money = Expression<Int64>("money")
            quizztotal = Expression<Int64>("quizztotal")
            bonnereptotal = Expression<Int64>("bonnereptotal")
            mauvaisereptotal = Expression<Int64>("mauvaisereptotal")
            tempstotal = Expression<Double>("tempstotal")
            earnedbadge = Expression<Int64>("earnedbadge")
            
            name = Expression<String>("name")
            
            num = Expression<Int64>("num")
            
            shortTitle = Expression<String>("shortTitle")
            sousfiliere = Expression<String>("sousfiliere")
            descf = Expression<String>("descf")
            descsf = Expression<String>("descsf")
            
            numq = Expression<Int64>("numq")
            a = Expression<String>("a")
            b = Expression<String>("b")
            c = Expression<String>("c")
            
            type = Expression<String>("type")
            set = Expression<String>("set")
            rarity = Expression<String>("rarity")
            price = Expression<Int64>("price")
            
            quizzid = Expression<String>("quizzid")
            
            
            
            // check if the user table is already created
            if (!UserDefaults.standard.bool(forKey: "is_db_created")){
                // if not, then create the table
                try db.run(badges.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(filiere)
                    t.column(title)
                    t.column(description)
                    t.column(image)
                    t.column(reward)
                    t.column(unlocked)
                    t.column(claimed)
                })
                
                try db.run(lastquizz.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(matiere)
                    t.column(filiere)
                    t.column(chap)
                    t.column(chapname)
                    t.column(score)
                })
                
                try db.run(questionssave.create { (t) in
                    t.column(id)
                    t.column(question)
                    t.column(answer)
                })
                
                try db.run(activitylogs.create { (t) in
                    t.column(date)
                    t.column(daystring)
                    t.column(quizznbr)
                    t.column(duration)
                    t.column(reussiteperc)
                })
                
                try db.run(informations.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(exp)
                    t.column(money)
                    t.column(quizztotal)
                    t.column(bonnereptotal)
                    t.column(mauvaisereptotal)
                    t.column(tempstotal)
                    t.column(earnedbadge)
                })
                
                try db.run(tabfilieres.create { (t) in
                    t.column(name, primaryKey: true)
                    t.column(sousfiliere)
                })
                
                try db.run(tabmatieres.create { (t) in
                    t.column(title)
                    t.column(filiere)
                    t.column(shortTitle)
                    t.column(sousfiliere)
                    t.column(descf)
                    t.column(descsf)
                })
                
                try db.run(tabchapitres.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(matiere)
                    t.column(filiere)
                    t.column(num)
                })
                
                try db.run(tabquestions.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(filiere)
                    t.column(matiere)
                    t.column(chap)
                    t.column(numq)
                    t.column(question)
                    t.column(a)
                    t.column(b)
                    t.column(c)
                    t.column(answer)
                })
                
                try db.run(tabavatarscolors.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(type)
                    t.column(name)
                    t.column(set)
                    t.column(unlocked)
                    t.column(rarity)
                    t.column(price)
                })
                
                try db.run(newshistory.create { (t) in
                    t.column(quizzid)
                })
                
                
//                // INSERTIONS DES BADGES
//                let badgesmp: [BadgeStruct] = [
//                    BadgeStruct(filiere: "MP", image: "mpphysiquechap1", title: "M??canique", description: "Faites un sans faute sur le chapitre 1 : M??canique du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false),
//                    BadgeStruct(filiere: "MP", image: "mpphysiquechap2", title: "??lectrocin??tique", description: "Faites un sans faute sur le chapitre 2 : ??lectrocin??tique du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false),
//                    BadgeStruct(filiere: "MP", image: "mpphysiquechap3", title: "Thermodynamique", description: "Faites un sans faute sur le chapitre 3 : Themodynamique du programme de MP pour obtenir ce badge.", reward: 100, unlocked: true, claimed: false),
//                    BadgeStruct(filiere: "MP", image: "mpphysiquechap4", title: "Thermochimie", description: "Faites un sans faute sur le chapitre 4 : Thermochimie du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false),
//                    BadgeStruct(filiere: "MP", image: "mpphysiquechap5", title: "Cristallographie", description: "Faites un sans faute sur le chapitre 5 : Cristallographie du programme de MP pour obtenir ce badge.", reward: 100, unlocked: true, claimed: true),
//                    BadgeStruct(filiere: "MP", image: "mpphysiquechap6", title: "Optique ondulatoire", description: "Faites un sans faute sur le chapitre 6 : Optique ondulatoire du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false),
//                    BadgeStruct(filiere: "MP", image: "mpphysiquechap7", title: "??lectrostatique et Magn??tostatique", description: "Faites un sans faute sur le chapitre 7 : ??lectrostatique et Magn??tostatique du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false),
//                    BadgeStruct(filiere: "MP", image: "mpphysiquechap8", title: "??quation de Maxwell", description: "Faites un sans faute sur le chapitre 8 : ??lectrostatique et Magn??tostatique du programme de MP pour obtenir ce badge.", reward: 100, unlocked: true, claimed: false),
//                    BadgeStruct(filiere: "MP", image: "mpphysiquechap9", title: "Propagation et rayonnement", description: "Faites un sans faute sur le chapitre 9 : Propagation et rayonnement du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false),
//                    BadgeStruct(filiere: "MP", image: "mpphysiquechap10", title: "??lectrochimie", description: "Faites un sans faute sur le chapitre 10 : ??lectrochimie du programme de MP pour obtenir ce badge.", reward: 100, unlocked: true, claimed: true),
//                    BadgeStruct(filiere: "MP", image: "mpphysiquechap11", title: "Physique quantique", description: "Faites un sans faute sur le chapitre 11 : Physique quantique du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false),
//                    BadgeStruct(filiere: "MP", image: "mpphysiquechap12", title: "Physique statistique", description: "Faites un sans faute sur le chapitre 12 : Physique statistique du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false)
//                ]
//                let badgesmpsi: [BadgeStruct] = [
//                    BadgeStruct(filiere: "MPSI", image: "mpphysiquechap4", title: "Thermochimie", description: "Faites un sans faute sur le chapitre 4 : Thermochimie du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false),
//                    BadgeStruct(filiere: "MPSI", image: "mpphysiquechap5", title: "Cristallographie", description: "Faites un sans faute sur le chapitre 5 : Cristallographie du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false),
//                    BadgeStruct(filiere: "MPSI", image: "mpphysiquechap6", title: "Optique ondulatoire", description: "Faites un sans faute sur le chapitre 6 : Optique ondulatoire du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false),
//                    BadgeStruct(filiere: "MPSI", image: "mpphysiquechap7", title: "??lectrostatique et Magn??tostatique", description: "Faites un sans faute sur le chapitre 7 : ??lectrostatique et Magn??tostatique du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false),
//                    BadgeStruct(filiere: "MPSI", image: "mpphysiquechap10", title: "??lectrochimie", description: "Faites un sans faute sur le chapitre 10 : ??lectrochimie du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false),
//                    BadgeStruct(filiere: "MPSI", image: "mpphysiquechap11", title: "Physique quantique", description: "Faites un sans faute sur le chapitre 11 : Physique quantique du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false),
//                    BadgeStruct(filiere: "MPSI", image: "mpphysiquechap12", title: "Physique statistique", description: "Faites un sans faute sur le chapitre 12 : Physique statistique du programme de MP pour obtenir ce badge.", reward: 100, unlocked: false, claimed: false)
//                ]
//
//                for badge in badgesmp {
//                    try db.run(badges.insert(filiere <- badge.filiere, title <- badge.title, description <- badge.description, image <- badge.image, reward <- badge.reward, unlocked <- badge.unlocked, claimed <- badge.claimed))
//                }
//                for badge in badgesmpsi {
//                    try db.run(badges.insert(filiere <- badge.filiere, title <- badge.title, description <- badge.description, image <- badge.image, reward <- badge.reward, unlocked <- badge.unlocked, claimed <- badge.claimed))
//                }
                
                
                // INSERTION DES ACTIVITY LOGS
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"

                let testData: [ActivityLogStruct] = [
                    ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date())) ?? Date(), daystring: ["Dimanche", "Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"][Date().get(.weekday)-1], quizznbr: 0, duration: 0, reussiteperc: 0),
                    ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date().addingTimeInterval(-86400))) ?? Date(), daystring: ["Dimanche", "Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"][Date().addingTimeInterval(-86400).get(.weekday)-1], quizznbr: 0, duration: 0, reussiteperc: 0),
                    ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date().addingTimeInterval(-172800))) ?? Date(), daystring: ["Dimanche", "Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"][Date().addingTimeInterval(-172800).get(.weekday)-1], quizznbr: 0, duration: 0, reussiteperc: 0),
                    ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date().addingTimeInterval(-259200))) ?? Date(), daystring: ["Dimanche", "Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"][Date().addingTimeInterval(-259200).get(.weekday)-1], quizznbr: 0, duration: 0, reussiteperc: 0),
                    ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date().addingTimeInterval(-345600))) ?? Date(), daystring: ["Dimanche", "Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"][Date().addingTimeInterval(-345600).get(.weekday)-1], quizznbr: 0, duration: 0, reussiteperc: 0),
                    ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date().addingTimeInterval(-432000))) ?? Date(), daystring: ["Dimanche", "Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"][Date().addingTimeInterval(-432000).get(.weekday)-1], quizznbr: 0, duration: 0, reussiteperc: 0),
                    ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date().addingTimeInterval(-518400))) ?? Date(), daystring: ["Dimanche", "Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"][Date().addingTimeInterval(-518400).get(.weekday)-1], quizznbr: 0, duration: 0, reussiteperc: 0)
                ]
                for activity in testData {
                    try db.run(activitylogs.insert(date <- activity.date, daystring <- activity.daystring, quizznbr <- activity.quizznbr, duration <- activity.duration, reussiteperc <- activity.reussiteperc))
                }
                
                
                // INSERTION DES INFOS DE BASE
                try db.run(informations.insert(exp <- 7,money <- 0, quizztotal <- 0, bonnereptotal <- 0, mauvaisereptotal <- 0, tempstotal <- 0, earnedbadge <- 0))
                
                
                // INSERTION DES FILIERES
                let listefil = [
                    FiliereStruct(name: "MP", sousfiliere: "MPSI"),
                    FiliereStruct(name: "PC", sousfiliere: "PCSI"),
                    FiliereStruct(name: "PSI", sousfiliere: "PCSI"),
                    FiliereStruct(name: "PT", sousfiliere: "PTSI")
                ]
                for filiere in listefil{
                    try db.run(tabfilieres.insert(name <- filiere.name, sousfiliere <- filiere.sousfiliere))
                }
                
                
                // INSERTION DES MATIERES
                let listematmp = [
                    MatiereStruct(title: "Math??matiques", filiere: "MP", shortTitle: "Maths", sousfiliere: "MPSI", descf: "Les quizzs de math??matiques MP regroupe tout ce que tu doit conna??tre sur le programme de l'ann??e, ainsi que les savoirs faire obligatoire pour r??ussir pendant tes ??preuves.", descsf: "Les quizzs de math??matiques MPSI concentrent ce qu'il faut conna??tre du programme ainsi que les pr??requis du lyc??e. Alors si tu d??bute ou termine ta MPSI, tu trouvera de quoi t'entra??ner !"),
                    MatiereStruct(title: "Physique", filiere: "MP", shortTitle: "Physique", sousfiliere: "MPSI", descf: "Les quizzs de physique MP r??unissent tout les savoirs faire et connaissances que tu doit ma??triser pour les concours.", descsf: "Les quizzs de physique MPSI concentrent ce qu'il faut conna??tre du programme ainsi que les pr??requis du lyc??e. Alors si tu d??bute ou termine ta MPSI, tu trouvera de quoi t'entra??ner !"),
                    MatiereStruct(title: "Chimie", filiere: "MP", shortTitle: "Chimie", sousfiliere: "MPSI", descf: "La chimie en MP, bien que courte, n'est pas n??gligeable ! Tu peut donc tester ton niveau et r??viser la chimie gr??ce au diff??rents quizzs.", descsf: "La chimie en MPSI est la grande partie de ceux que tu rencontrera au cours de tes deux ans de pr??pa. Il ne faut donc pas la n??gliger, tu la retrouvera en seconde ann??e !")
                ]
                let listematpc = [
                    MatiereStruct(title: "Math??matiques", filiere: "PC", shortTitle: "Maths", sousfiliere: "PCSI", descf: "Les quizzs de math??matiques PC regroupe tout ce que tu doit conna??tre sur le programme de l'ann??e, ainsi que les savoirs faire obligatoire pour r??ussir pendant tes ??preuves.", descsf: "Les quizzs de math??matiques PCSI concentrent ce qu'il faut conna??tre du programme ainsi que les pr??requis du lyc??e. Alors si tu d??bute ou termine ta PCSI, tu trouvera de quoi t'entra??ner !"),
                    MatiereStruct(title: "Physique", filiere: "PC", shortTitle: "Physique", sousfiliere: "PCSI", descf: "Les quizzs de physique PC r??unissent tout les savoirs faire et connaissances que tu doit ma??triser pour les concours.", descsf: "Les quizzs de physique PCSI concentrent ce qu'il faut conna??tre du programme ainsi que les pr??requis du lyc??e. Alors si tu d??bute ou termine ta PCSI, tu trouvera de quoi t'entra??ner !"),
                    MatiereStruct(title: "Chimie", filiere: "PC", shortTitle: "Chimie", sousfiliere: "PCSI", descf: "Les quizzs de chimie PC regroupe l'int??gralit?? du programme de l'ann??e, tu peut donc v??rifier l'??tat de tes connaissance sur chacun des chapitres.", descsf: "Les quizzs de chimie PCSI regroupe tout ce que tu doit conna??tre du programme de l'ann??e ainsi que les pr??requis du lyc??e. Alors si tu d??bute ou termine ta PCSI, tu trouvera de quoi t'entra??ner !")
                ]
                let listematpsi = [
                    MatiereStruct(title: "Math??matiques", filiere: "PSI", shortTitle: "Maths", sousfiliere: "PCSI", descf: "Les quizzs de math??matiques PSI regroupe tout ce que tu doit conna??tre sur le programme de l'ann??e, ainsi que les savoirs faire obligatoire pour r??ussir pendant tes ??preuves.", descsf: "Les quizzs de math??matiques PCSI concentrent ce qu'il faut conna??tre du programme ainsi que les pr??requis du lyc??e. Alors si tu d??bute ou termine ta PCSI, tu trouvera de quoi t'entra??ner !"),
                    MatiereStruct(title: "Physique", filiere: "PSI", shortTitle: "Physique", sousfiliere: "PCSI", descf: "Les quizzs de physique PSI r??unissent tout les savoirs faire et connaissances que tu doit ma??triser pour les concours.", descsf: "Les quizzs de physique PCSI concentrent ce qu'il faut conna??tre du programme ainsi que les pr??requis du lyc??e. Alors si tu d??bute ou termine ta PCSI, tu trouvera de quoi t'entra??ner !"),
                    MatiereStruct(title: "Chimie", filiere: "PSI", shortTitle: "Chimie", sousfiliere: "PCSI", descf: "Les quizzs de chimie PSI regroupe l'int??gralit?? du programme de l'ann??e, tu peut donc v??rifier l'??tat de tes connaissance sur chacun des chapitres.", descsf: "Les quizzs de chimie PCSI concentrent ce qu'il faut conna??tre du programme ainsi que les pr??requis du lyc??e. Alors si tu d??bute ou termine ta PCSI, tu trouvera de quoi t'entra??ner !")
                ]
                let listematpt = [
                    MatiereStruct(title: "Math??matiques", filiere: "PT", shortTitle: "Maths", sousfiliere: "PTSI", descf: "Les quizzs de math??matiques PT regroupe tout ce que tu doit conna??tre sur le programme de l'ann??e, ainsi que les savoirs faire obligatoire pour r??ussir pendant tes ??preuves.", descsf: "Les quizzs de math??matiques PTSI concentrent ce qu'il faut conna??tre du programme ainsi que les pr??requis du lyc??e. Alors si tu d??bute ou termine ta PTSI, tu trouvera de quoi t'entra??ner !"),
                    MatiereStruct(title: "Physique", filiere: "PT", shortTitle: "Physique", sousfiliere: "PTSI", descf: "Les quizzs de physique PT r??unissent tout les savoirs faire et connaissances que tu doit ma??triser pour les concours.", descsf: "Les quizzs de physique PTSI concentrent ce qu'il faut conna??tre du programme ainsi que les pr??requis du lyc??e. Alors si tu d??bute ou termine ta PTSI, tu trouvera de quoi t'entra??ner !"),
                    MatiereStruct(title: "Chimie", filiere: "PT", shortTitle: "Chimie", sousfiliere: "PTSI", descf: "Les quizzs de chimie PT regroupe l'int??gralit?? du programme de l'ann??e, tu peut donc v??rifier l'??tat de tes connaissance sur chacun des chapitres.", descsf: "Les quizzs de chimie PTSI regroupe tout ce que tu doit conna??tre du programme de l'ann??e ainsi que les pr??requis du lyc??e. Alors si tu d??bute ou termine ta PTSI, tu trouvera de quoi t'entra??ner !")
                ]
                
                let listematfil = [listematmp, listematpc, listematpsi, listematpt]
                
                for listemat in listematfil{
                    for matiere in listemat{
                        try db.run(tabmatieres.insert(title <- matiere.title, filiere <- matiere.filiere, shortTitle <- matiere.shortTitle, sousfiliere <- matiere.sousfiliere, descf <- matiere.descf, descsf <- matiere.descsf))
                    }
                }
                
                
                // INSERTION DES CHAPITRES
                
                    //MP
                let chapphysmp: [ChapitreStruct] = [
                    ChapitreStruct(name: "M??canique", matiere: "Physique", filiere: "MP", num: 1),
                    ChapitreStruct(name: "??l??ctrocin??tique", matiere: "Physique", filiere: "MP", num: 2),
                    ChapitreStruct(name: "Thermodynamique", matiere: "Physique", filiere: "MP", num: 3),
                    ChapitreStruct(name: "Thermochimie", matiere: "Physique", filiere: "MP", num: 4),
                    ChapitreStruct(name: "Optique ondulatoire", matiere: "Physique", filiere: "MP", num: 5),
                    ChapitreStruct(name: "??l??ctrostatique et Magn??tostatique", matiere: "Physique", filiere: "MP", num: 6),
                    ChapitreStruct(name: "??quations de Maxwell", matiere: "Physique", filiere: "MP", num: 7),
                    ChapitreStruct(name: "Propagation et rayonnement", matiere: "Physique", filiere: "MP", num: 8),
                    ChapitreStruct(name: "??l??ctrochimie", matiere: "Physique", filiere: "MP", num: 9),
                    ChapitreStruct(name: "Physique quantique", matiere: "Physique", filiere: "MP", num: 10),
                    ChapitreStruct(name: "Physique statistique", matiere: "Physique", filiere: "MP", num: 11)
                ]
                let chapmathsmp : [ChapitreStruct] = [
                    ChapitreStruct(name: "Structures alg??briques usuelles", matiere: "Math??matiques", filiere: "MP", num: 1),
                    ChapitreStruct(name: "R??duction d'endomorphisme", matiere: "Math??matiques", filiere: "MP", num: 2),
                    ChapitreStruct(name: "Fonction convexes", matiere: "Math??matiques", filiere: "MP", num: 3),
                    ChapitreStruct(name: "Topologie des espaces vectoriels norm??s",  matiere: "Math??matiques", filiere: "MP", num: 4),
                    ChapitreStruct(name: "Espaces pr??hilbertiens r??els", matiere: "Math??matiques", filiere: "MP", num: 5),
                    ChapitreStruct(name: "S??ries et famille sommables", matiere: "Math??matiques", filiere: "MP", num: 6),
                    ChapitreStruct(name: "Suite et s??ries de fonctions", matiere: "Math??matiques", filiere: "MP", num: 7),
                    ChapitreStruct(name: "S??ries enti??res", matiere: "Math??matiques", filiere: "MP", num: 8),
                    ChapitreStruct(name: "Fonctions vectorielles, arcs param??tr??s", matiere: "Math??matiques", filiere: "MP", num: 9),
                    ChapitreStruct(name: "Int??gration sur un intervalle quelconque", matiere: "Math??matiques", filiere: "MP", num: 10),
                    ChapitreStruct(name: "Variable al??atoire disc??tes", matiere: "Math??matiques", filiere: "MP", num: 11),
                    ChapitreStruct(name: "??quations diff??rentielles lin??aires", matiere: "Math??matiques", filiere: "MP", num: 12),
                    ChapitreStruct(name: "Calcul diff??rentiel", matiere: "Math??matiques", filiere: "MP", num: 13)
                ]
                let chapchimiemp = [
                    ChapitreStruct(name: "Thermodynamique", matiere: "Chimie", filiere: "MP", num: 1),
                    ChapitreStruct(name: "??lectrochimie", matiere: "Chimie", filiere: "MP", num: 2),
                    ChapitreStruct(name: "Cristallographie", matiere: "Chimie", filiere: "MP", num: 3),
                ]
                let chapmp = [chapphysmp, chapmathsmp, chapchimiemp]
                    //MPSI
                let chapmathsmpsi = [
                    ChapitreStruct(name: "Raisonnement et vocabulaire ensembliste", matiere: "Math??matiques", filiere: "MPSI", num: 1),
                    ChapitreStruct(name: "Calculs alg??brique", matiere: "Math??matiques", filiere: "MPSI", num: 2),
                    ChapitreStruct(name: "Nombres complexes et trigonome??trie", matiere: "Math??matiques", filiere: "MPSI", num: 3),
                    ChapitreStruct(name: "Technique fondamentales de calcul en analyse", matiere: "Math??matiques", filiere: "MPSI", num: 4),
                    ChapitreStruct(name: "Nombre r??els et suite num??riques", matiere: "Math??matiques", filiere: "MPSI", num: 5),
                    ChapitreStruct(name: "Limites, continuit?? et d??rivabilit??", matiere: "Math??matiques", filiere: "MPSI", num: 6),
                    ChapitreStruct(name: "Analyse asymptotique", matiere: "Math??matiques", filiere: "MPSI", num: 7),
                    ChapitreStruct(name: "Arithm??tique dans l'ensemble des entiers relatifs", matiere: "Math??matiques", filiere: "MPSI", num: 8),
                    ChapitreStruct(name: "Structures alg??brique usuelles", matiere: "Math??matiques", filiere: "MPSI", num: 9),
                    ChapitreStruct(name: "Polyn??mes et fractions rationnelles", matiere: "Math??matiques", filiere: "MPSI", num: 10),
                    ChapitreStruct(name: "Espaces vectoriels et applications lin??aires", matiere: "Math??matiques", filiere: "MPSI", num: 11),
                    ChapitreStruct(name: "Matrices", matiere: "Math??matiques", filiere: "MPSI", num: 12),
                    ChapitreStruct(name: "Groupe sym??trique et d??terminants", matiere: "Math??matiques", filiere: "MPSI", num: 13),
                    ChapitreStruct(name: "Espaces pr??hilbertiens r??els", matiere: "Math??matiques", filiere: "MPSI", num: 14),
                    ChapitreStruct(name: "Int??gration", matiere: "Math??matiques", filiere: "MPSI", num: 15),
                    ChapitreStruct(name: "S??ries num??riques", matiere: "Math??matiques", filiere: "MPSI", num: 16),
                    ChapitreStruct(name: "D??nombrement", matiere: "Math??matiques", filiere: "MPSI", num: 17),
                    ChapitreStruct(name: "Probabilit??s", matiere: "Math??matiques", filiere: "MPSI", num: 18)
                ]
                let chapphysmpsi : [ChapitreStruct] = [
                    ChapitreStruct(name: "Oscillateur harmonique", matiere: "Physique", filiere: "MPSI", num: 1),
                    ChapitreStruct(name: "Ondes", matiere: "Physique", filiere: "MPSI", num: 2),
                    ChapitreStruct(name: "Bases de l'optique g??om??trique", matiere: "Physique", filiere: "MPSI", num: 3),
                    ChapitreStruct(name: "Lentilles minces", matiere: "Physique", filiere: "MPSI", num: 4),
                    ChapitreStruct(name: "Introduction au monde quantique", matiere: "Physique", filiere: "MPSI", num: 5),
                    ChapitreStruct(name: "Lois de l'??lectrocin??tique", matiere: "Physique", filiere: "MPSI", num: 6),
                    ChapitreStruct(name: "R??gime transitoire", matiere: "Physique", filiere: "MPSI", num: 7),
                    ChapitreStruct(name: "R??gime sinuso??dal forc??", matiere: "Physique", filiere: "MPSI", num: 8),
                    ChapitreStruct(name: "Filtrage lin??aire", matiere: "Physique", filiere: "MPSI", num: 9),
                    ChapitreStruct(name: "Cin??matique du point et du solide", matiere: "Physique", filiere: "MPSI", num: 10),
                    ChapitreStruct(name: "Principes de la dynamique", matiere: "Physique", filiere: "MPSI", num: 11),
                    ChapitreStruct(name: "??nergie, puissance et travail m??caniques", matiere: "Physique", filiere: "MPSI", num: 12),
                    ChapitreStruct(name: "Moment cin??tique", matiere: "Physique", filiere: "MPSI", num: 13),
                    ChapitreStruct(name: "Thermodynamique", matiere: "Physique", filiere: "MPSI", num: 14),
                    ChapitreStruct(name: "Induction", matiere: "Physique", filiere: "MPSI", num: 15)
                ]
                let chapchimiempsi = [
                    ChapitreStruct(name: "??tats et ??volution d'un syst??me chimique", matiere: "Chimie", filiere: "MPSI", num: 1),
                    ChapitreStruct(name: "Cin??tique chimique", matiere: "Chimie", filiere: "MPSI", num: 2),
                    ChapitreStruct(name: "Structure ??lectronique", matiere: "Chimie", filiere: "MPSI", num: 3),
                    ChapitreStruct(name: "Mol??cules et solvants", matiere: "Chimie", filiere: "MPSI", num: 4),
                    ChapitreStruct(name: "Cristallographie", matiere: "Chimie", filiere: "MPSI", num: 5),
                    ChapitreStruct(name: "R??actions acido-basiques", matiere: "Chimie", filiere: "MPSI", num: 6),
                    ChapitreStruct(name: "R??actions de pr??cipitation", matiere: "Chimie", filiere: "MPSI", num: 7),
                    ChapitreStruct(name: "R??actions d'oxydo-r??duction", matiere: "Chimie", filiere: "MPSI", num: 8),
                    ChapitreStruct(name: "Diagrammes potentiel-pH", matiere: "Chimie", filiere: "MPSI", num: 9)
                ]
                let chapmpsi = [chapmathsmpsi, chapphysmpsi, chapchimiempsi]
                
                    //PC
                let chapmathpc = [
                    ChapitreStruct(name: "Alg??bre lin??aire", matiere: "Math??matiques", filiere: "PC", num: 1),
                    ChapitreStruct(name: "Espaces euclidiens", matiere: "Math??matiques", filiere: "PC", num: 2),
                    ChapitreStruct(name: "Espaces vectoriels norm??s de dimension finie", matiere: "Math??matiques", filiere: "PC", num: 3),
                    ChapitreStruct(name: "Suites et s??ries", matiere: "Math??matiques", filiere: "PC", num: 4),
                    ChapitreStruct(name: "Fonctions vectorielles, arc param??tr??s", matiere: "Math??matiques", filiere: "PC", num: 5),
                    ChapitreStruct(name: "Int??gration", matiere: "Math??matiques", filiere: "PC", num: 6),
                    ChapitreStruct(name: "Probabilit??s", matiere: "Math??matiques", filiere: "PC", num: 7),
                    ChapitreStruct(name: "Calcul diff??rentiel", matiere: "Math??matiques", filiere: "PC", num: 8),
                    ChapitreStruct(name: "??quations diff??rentielles lin??aires", matiere: "Math??matiques", filiere: "PC", num: 9)
                ]
                let chapphysiquepc = [
                    ChapitreStruct(name: "Optique", matiere: "Physique", filiere: "PC", num: 1),
                    ChapitreStruct(name: "Thermodynamique", matiere: "Physique", filiere: "PC", num: 2),
                    ChapitreStruct(name: "M??canique", matiere: "Physique", filiere: "PC", num: 3),
                    ChapitreStruct(name: "??lectromagn??tisme", matiere: "Physique", filiere: "PC", num: 4),
                    ChapitreStruct(name: "Physique des ondes", matiere: "Physique", filiere: "PC", num: 5)
                ]
                let chapchimiepc = [
                    ChapitreStruct(name: "Thermodynamique", matiere: "Chimie", filiere: "PC", num: 1),
                    ChapitreStruct(name: "Oxydor??duction", matiere: "Chimie", filiere: "PC", num: 2),
                    ChapitreStruct(name: "Chimie organique", matiere: "Chimie", filiere: "PC", num: 3),
                    ChapitreStruct(name: "Chimie quantique", matiere: "Chimie", filiere: "PC", num: 4)
                ]
                let chappc = [chapmathpc, chapphysiquepc, chapchimiepc]
                
                    //PCSI
                let chapmathpcsi = [
                    ChapitreStruct(name: "Raisonnement et vocabulaire ensembliste", matiere: "Math??matiques", filiere: "PCSI", num: 1),
                    ChapitreStruct(name: "Nombres complexes et trigonome??trie", matiere: "Math??matiques", filiere: "PCSI", num: 2),
                    ChapitreStruct(name: "Calculs alg??brique", matiere: "Math??matiques", filiere: "PCSI", num: 3),
                    ChapitreStruct(name: "Technique fondamentales de calcul en analyse", matiere: "Math??matiques", filiere: "PCSI", num: 4),
                    ChapitreStruct(name: "Nombre r??els et suite num??riques", matiere: "Math??matiques", filiere: "PCSI", num: 5),
                    ChapitreStruct(name: "Limites, continuit?? et d??rivabilit??", matiere: "Math??matiques", filiere: "PCSI", num: 6),
                    ChapitreStruct(name: "Analyse asymptotique", matiere: "Math??matiques", filiere: "PCSI", num: 7),
                    ChapitreStruct(name: "Syst??me lin??aires et calcul matriciel", matiere: "Math??matiques", filiere: "PCSI", num: 8),
                    ChapitreStruct(name: "Entiers natuels et d??nombrement", matiere: "Math??matiques", filiere: "PCSI", num: 9),
                    ChapitreStruct(name: "Polyn??mes", matiere: "Math??matiques", filiere: "PCSI", num: 10),
                    ChapitreStruct(name: "Espaces vectoriels et applications lin??aires", matiere: "Math??matiques", filiere: "PCSI", num: 11),
                    ChapitreStruct(name: "Matrices et d??terminants", matiere: "Math??matiques", filiere: "PCSI", num: 12),
                    ChapitreStruct(name: "Int??gration", matiere: "Math??matiques", filiere: "PCSI", num: 13),
                    ChapitreStruct(name: "S??ries num??riques", matiere: "Math??matiques", filiere: "PCSI", num: 14),
                    ChapitreStruct(name: "Produit scalaire et espaces euclidiens", matiere: "Math??matiques", filiere: "PCSI", num: 15),
                    ChapitreStruct(name: "Probabilit??s", matiere: "Math??matiques", filiere: "PCSI", num: 16)
                ]
                let chapphysiquepcsi = [
                    ChapitreStruct(name: "Signaux physiques", matiere: "Physique", filiere: "PCSI", num: 1),
                    ChapitreStruct(name: "M??canique", matiere: "Physique", filiere: "PCSI", num: 2),
                    ChapitreStruct(name: "Thermodynamique", matiere: "Physique", filiere: "PCSI", num: 3),
                    ChapitreStruct(name: "Statique des fluides", matiere: "Physique", filiere: "PCSI", num: 4),
                    ChapitreStruct(name: "Induction et forces de Laplace", matiere: "Physique", filiere: "PCSI", num: 5)
                ]
                let chapchimiepcsi = [
                    ChapitreStruct(name: "Transformation de la mati??re", matiere: "Chimie", filiere: "PCSI", num: 1),
                    ChapitreStruct(name: "Architecture de la mati??re", matiere: "Chimie", filiere: "PCSI", num: 2),
                    ChapitreStruct(name: "Structure, r??activit?? et transformations en chimie organique", matiere: "Chimie", filiere: "PCSI", num: 3),
                    ChapitreStruct(name: "Cristallographie", matiere: "Chimie", filiere: "PCSI", num: 4),
                    ChapitreStruct(name: "Transformations chimique en solutions aqueuses", matiere: "Chimie", filiere: "PCSI", num: 5)
                ]
                let chappcsi = [chapmathpcsi, chapphysiquepcsi, chapchimiepcsi]
                
                    //PSI
                let chapmathpsi = [
                    ChapitreStruct(name: "Espaces pr??hilbertiens r??els, espaces euclidiens", matiere: "Math??matiques", filiere: "PSI", num: 1),
                    ChapitreStruct(name: "Espaces vectoriels norm??s de dimension finie", matiere: "Math??matiques", filiere: "PSI", num: 2),
                    ChapitreStruct(name: "Suites et s??ries", matiere: "Math??matiques", filiere: "PSI", num: 3),
                    ChapitreStruct(name: "Fonctions vectorielles", matiere: "Math??matiques", filiere: "PSI", num: 4),
                    ChapitreStruct(name: "Int??gration", matiere: "Math??matiques", filiere: "PSI", num: 5),
                    ChapitreStruct(name: "Probabilit??s", matiere: "Math??matiques", filiere: "PSI", num: 6),
                    ChapitreStruct(name: "Calcul diff??rentiel", matiere: "Math??matiques", filiere: "PSI", num: 7),
                    ChapitreStruct(name: "??quations diff??rentielles lin??aires", matiere: "Math??matiques", filiere: "PSI", num: 8)
                ]
                let chapphysiquepsi = [
                    ChapitreStruct(name: "??lectronique", matiere: "Physique", filiere: "PSI", num: 1),
                    ChapitreStruct(name: "Ph??nom??nes de transports", matiere: "Physique", filiere: "PSI", num: 2),
                    ChapitreStruct(name: "Bilans macroscopiques", matiere: "Physique", filiere: "PSI", num: 3),
                    ChapitreStruct(name: "??lectromagnetisme", matiere: "Physique", filiere: "PSI", num: 4),
                    ChapitreStruct(name: "Conversion de puissance", matiere: "Physique", filiere: "PSI", num: 5),
                    ChapitreStruct(name: "Physique des ondes", matiere: "Physique", filiere: "PSI", num: 6)
                ]
                let chapchimiepsi = [
                    ChapitreStruct(name: "Thermodynamique des transformations physico-chimiques", matiere: "Chimie", filiere: "PSI", num: 1),
                    ChapitreStruct(name: "??lectrochimie", matiere: "Chimie", filiere: "PSI", num: 2),
                ]
                let chappsi = [chapphysiquepsi, chapmathpsi, chapchimiepsi]
                
                    //PT
                let chapmathpt = [
                    ChapitreStruct(name: "Alg??bre lin??aire", matiere: "Math??matiques", filiere: "PT", num: 1),
                    ChapitreStruct(name: "Espaces vectoriels pr??hilbertiens", matiere: "Math??matiques", filiere: "PT", num: 2),
                    ChapitreStruct(name: "Fonctions vectorielles", matiere: "Math??matiques", filiere: "PT", num: 3),
                    ChapitreStruct(name: "Int??grales g??n??ralis??es", matiere: "Math??matiques", filiere: "PT", num: 4),
                    ChapitreStruct(name: "S??ries num??riques", matiere: "Math??matiques", filiere: "PT", num: 5),
                    ChapitreStruct(name: "S??ries enti??res", matiere: "Math??matiques", filiere: "PT", num: 6),
                    ChapitreStruct(name: "Probabilit??s discr??tes", matiere: "Math??matiques", filiere: "PT", num: 7),
                    ChapitreStruct(name: "??quations diff??rentielles et syst??mes diff??rentiels", matiere: "Math??matiques", filiere: "PT", num: 8),
                    ChapitreStruct(name: "Fonctions de deux ou trois variables", matiere: "Math??matiques", filiere: "PT", num: 9),
                    ChapitreStruct(name: "Courbes et surfaces dans l'espace", matiere: "Math??matiques", filiere: "PT", num: 10)
                ]
                let chapphysiquept = [
                    ChapitreStruct(name: "Thermodynamique", matiere: "Physique", filiere: "PT", num: 1),
                    ChapitreStruct(name: "M??canique des fluides", matiere: "Physique", filiere: "PT", num: 2),
                    ChapitreStruct(name: "??lectronique", matiere: "Physique", filiere: "PT", num: 3),
                    ChapitreStruct(name: "Optique", matiere: "Physique", filiere: "PT", num: 4),
                    ChapitreStruct(name: "??lectromagn??tisme", matiere: "Physique", filiere: "PT", num: 5)
                ]
                let chapchimiept = [
                    ChapitreStruct(name: "Thermodynamique de la transformation chimique", matiere: "Chimie", filiere: "PT", num: 1),
                    ChapitreStruct(name: "??lectrochimie", matiere: "Chimie", filiere: "PT", num: 2)
                ]
                let chappt = [chapmathpt, chapphysiquept, chapchimiept]
                
                    //PTSI
                let chapmathptsi = [
                    ChapitreStruct(name: "Raisonnement et vocabulaire ensembliste", matiere: "Math??matiques", filiere: "PTSI", num: 1),
                    ChapitreStruct(name: "Nombres complexes et trigonome??trie", matiere: "Math??matiques", filiere: "PTSI", num: 2),
                    ChapitreStruct(name: "Calculs alg??brique", matiere: "Math??matiques", filiere: "PTSI", num: 3),
                    ChapitreStruct(name: "Technique fondamentales de calcul en analyse", matiere: "Math??matiques", filiere: "PTSI", num: 4),
                    ChapitreStruct(name: "Nombre r??els et suite num??riques", matiere: "Math??matiques", filiere: "PTSI", num: 5),
                    ChapitreStruct(name: "Limites, continuit?? et d??rivabilit??", matiere: "Math??matiques", filiere: "PTSI", num: 6),
                    ChapitreStruct(name: "Syst??me lin??aires et calcul matriciel", matiere: "Math??matiques", filiere: "PTSI", num: 7),
                    ChapitreStruct(name: "Entiers natuels et d??nombrement", matiere: "Math??matiques", filiere: "PTSI", num: 8),
                    ChapitreStruct(name: "G??om??trie du plan et de l'espace", matiere: "Math??matiques", filiere: "PTSI", num: 9),
                    ChapitreStruct(name: "Polyn??mes", matiere: "Math??matiques", filiere: "PTSI", num: 10),
                    ChapitreStruct(name: "Espaces vectoriels et applications lin??aires", matiere: "Math??matiques", filiere: "PTSI", num: 11),
                    ChapitreStruct(name: "Matrices et d??terminants", matiere: "Math??matiques", filiere: "PTSI", num: 12),
                    ChapitreStruct(name: "Int??gration", matiere: "Math??matiques", filiere: "PTSI", num: 13),
                    ChapitreStruct(name: "Analyse asymptotique", matiere: "Math??matiques", filiere: "PTSI", num: 14),
                    ChapitreStruct(name: "S??ries num??riques", matiere: "Math??matiques", filiere: "PTSI", num: 15),
                    ChapitreStruct(name: "Probabilit??s", matiere: "Math??matiques", filiere: "PTSI", num: 16)
                ]
                let chapphysiqueptsi = [
                    ChapitreStruct(name: "Signaux physiques", matiere: "Physique", filiere: "PTSI", num: 1),
                    ChapitreStruct(name: "M??canique", matiere: "Physique", filiere: "PTSI", num: 2),
                    ChapitreStruct(name: "Thermodynamique", matiere: "Physique", filiere: "PTSI", num: 3),
                    ChapitreStruct(name: "Induction et forces de Laplace", matiere: "Physique", filiere: "PTSI", num: 4)
                ]
                let chapchimieptsi = [
                    ChapitreStruct(name: "Transformation de la mati??re", matiere: "Chimie", filiere: "PTSI", num: 1),
                    ChapitreStruct(name: "Architecture de la mati??re", matiere: "Chimie", filiere: "PTSI", num: 2),
                    ChapitreStruct(name: "Cristallographie", matiere: "Chimie", filiere: "PTSI", num: 3),
                    ChapitreStruct(name: "Transformation chimique en solution aqueuse", matiere: "Chimie", filiere: "PTSI", num: 4)
                ]
                let chapptsi = [chapmathptsi, chapphysiqueptsi, chapchimieptsi]
                
                let listechap = [chapmp, chapmpsi, chappc, chappcsi, chappsi, chappt, chapptsi]
                
                for chapfil in listechap{
                    for chaps in chapfil {
                        for chap in chaps {
                            try db.run(tabchapitres.insert(name <- chap.name, matiere <- chap.matiere, filiere <- chap.filiere, num <- chap.num))
                        }
                    }
                }
                
                
                // INSERTION DES AVATARS
                let baseset: [AvatarColor] = [
                    AvatarColor(type: "avatar", name: "baseset1", set: "Base", unlocked: true, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "baseset2", set: "Base", unlocked: true, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "baseset3", set: "Base", unlocked: true, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "baseset4", set: "Base", unlocked: true, rarity: "common", price: 0)]
                
                let heroset: [AvatarColor] = [
                    AvatarColor(type: "avatar", name: "heroset1", set: "H??roique", unlocked: false, rarity: "common", price: 100),
                    AvatarColor(type: "avatar", name: "heroset2", set: "H??roique", unlocked: false, rarity: "common", price: 125),
                    AvatarColor(type: "avatar", name: "heroset3", set: "H??roique", unlocked: false, rarity: "common", price: 150),
                    AvatarColor(type: "avatar", name: "heroset4", set: "H??roique", unlocked: false, rarity: "rare", price: 175),
                    AvatarColor(type: "avatar", name: "heroset5", set: "H??roique", unlocked: false, rarity: "rare", price: 200),
                    AvatarColor(type: "avatar", name: "heroset6", set: "H??roique", unlocked: false, rarity: "epic", price: 225),
                    AvatarColor(type: "avatar", name: "heroset7", set: "H??roique", unlocked: false, rarity: "epic", price: 250),
                    AvatarColor(type: "avatar", name: "heroset8", set: "H??roique", unlocked: false, rarity: "legendary", price: 275),
                    AvatarColor(type: "avatar", name: "heroset9", set: "H??roique", unlocked: false, rarity: "legendary", price: 300)]
                
                let medievalset: [AvatarColor] = [
                    AvatarColor(type: "avatar", name: "medievalset1", set: "M??di??val", unlocked: false, rarity: "common", price: 100),
                    AvatarColor(type: "avatar", name: "medievalset2", set: "M??di??val", unlocked: false, rarity: "common", price: 125),
                    AvatarColor(type: "avatar", name: "medievalset3", set: "M??di??val", unlocked: false, rarity: "rare", price: 150),
                    AvatarColor(type: "avatar", name: "medievalset4", set: "M??di??val", unlocked: false, rarity: "rare", price: 175),
                    AvatarColor(type: "avatar", name: "medievalset5", set: "M??di??val", unlocked: false, rarity: "rare", price: 200),
                    AvatarColor(type: "avatar", name: "medievalset6", set: "M??di??val", unlocked: false, rarity: "rare", price: 225),
                    AvatarColor(type: "avatar", name: "medievalset7", set: "M??di??val", unlocked: false, rarity: "epic", price: 250),
                    AvatarColor(type: "avatar", name: "medievalset8", set: "M??di??val", unlocked: false, rarity: "epic", price: 275),
                    AvatarColor(type: "avatar", name: "medievalset9", set: "M??di??val", unlocked: false, rarity: "legendary", price: 300)]
                
                let fairyset: [AvatarColor] = [
                    AvatarColor(type: "avatar", name: "fairyset1", set: "Fantastique", unlocked: false, rarity: "common", price: 100),
                    AvatarColor(type: "avatar", name: "fairyset2", set: "Fantastique", unlocked: false, rarity: "common", price: 125),
                    AvatarColor(type: "avatar", name: "fairyset3", set: "Fantastique", unlocked: false, rarity: "rare", price: 150),
                    AvatarColor(type: "avatar", name: "fairyset4", set: "Fantastique", unlocked: false, rarity: "rare", price: 175),
                    AvatarColor(type: "avatar", name: "fairyset5", set: "Fantastique", unlocked: false, rarity: "rare", price: 200),
                    AvatarColor(type: "avatar", name: "fairyset6", set: "Fantastique", unlocked: false, rarity: "epic", price: 225),
                    AvatarColor(type: "avatar", name: "fairyset7", set: "Fantastique", unlocked: false, rarity: "epic", price: 250),
                    AvatarColor(type: "avatar", name: "fairyset8", set: "Fantastique", unlocked: false, rarity: "epic", price: 275),
                    AvatarColor(type: "avatar", name: "fairyset9", set: "Fantastique", unlocked: false, rarity: "legendary", price: 300)]
                
                let animalset: [AvatarColor] = [
                    AvatarColor(type: "avatar", name: "animalset1", set: "Animal", unlocked: false, rarity: "common", price: 100),
                    AvatarColor(type: "avatar", name: "animalset2", set: "Animal", unlocked: false, rarity: "common", price: 125),
                    AvatarColor(type: "avatar", name: "animalset3", set: "Animal", unlocked: false, rarity: "common", price: 150),
                    AvatarColor(type: "avatar", name: "animalset4", set: "Animal", unlocked: false, rarity: "common", price: 175),
                    AvatarColor(type: "avatar", name: "animalset5", set: "Animal", unlocked: false, rarity: "rare", price: 200),
                    AvatarColor(type: "avatar", name: "animalset6", set: "Animal", unlocked: false, rarity: "epic", price: 225),
                    AvatarColor(type: "avatar", name: "animalset7", set: "Animal", unlocked: false, rarity: "epic", price: 250),
                    AvatarColor(type: "avatar", name: "animalset8", set: "Animal", unlocked: false, rarity: "epic", price: 275),
                    AvatarColor(type: "avatar", name: "animalset9", set: "Animal", unlocked: false, rarity: "legendary", price: 300)]
                
                let randomset: [AvatarColor] = [
                    AvatarColor(type: "avatar", name: "randomset1", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset2", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset3", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset4", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset5", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset6", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset7", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset8", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset9", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset10", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset11", set: "Al??atoire", unlocked: false, rarity: "epic", price: 0),
                    AvatarColor(type: "avatar", name: "randomset12", set: "Al??atoire", unlocked: false, rarity: "legendary", price: 0),
                    AvatarColor(type: "avatar", name: "randomset13", set: "Al??atoire", unlocked: false, rarity: "legendary", price: 0),
                    AvatarColor(type: "avatar", name: "randomset14", set: "Al??atoire", unlocked: false, rarity: "epic", price: 0),
                    AvatarColor(type: "avatar", name: "randomset15", set: "Al??atoire", unlocked: false, rarity: "epic", price: 0),
                    AvatarColor(type: "avatar", name: "randomset16", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset17", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset18", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset19", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset20", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset21", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset22", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset23", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset24", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset25", set: "Al??atoire", unlocked: false, rarity: "epic", price: 0),
                    AvatarColor(type: "avatar", name: "randomset26", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset27", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset28", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset29", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset30", set: "Al??atoire", unlocked: false, rarity: "epic", price: 0),
                    AvatarColor(type: "avatar", name: "randomset31", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset32", set: "Al??atoire", unlocked: false, rarity: "epic", price: 0),
                    AvatarColor(type: "avatar", name: "randomset33", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset34", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset35", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset36", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset37", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset38", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset39", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset40", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset41", set: "Al??atoire", unlocked: false, rarity: "epic", price: 0),
                    AvatarColor(type: "avatar", name: "randomset42", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset43", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset44", set: "Al??atoire", unlocked: false, rarity: "legendary", price: 0),
                    AvatarColor(type: "avatar", name: "randomset45", set: "Al??atoire", unlocked: false, rarity: "epic", price: 0),
                    AvatarColor(type: "avatar", name: "randomset46", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset47", set: "Al??atoire", unlocked: false, rarity: "epic", price: 0),
                    AvatarColor(type: "avatar", name: "randomset48", set: "Al??atoire", unlocked: false, rarity: "epic", price: 0),
                    AvatarColor(type: "avatar", name: "randomset49", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset50", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset51", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0),
                    AvatarColor(type: "avatar", name: "randomset52", set: "Al??atoire", unlocked: false, rarity: "epic", price: 0),
                    AvatarColor(type: "avatar", name: "randomset53", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset54", set: "Al??atoire", unlocked: false, rarity: "legendary", price: 0),
                    AvatarColor(type: "avatar", name: "randomset55", set: "Al??atoire", unlocked: false, rarity: "epic", price: 0),
                    AvatarColor(type: "avatar", name: "randomset56", set: "Al??atoire", unlocked: false, rarity: "epic", price: 0),
                    AvatarColor(type: "avatar", name: "randomset57", set: "Al??atoire", unlocked: false, rarity: "common", price: 0),
                    AvatarColor(type: "avatar", name: "randomset58", set: "Al??atoire", unlocked: false, rarity: "rare", price: 0)
                ]
                
                let avatars: [[AvatarColor]] = [baseset, heroset, medievalset, fairyset, animalset, randomset]
                for sets in avatars{
                    for avatar in sets{
                        try db.run(tabavatarscolors.insert(type <- avatar.type, name <- avatar.name, set <- avatar.set, unlocked <- avatar.unlocked, rarity <- avatar.rarity, price <- avatar.price))
                    }
                }
                
                // INSERTION DES COULEURS
                
                let basepalette: [AvatarColor] = [
                    AvatarColor(type: "color", name: "basepalette1", set: "Base", unlocked: true, rarity: "common", price: 0),
                    AvatarColor(type: "color", name: "basepalette2", set: "Base", unlocked: true, rarity: "common", price: 0),
                    AvatarColor(type: "color", name: "basepalette3", set: "Base", unlocked: true, rarity: "common", price: 0),
                    AvatarColor(type: "color", name: "basepalette4", set: "Base", unlocked: true, rarity: "common", price: 0)]
                
                let ambiancepalette: [AvatarColor] = [
                    AvatarColor(type: "color", name: "ambiancepalette1", set: "Ambiance", unlocked: false, rarity: "common", price: 100),
                    AvatarColor(type: "color", name: "ambiancepalette2", set: "Ambiance", unlocked: false, rarity: "common", price: 125),
                    AvatarColor(type: "color", name: "ambiancepalette3", set: "Ambiance", unlocked: false, rarity: "common", price: 150),
                    AvatarColor(type: "color", name: "ambiancepalette4", set: "Ambiance", unlocked: false, rarity: "rare", price: 175),
                    AvatarColor(type: "color", name: "ambiancepalette5", set: "Ambiance", unlocked: false, rarity: "rare", price: 200),
                    AvatarColor(type: "color", name: "ambiancepalette6", set: "Ambiance", unlocked: false, rarity: "rare", price: 225),
                    AvatarColor(type: "color", name: "ambiancepalette7", set: "Ambiance", unlocked: false, rarity: "epic", price: 250),
                    AvatarColor(type: "color", name: "ambiancepalette8", set: "Ambiance", unlocked: false, rarity: "epic", price: 275),
                    AvatarColor(type: "color", name: "ambiancepalette9", set: "Ambiance", unlocked: false, rarity: "legendary", price: 300)]
                
                let peachpalette: [AvatarColor] = [
                    AvatarColor(type: "color", name: "peachpalette1", set: "P??che", unlocked: false, rarity: "common", price: 100),
                    AvatarColor(type: "color", name: "peachpalette2", set: "P??che", unlocked: false, rarity: "common", price: 125),
                    AvatarColor(type: "color", name: "peachpalette3", set: "P??che", unlocked: false, rarity: "common", price: 150),
                    AvatarColor(type: "color", name: "peachpalette4", set: "P??che", unlocked: false, rarity: "rare", price: 175),
                    AvatarColor(type: "color", name: "peachpalette5", set: "P??che", unlocked: false, rarity: "rare", price: 200),
                    AvatarColor(type: "color", name: "peachpalette6", set: "P??che", unlocked: false, rarity: "rare", price: 225),
                    AvatarColor(type: "color", name: "peachpalette7", set: "P??che", unlocked: false, rarity: "epic", price: 250),
                    AvatarColor(type: "color", name: "peachpalette8", set: "P??che", unlocked: false, rarity: "epic", price: 275),
                    AvatarColor(type: "color", name: "peachpalette9", set: "P??che", unlocked: false, rarity: "legendary", price: 300)]
                
                let fraisepalette: [AvatarColor] = [
                    AvatarColor(type: "color", name: "fraisepalette1", set: "Fraise", unlocked: false, rarity: "common", price: 100),
                    AvatarColor(type: "color", name: "fraisepalette2", set: "Fraise", unlocked: false, rarity: "common", price: 125),
                    AvatarColor(type: "color", name: "fraisepalette3", set: "Fraise", unlocked: false, rarity: "rare", price: 150),
                    AvatarColor(type: "color", name: "fraisepalette4", set: "Fraise", unlocked: false, rarity: "rare", price: 175),
                    AvatarColor(type: "color", name: "fraisepalette5", set: "Fraise", unlocked: false, rarity: "rare", price: 200),
                    AvatarColor(type: "color", name: "fraisepalette6", set: "Fraise", unlocked: false, rarity: "rare", price: 225),
                    AvatarColor(type: "color", name: "fraisepalette7", set: "Fraise", unlocked: false, rarity: "epic", price: 250),
                    AvatarColor(type: "color", name: "fraisepalette8", set: "Fraise", unlocked: false, rarity: "epic", price: 275),
                    AvatarColor(type: "color", name: "fraisepalette9", set: "Fraise", unlocked: false, rarity: "legendary", price: 300)]
                
                let colors: [[AvatarColor]] = [basepalette, ambiancepalette, peachpalette, fraisepalette]
                for palettes in colors{
                    for color in palettes{
                        try db.run(tabavatarscolors.insert(type <- color.type, name <- color.name, set <- color.set, unlocked <- color.unlocked, rarity <- color.rarity, price <- color.price))
                    }
                }
                
                // set the value to true, so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
        } catch {
            // show error message if any
            print(error.localizedDescription)
        }
    }
    
    
    // add badge
    public func addBadge(filiereValue: String, titleValue: String, descriptionValue: String, imageValue: String, rewardValue: Int64, unlockedValue: Bool, claimedValue: Bool){
        do {
            try db.run(badges.insert(filiere <- filiereValue, title <- titleValue, description <- descriptionValue, image <- imageValue, reward <- rewardValue, unlocked <- unlockedValue, claimed <- claimedValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // return array of badge models
    public func getBadgesALL() -> [Badge] {
        
        //create empty array
        var badgesModels: [Badge] = []
        
        // get all badges in descending order
        badges = badges.order(id.desc)
        
        // exception handling
        do {
            
            // loop through all badges
            for badge in try db.prepare(badges) {
                
                // create new model in each loop iteration
                let badgeModel: Badge = Badge()
                
                //set value in model from database
                badgeModel.id = badge[id]
                badgeModel.filiere = badge[filiere]
                badgeModel.title = badge[title]
                badgeModel.image = badge[image]
                badgeModel.description = badge[description]
                badgeModel.reward = badge[reward]
                badgeModel.unlocked = badge[unlocked]
                badgeModel.claimed = badge[claimed]
                
                // append in new array
                badgesModels.append(badgeModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return badgesModels
    }
    
    // get badge according to the filiere
    public func getBadgesFil(selfil: String) -> [Badge] {
        
        //create empty array
        var badgesModels: [Badge] = []
        
        // get all badges in descending order
        badges = badges.filter(filiere == selfil)
        badges = badges.order(id.asc)
        
        // exception handling
        do {
            
            // loop through all badges
            for badge in try db.prepare(badges) {
                
                // create new model in each loop iteration
                let badgeModel: Badge = Badge()
                
                //set value in model from database
                badgeModel.id = badge[id]
                badgeModel.filiere = badge[filiere]
                badgeModel.title = badge[title]
                badgeModel.image = badge[image]
                badgeModel.description = badge[description]
                badgeModel.reward = badge[reward]
                badgeModel.unlocked = badge[unlocked]
                badgeModel.claimed = badge[claimed]
                
                // append in new array
                badgesModels.append(badgeModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return badgesModels
    }
    
    // get single badge data
    public func getBadge(idValue: Int64) -> Badge {
        
        // create an empty object
        let badgeModel: Badge = Badge()
        
        //exception handling
        do {
            
            // get badge using ID
            let badge: AnySequence<Row> = try db.prepare(badges.filter(id == idValue))
            
            // get row
            try badge.forEach({ (rowValue) in
                
                // set values in model
                badgeModel.id = try rowValue.get(id)
                badgeModel.filiere = try rowValue.get(filiere)
                badgeModel.title = try rowValue.get(title)
                badgeModel.description = try rowValue.get(description)
                badgeModel.image = try rowValue.get(image)
                badgeModel.reward = try rowValue.get(reward)
                badgeModel.unlocked = try rowValue.get(unlocked)
                badgeModel.claimed = try rowValue.get(claimed)
            })
        } catch {
            print(error.localizedDescription)
        }
        
        // return badge
        return badgeModel
    }
    
    // unlock badge
    public func unlockBadge(idValue: Int64){
        do {
            // get badge using ID
            let badge: Table = badges.filter(id==idValue)
            
            // run the update query
            try db.run(badge.update(unlocked <- true))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // claim badge
    public func claimBadge(idValue: Int64){
        do {
            //get bade using ID
            let badge: Table = badges.filter(id==idValue)
            
            //run the update query
            try db.run(badge.update(claimed <- true))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // delete badge
    public func deleteBadge(idValue: Int64){
        do {
            //get badge using ID
            let badge: Table = badges.filter(id == idValue)
            
            //run the delete query
            try db.run(badge.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // return array of quizz saved
    public func getQuizzALL() -> [DernierQuizz] {
        
        //create empty array
        var quizzsModels: [DernierQuizz] = []
        
        // get all quizz in descending order
        lastquizz = lastquizz.order(id.asc)
        
        // exception handling
        do {
            
            // loop through all badges
            for quizz in try db.prepare(lastquizz) {
                
                // create new model in each loop iteration
                let quizzModel: DernierQuizz = DernierQuizz()
                
                //set value in model from database
                quizzModel.id = quizz[id]
                quizzModel.matiere = quizz[matiere]
                quizzModel.filiere = quizz[filiere]
                quizzModel.chap = quizz[chap]
                quizzModel.chapname = quizz[chapname]
                quizzModel.score = quizz[score]
                
                // append in new array
                quizzsModels.append(quizzModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return quizzsModels
    }
    
    // get all questions saved
    public func getQuestionsALL() -> [QuestionResume] {
        
        //create empty array
        var questionsModels: [QuestionResume] = []
        
        // get all questions in descending order
        questionssave = questionssave.order(id.desc)
        
        // exception handling
        do {
            
            // loop through all badges
            for questionel in try db.prepare(questionssave) {
                
                // create new model in each loop iteration
                let questionModel: QuestionResume = QuestionResume()
                
                //set value in model from database
                questionModel.id = questionel[id]
                questionModel.question = questionel[question]
                questionModel.answer = questionel[answer]
                
                // append in new array
                questionsModels.append(questionModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return questionsModels
    }
    
    // save quizz data
    public func saveQuizz(matiereValue: String, filiereValue: String, chapValue: Int64, chapnameValue: String, scoreValue: Int64, questions: [QuestionResumeStruct]){
        let count = try! db.scalar(lastquizz.count)
//        print(count)
        if count < 5 && count != 0{
            let min = try! db.scalar(lastquizz.select(id.min))
            do {
                try db.run(lastquizz.insert(id <- min!-1 ,matiere <- matiereValue, filiere <- filiereValue, chap <- chapValue, chapname <- chapnameValue, score <- scoreValue))
                for questionel in questions{
                    try db.run(questionssave.insert(id <- min!-1, question <- questionel.question, answer <- questionel.answer))
                }
//                print("quizz saved with id \(min!-1)")
            } catch {
                print(error.localizedDescription)
            }
        } else if count == 0{
            do {
                try db.run(lastquizz.insert(id <- 5 ,matiere <- matiereValue, filiere <- filiereValue, chap <- chapValue, chapname <- chapnameValue, score <- scoreValue))
                for questionel in questions{
                    try db.run(questionssave.insert(id <- 5, question <- questionel.question, answer <- questionel.answer))
                }
//                print("quizz saved with id 5")
            } catch {
                print(error.localizedDescription)
            }
        } else {
            do {
                let quizz = lastquizz.filter(id == Int64(5))
                try db.run(quizz.delete())
                let questionsfiltered = questionssave.filter(id == Int64(5))
                try db.run(questionsfiltered.delete())
//                print("last quizz deleted")
                for i in 1...4{
                    let quizz = lastquizz.filter(id == Int64(count-i))
                    try db.run(quizz.update(id <- Int64(count-i+1)))
                    let questionsfiltered = questionssave.filter(id == Int64(count-i))
                    try db.run(questionsfiltered.update(id <- Int64(count-i+1)))
//                    print("id incremented from \(count-i) to \(count-i+1)")
                }
                try db.run(lastquizz.insert(id <- 1 ,matiere <- matiereValue, filiere <- filiereValue, chap <- chapValue, chapname <- chapnameValue, score <- scoreValue))
                for questionel in questions{
                    try db.run(questionssave.insert(id <- 1, question <- questionel.question, answer <- questionel.answer))
                }
//                print("quizz saved with id 1")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // get questions by id
    public func getQuestionsID(idValue: Int64) -> [QuestionResume] {
        
        //create empty array
        var questionsModels: [QuestionResume] = []
        
        // get all questions in descending order
        questionssave = questionssave.filter(id == idValue).order(id.desc)
        
        // exception handling
        do {
            
            // loop through all badges
            for questionel in try db.prepare(questionssave) {
                
                // create new model in each loop iteration
                let questionModel: QuestionResume = QuestionResume()
                
                //set value in model from database
                questionModel.id = questionel[id]
                questionModel.question = questionel[question]
                questionModel.answer = questionel[answer]
                
                // append in new array
                questionsModels.append(questionModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return questionsModels
    }
    
    // get all activity logs
    public func getActivityALL() -> [ActivityLog] {
        
        // updating last week data
        
        // formatter
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let weekago = formatter.date(from: formatter.string(from: Date().addingTimeInterval(-604800))) ?? Date().addingTimeInterval(-604800)
        let now = formatter.date(from: formatter.string(from: Date())) ?? Date()
        
        let wrongdata = activitylogs.filter(date <= weekago)
        let count = try! db.scalar(wrongdata.count)
        if count != 0{
            do {
                try db.run(wrongdata.delete())
                for i in 0...count-1{
                    try db.run(activitylogs.insert(date <- Calendar.current.date(byAdding: .day, value: -i, to: now)!, daystring <- ["Dimanche", "Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"][Calendar.current.date(byAdding: .day, value: -i, to: now)!.get(.weekday)-1], quizznbr <- 0, duration <- 0, reussiteperc <- 0))
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
        //create empty array
        var activitylogsModels: [ActivityLog] = []
        
        // get all quizz in descending order
        activitylogs = activitylogs.order(date.desc)
        
        // exception handling
        do {
            // loop through all badges
            for activity in try db.prepare(activitylogs) {
                
                // create new model in each loop iteration
                let activitylogModel: ActivityLog = ActivityLog()
                
                //set value in model from database
                activitylogModel.date = activity[date]
                activitylogModel.daystring = activity[daystring]
                activitylogModel.quizznbr = activity[quizznbr]
                activitylogModel.duration = activity[duration]
                activitylogModel.reussiteperc = activity[reussiteperc]
                
                // append in new array
                activitylogsModels.append(activitylogModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return activitylogsModels
    }
    
    // save activity data
    public func saveActivity(dateValue: Date, quizzValue: Int64, durationValue: Double, reussitepercValue: Double){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let newdate = formatter.date(from: formatter.string(from: dateValue)) ?? dateValue
        do {
            //run insert query
            try db.run(activitylogs.insert(date <- newdate, daystring <- ["Dimanche", "Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"][newdate.get(.weekday)-1], quizznbr <- quizzValue, duration <- durationValue, reussiteperc <- reussitepercValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    //get user informations
    public func getUserInfos() -> Informations{
        //create empty array
        let userInfos: Informations = Informations()
          
        // exception handling
        do {
            
            // loop through all badges
            for info in try db.prepare(informations){
                userInfos.exp = info[exp]
                userInfos.money = info[money]
                userInfos.quizztotal = info[quizztotal]
                userInfos.bonnereptotal = info[bonnereptotal]
                userInfos.mauvaisereptotal = info[mauvaisereptotal]
                userInfos.tempstotal = info[tempstotal]
                userInfos.earnedbadge = info[earnedbadge]
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        return userInfos
    }
    
    public func QuizzTotalIncrement(nbr: Int64){
        do {
            //run the update query
            try db.run(informations.update(quizztotal <- informations[quizztotal]+nbr))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func BonneRepTotalIncrement(nbr: Int64){
        do {
            //run the update query
            try db.run(informations.update(bonnereptotal <- informations[bonnereptotal]+nbr))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func MauvaiseRepTotalIncrement(nbr: Int64){
        do {
            //run the update query
            try db.run(informations.update(mauvaisereptotal <- informations[mauvaisereptotal]+nbr))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func ExpIncrement(nbr: Int64){
        do {
            //run the update query
            try db.run(informations.update(exp <- informations[exp]+nbr))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func MoneyIncrement(nbr: Int64){
        do {
            // run the update query
            try db.run(informations.update(money <- informations[money]+nbr))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func TempsTotalIncrement(temps: Double){
        do {
            //run the update query
            try db.run(informations.update(tempstotal <- informations[tempstotal]+temps))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func BadgeEarnedIncrement(nbr: Int64){
        do {
            //run the update query
            try db.run(informations.update(earnedbadge <- informations[earnedbadge]+nbr))
        } catch {
            print(error.localizedDescription)
        }
    }

    
    
    
    public func getFilieres() -> [Filiere]{
        var filieresModels: [Filiere] = []
        // exception handling
        do {
            // loop through all badges
            for filiere in try db.prepare(tabfilieres) {
                
                // create new model in each loop iteration
                let filiereModel: Filiere = Filiere()
                
                //set value in model from database
                filiereModel.name = filiere[name]
                filiereModel.sousfiliere = filiere[sousfiliere]
                
                // append in new array
                filieresModels.append(filiereModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        return filieresModels
    }
    
    public func getSousFiliere(filiere: String) -> String{
        let result = Filiere()
        do {
            let filiere: AnySequence<Row> = try db.prepare(tabfilieres.filter(name == filiere))
            
            // get row
            try filiere.forEach({ (rowValue) in
                result.sousfiliere = try rowValue.get(sousfiliere)
            })
        } catch {
            print(error.localizedDescription)
        }
        return result.sousfiliere
    }
    
    public func getMatieres(filiereValue: String) -> [Matiere]{
        var matieresModels: [Matiere] = []
        tabmatieres = tabmatieres.filter(filiere == filiereValue)
        // exception handling
        do {
            for matiere in try db.prepare(tabmatieres) {
                let matiereModel: Matiere = Matiere()
                matiereModel.title = matiere[title]
                matiereModel.filiere = matiere[filiere]
                matiereModel.shortTitle = matiere[shortTitle]
                matiereModel.sousfiliere = matiere[sousfiliere]
                matiereModel.descf = matiere[descf]
                matiereModel.descsf = matiere[descsf]
                
                matieresModels.append(matiereModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        return matieresModels
    }
    
    public func getChapitres(filiereValue: String, matiereValue: String) -> [Chapitre] {
        var chapitresModels: [Chapitre] = []
        tabchapitres = tabchapitres.filter(filiere == filiereValue && matiere == matiereValue)
        tabchapitres = tabchapitres.order(num.asc)
        // exception handling
        do {
            for chapitre in try db.prepare(tabchapitres) {
                let chapitreModel: Chapitre = Chapitre()
                chapitreModel.name = chapitre[name]
                chapitreModel.matiere = chapitre[matiere]
                chapitreModel.filiere = chapitre[filiere]
                chapitreModel.num = chapitre[num]
                
                chapitresModels.append(chapitreModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        return chapitresModels
    }
    
    public func getQuestions(filiereValue: String, matiereValue: String, chapValue: Int64) -> [fbquestion] {
        var questionsModels: [fbquestion] = []
        tabquestions = tabquestions.filter(filiere == filiereValue && matiere == matiereValue && chap == chapValue)
        tabquestions = tabquestions.order(numq.asc)
        // exception handling
        do {
            for questionel in try db.prepare(tabquestions) {
                
                let question = questionel[question]
                let a = questionel[a]
                let b = questionel[b]
                let c = questionel[c]
                let answer = questionel[answer]
                let numq = questionel[numq]
                
                questionsModels.append(
                    fbquestion(id: "", question: question, a: a, b: b, c: c, answer: answer, numq: Int(numq))
                )
            }
        } catch {
            print(error.localizedDescription)
        }
        return questionsModels
    }
    
    public func checkQuizzAvailable(filiereValue: String, matiereValue: String, chapValue: Int64) -> Bool{
        do {
            let count = try db.scalar(tabquestions.filter(filiere == filiereValue && matiere == matiereValue && chap == chapValue).limit(1).count)
            if count > 0{
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
    
    public func getAvatarsOrColor(typeValue: String, setValue: String) -> [AvatarColor]{
        var result: [AvatarColor] = []
        tabavatarscolors = tabavatarscolors.filter(set == setValue && type == typeValue)
        tabavatarscolors = tabavatarscolors.order(name.asc)
        // exception handling
        do {
            for el in try db.prepare(tabavatarscolors) {
                
                let type = el[type]
                let name = el[name]
                let set = el[set]
                let unlocked = el[unlocked]
                let rarity = el[rarity]
                let price = el[price]
                
                result.append(
                    AvatarColor(type: type, name: name, set: set, unlocked: unlocked, rarity: rarity, price: price)
                )
            }
        } catch {
            print(error.localizedDescription)
        }
        return result
    }
    
    public func getSets(typeValue: String) -> [String]{
        var sets: [String] = []
        // exception handling
        do{
            for el in try db.prepare(tabavatarscolors.filter(type == typeValue && set !=  "Base" && set != "Al??atoire").select(distinct:set)){
                sets.append(el[set])
            }
        } catch {
            print(error.localizedDescription)
        }
        return sets
    }
    
    public func unlockAvatarOrColor(typeValue: String, nameValue: String){
        do {
            // get badge using ID
            let element: Table = tabavatarscolors.filter(type == typeValue && name == nameValue)
            
            // run the update query
            try db.run(element.update(unlocked <- true))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func unlockableItems() -> Int{
        var number = 0
        do {
            number = try db.scalar(tabavatarscolors.filter(set == "Al??atoire" && unlocked == false).count)
        } catch {
            print(error.localizedDescription)
            number = -1
        }
        return number
    }
    
    
    public func getUnlockableItems() -> [AvatarColor]{
        var unlockableitems: [AvatarColor] = []
        do{
            for el in try db.prepare(tabavatarscolors.filter(set == "Al??atoire" && unlocked == false)){
                let type = el[type]
                let name = el[name]
                let set = el[set]
                let unlocked = el[unlocked]
                let rarity = el[rarity]
                let price = el[price]
                unlockableitems.append(AvatarColor(type: type, name: name, set: set, unlocked: unlocked, rarity: rarity, price: price))
            }
        } catch {
            print(error.localizedDescription)
        }
        return unlockableitems
    }
    
    public func getUnlockableItemsByRarity(rarityValue: String) -> [AvatarColor]{
        var unlockableitems: [AvatarColor] = []
        do{
            for el in try db.prepare(tabavatarscolors.filter(set == "Al??atoire" && rarity == rarityValue && unlocked == false)){
                let type = el[type]
                let name = el[name]
                let set = el[set]
                let unlocked = el[unlocked]
                let rarity = el[rarity]
                let price = el[price]
                unlockableitems.append(AvatarColor(type: type, name: name, set: set, unlocked: unlocked, rarity: rarity, price: price))
            }
        } catch {
            print(error.localizedDescription)
        }
        return unlockableitems
    }
    
    public func getUnlockedNums(rarityValue: String) -> [Int]{
        var totalcount : Int = 0
        var unlockedcount : Int = 0
        do {
            totalcount = try db.scalar(tabavatarscolors.filter(set == "Al??atoire" && rarity == rarityValue).count)
            unlockedcount = try db.scalar(tabavatarscolors.filter(set == "Al??atoire" && rarity == rarityValue && unlocked == true).count)
        } catch {
            print(error.localizedDescription)
        }
        return [unlockedcount, totalcount]
    }
    
    public func checkIfNewSaw(quizzidValue: String) -> Bool{
        do {
            for _ in try db.prepare(newshistory.filter(quizzid == quizzidValue)){
                return true
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    public func saveNewSaw(quizzidValue: String){
        do {
            try db.run(newshistory.insert(quizzid <- quizzidValue))
        } catch {
            print(error.localizedDescription)
        }
    }
}
