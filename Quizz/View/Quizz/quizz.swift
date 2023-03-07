//
//  QA.swift
//  Quizz
//
//  Created by matteo on 13/05/2021.
//

import SwiftUI

// question answer view...
struct QA: View {
    
    @AppStorage("userid") var userid = ""
    @AppStorage("quizztime") var quizztime: String = ""
    
    var chap: Chapitre
    var quizzid: String
    var auteur: String
    var endmessage: String
    
    @State var questions: [fbquestion] = []
    @State var canrate: Bool = false
    
    // for analytics...
    @State var quizzended = false
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0
    
    var formatter : DateFormatter {
        let format = DateFormatter()
        format.dateFormat = "dd MMM yyyy HH:mm:ss"
        format.locale = Locale(identifier: "fr_FR")
        return format
    }
    
    @StateObject var fbq = FirebaseQuizz()
    
    @Environment(\.presentationMode) var present
    
    
    
    var body: some View {
        
        ZStack{
            if fbq.questions.isEmpty{
                beforequizz()
                    .transition(.opacity)
                    .zIndex(0)
            }
            else{
                if quizzended{
                    afterquizz(quizzended: $quizzended, correct: $correct, wrong: $wrong, answered: $answered, chapitre: chap.name, numchap: Int(chap.num))
                        .transition(.opacity)
                        .zIndex(2)
                        .onAppear(perform: {
                            let duration = formatter.date(from: formatter.string(from: Date()))! - formatter.date(from: quizztime)!
                            print(duration)
                            DB_Manager().BonneRepTotalIncrement(nbr: Int64(correct))
                            DB_Manager().MauvaiseRepTotalIncrement(nbr: Int64(wrong))
                            DB_Manager().saveActivity(dateValue: Date.today(), quizzValue: Int64(1), durationValue: duration, reussitepercValue: Double(correct)/Double(correct+wrong))
                        })
                }
                else {
                    duringquizz(quizzended: $quizzended, correct: $correct, wrong: $wrong, answered: $answered, chapitre: chap.name, filiere: chap.filiere, quizzid: quizzid, auteur: auteur, endmessage: endmessage, questions: fbq.questions, canrate: canrate)
                        .transition(.opacity)
                        .zIndex(1)
                        .onAppear(perform: {
                            self.quizztime = formatter.string(from: Date())
                        })
                }
            }
        }
        .background(Color("lightgrey").ignoresSafeArea())
        // fetching...
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.spring()){
                    fbq.checkCanRate(filiere: chap.filiere, quizzid: quizzid, userid: userid) { result in
                        self.canrate = result
                    }
                    withAnimation(.spring()){fbq.getQuestions(filiere: chap.filiere, quizzid: quizzid)}
                }
            }
        })
    }
}


//struct quizz_Previews: PreviewProvider {
//    static var previews: some View {
//        QA(correct: Binding.constant(3), wrong: Binding.constant(0), answered: Binding.constant(10), filiere: "MP", matiere: "Physique", chapitre: "Mécanique", numchap: 1)
//    }
//}
