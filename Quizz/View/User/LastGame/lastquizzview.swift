//
//  SwiftUIView.swift
//  Quizz
//
//  Created by matteo on 07/07/2021.
//

import SwiftUI

struct lastquizzview: View {
    
    var quizzData : DernierQuizz
    var questions : [QuestionResume]
    var index : Int
    var nbrq : Int
    
    @State var expand : Int = -1
    @State var showrep : Int = -1
    
    
    var body: some View {
        VStack{
            HStack{
                ZStack{
                    Circle()
                        .fill(Color("whitebutton"))
                    
                    Image("\(quizzData.filiere.lowercased())\(quizzData.matiere.lowercased())chap\(String(quizzData.chap))")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .frame(width: 80)
                        .background(Color("lightgrey"))
                        .clipShape(Circle())
                        .clipped()
                        .overlay(Circle().stroke(Color("white"), lineWidth: 6).shadow(radius: 10))
                }
                .frame(width: 80)
                
                VStack(alignment: .leading){
                    HStack(spacing: 5){
                        Text("\(quizzData.filiere)")
                            .font(Font.system(size: 15, weight: .medium, design: .default))
                            .foregroundColor(Color("black").opacity(0.5))
                        Text("\(quizzData.matiere)")
                            .font(Font.system(size: 15, weight: .medium, design: .default))
                            .foregroundColor(Color("black").opacity(0.8))
                    }
                    Text("\(quizzData.chapname)")
                        .font(Font.system(size: 17, weight: .heavy, design: .default))
                        .foregroundColor(Color("black"))
                    Text("Chapitre \(String(quizzData.chap))")
                        .font(Font.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(Color("black").opacity(0.4))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 0){
                    Button(action: {if expand == index{ expand = -1} else{ expand = index}}, label: {
                        HStack(spacing: 3){
                            ForEach(0...2, id:\.self){ id in
                                Circle()
                                    .fill(Color("whitebutton"))
                                    .frame(width: 5,height: 5)
                            }
                        }
                        .padding(.leading)
                        .padding(.bottom)
                    })
                    Spacer()
                    Text("\(quizzData.score)/\(nbrq)")
                        .font(Font.system(size: 20, weight: .heavy, design: .default))
                            .foregroundColor(Color("whitebutton"))
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.15)
            .background(CGFloat(quizzData.score)/CGFloat(nbrq) >= 0.5 ? Color("green").opacity(0.6) : Color("red").opacity(0.6))
            .cornerRadius(15)
            .onTapGesture {
                if expand == index{
                    expand = -1
                    
                } else{
                    expand = index
                    
                }
            }
            
            if expand == index{
                ScrollView{
                    VStack(alignment: .leading){
                        ForEach(questions.indices, id:\.self){ index in
                            HStack{
                                Text("\(index+1)) \(questions[index].question)")
                                    .font(Font.system(size: 15, weight: .medium, design: .default))
                                    .foregroundColor(Color("black").opacity(0.8))
                                Spacer()
                            }
                            HStack{
                                Button(action: {if showrep == index {showrep = -1} else {showrep = index}}, label: {
                                    Image(systemName: showrep == index ? "eye" : "eye.slash")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color("black").opacity(0.5))
                                        .frame(width: 15)
                                    Text("Voir la réponse")
                                        .font(Font.system(size: 15, weight: .medium, design: .default))
                                        .foregroundColor(Color("black").opacity(0.5))
                                })
                                Spacer()
                                Text(questions[index].answer)
                                    .font(Font.system(size: 15, weight: .medium, design: .default))
                                    .foregroundColor(Color("black"))
                                    .opacity(showrep == index ? 0.8 : 0)
                                    .animation(.spring())
                            }
                        }
                    }
                    .padding()
                }
                .overlay(Image(systemName: "triangle.fill").resizable().foregroundColor(Color("black")).frame(width: 13, height: 10).rotationEffect(.degrees(180)).padding(.trailing).opacity(0.3), alignment: .bottomTrailing)
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width*0.9, height: expand == index ? UIScreen.main.bounds.height*0.45 : UIScreen.main.bounds.height*0.15)
        .background(CGFloat(quizzData.score)/CGFloat(nbrq) >= 0.5 ? Color("green").opacity(0.8) : Color("red").opacity(0.8))
        .cornerRadius(15)
        .padding(.bottom, 1)
        .animation(.easeInOut(duration: 1))
    }
}

//struct lastquizzview_Previews: PreviewProvider {
//    static var previews: some View {
//        lastquizzview(quizzData: DerniersQuizzData.quizzData[0])
//    }
//}
