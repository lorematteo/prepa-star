//
//  duringquizz.swift
//  Quizz
//
//  Created by matteo on 21/07/2021.
//

import SwiftUI

struct duringquizz: View {
    
    @Binding var quizzended: Bool
    @Binding var correct : Int
    @Binding var wrong : Int
    @Binding var answered: Int
    
    var chapitre: String
    var filiere: String
    var quizzid: String
    var auteur: String
    var endmessage: String
    
    var questions: [fbquestion]
    var canrate: Bool
    
    @State var isCompleted : Int = 0
    @State var rating: Int = 0
    
    @Environment(\.presentationMode) var present
    
    var body: some View {
        
        VStack(spacing: 0){
            
            HStack(spacing: 15){
                
                userIcon(size: UIScreen.main.bounds.height > 850 ? 105 : 65, linewidth: 3)
                
                
                VStack(alignment: .leading){
                    Text(chapitre)
                        .font(UIScreen.main.bounds.height > 850 ? .title : .title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    Text(filiere)
                        .font(UIScreen.main.bounds.height > 850 ? .title3 : .body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.6)
                }
                
                Spacer()
                
                VStack(){
                    Button(
                        action: {
                            present.wrappedValue.dismiss()
                            quizzended = false
                            answered = 0
                            correct = 0
                            wrong = 0},
                        label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color("white"))
                        })
                        .padding(.bottom)
                        .padding(.trailing, 5)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 7)
            .frame(width: UIScreen.main.bounds.width)
            .background(Color("purple1").ignoresSafeArea())
            
            ZStack(alignment: .topLeading){
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 7)
                    .foregroundColor(Color.gray.opacity(0.6))
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 0.0, y: 5)
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * min(progress(qtot: questions.count), 1.0), height: 7)
                    .foregroundColor(Color("green").opacity(1))
                    .clipShape(CustomCorner(corners: [.topRight, .bottomRight], size: 5))
                    .animation(.easeInOut(duration: 2))
                    .padding(.bottom, 25)
            }
            .background(Color("lightgrey"))
            
            
            if answered == questions.count {
                AuthorRatingView(ended: $quizzended, filiere: filiere, quizzid: quizzid, auteur: auteur, endmessage: endmessage, nombredeq: questions.count, canrate: canrate)
            } else {
                
                // QuestionView...
                
                ZStack{
                    
                    ForEach(questions.reversed(), id:\.self){ q in
                        // View...
                        NewQuestionView(correct: $correct, wrong: $wrong, answered: $answered, questionel: q, nombredeq: questions.count)
                        // if current question is completed means moving away ...
                            .offset(x: answered > questions.firstIndex(of: q)! ? 1000 : 0)
                            .rotationEffect(.init(degrees: answered > questions.firstIndex(of: q)! ? 10 : 0))
                    }
                    
                }
            }
            
            Spacer(minLength: 0)
        }
    }
    func progress(qtot: Int) -> CGFloat{
        
        let fraction = CGFloat(answered) / CGFloat(qtot)
        
        return fraction
    }
}


//ZStack{
//    Circle()
//        .stroke(lineWidth: 25)
//        .foregroundColor(Color("green").opacity(0.6))
//        .frame(width: UIScreen.main.bounds.height > 850 ? 90 : 50, height: UIScreen.main.bounds.height > 850 ? 90 : 50)
//
//    Circle()
//        .trim(from: 0.0, to: min(progress(qtot: questions.count), 1.0))
//        .stroke(style: StrokeStyle(lineWidth: 25, lineCap: .butt, lineJoin: .round))
//        .foregroundColor(Color("green"))
//        .frame(width: UIScreen.main.bounds.height > 850 ? 90 : 50, height: UIScreen.main.bounds.height > 850 ? 90 : 50)
//        .rotationEffect(Angle(degrees: 270))
//        .animation(.easeInOut(duration: 2))
//
//    userIcon(size: UIScreen.main.bounds.height > 850 ? 105 : 65, linewidth: 0)
//}
