//
//  LastGameView.swift
//  Quizz
//
//  Created by matteo on 03/07/2021.
//

import SwiftUI

struct LastGameView: View {
    
    @State var quizzsModels: [DernierQuizz] = []
    @State var questionsModels: [QuestionResume] = []
    
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            HStack{
                VStack(alignment: .leading){
                    Text("QUIZZS RÉCENTS")
                        .font(Font.headline.weight(.heavy))
                        .foregroundColor(Color("black").opacity(0.7))
                        .padding(.leading)
                    Text("Résumé des dernières parties et de tes erreurs.")
                        .font(.caption)
                        .foregroundColor(Color("black").opacity(0.5))
                        .padding(.leading)
                }
                Spacer()
            }
            .padding(.bottom, 21)
            
            if quizzsModels.isEmpty{
                HStack{
                    Spacer()
                    VStack{
                        Text("Aucun quizz récent")
                            .font(Font.headline.weight(.heavy))
                            .foregroundColor(Color("black").opacity(0.6))
                        Text("Termine ton premier quizz pour en consulter le résumé ici !")
                            .font(Font.subheadline.weight(.semibold))
                            .foregroundColor(Color("black").opacity(0.6))
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: UIScreen.main.bounds.width*0.8)
                    Spacer()
                }
                .padding()
            }
            else {
                ForEach(quizzsModels.indices, id:\.self){ index in
                    let questions = DB_Manager().getQuestionsID(idValue: quizzsModels[index].id)
                    lastquizzview(quizzData: quizzsModels[index], questions: questions, index: index+1, nbrq: questions.count + Int(quizzsModels[index].score))
                }
                .padding(.horizontal)
                .padding(.vertical, 2.5)
            }
        }
        .onAppear(perform: {
            quizzsModels = DB_Manager().getQuizzALL()
            questionsModels = DB_Manager().getQuestionsALL()
        })
    }
}

//struct LastGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        LastGameView()
//    }
//}
