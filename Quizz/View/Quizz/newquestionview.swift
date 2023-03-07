//
//  newquestionview.swift
//  Quizz
//
//  Created by matteo on 02/08/2021.
//

import SwiftUI

struct NewQuestionView: View {
    
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    
    var questionel: fbquestion
    var nombredeq : Int
    
    @State var selected = ""
    @State var isSubmitted = false
    @State var clicked: Bool = false
    
    var body: some View {
        
        VStack(spacing: 0){
            
            ScrollView(.vertical, showsIndicators: false){
                formulatext(text: questionel.question, width:  UIScreen.main.bounds.width*0.9, color: Color("brown"))
                    .padding(.vertical, 10)
            }
            .padding(.vertical, 15)
            .frame(width: UIScreen.main.bounds.width*0.9, alignment: .center)
            .frame(minHeight: UIScreen.main.bounds.height*0.1, maxHeight: UIScreen.main.bounds.height*0.35)
            .background(Color("orange2").opacity(0.5))
            .cornerRadius(5)
            .overlay(
                Rectangle()
                    .fill(Color.black.opacity(0.05))
                    .frame(height: 7, alignment: .center)
                    .cornerRadius(5)
                    .padding(.top, 5)
                    .offset(y: 7)
                ,alignment: .bottom
            )
            .overlay(
                Text("\(String(answered))/\(String(nombredeq))")
                    .foregroundColor(Color("purple1"))
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(Color.white)
                    .cornerRadius(25)
                    .offset(y: -15)
                ,alignment: .top
            )
            .overlay(
                Text("?")
                    .foregroundColor(Color("purple1"))
                    .fontWeight(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.white)
                    .cornerRadius(95)
                    .offset(y: 15)
                ,alignment: .bottom
            )
            .overlay(
                HStack{
                    Spacer()
                    Button(action: {
                        if isSubmitted && !clicked {
                            withAnimation{
                                clicked = true
                                isSubmitted.toggle()
                                answered += 1
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                                    clicked = false
                                }
                            }
                        }
                        else if !clicked {
                            clicked = true
                            checkAns()
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                                clicked = false
                            }
                        }
                    }, label: {
                        HStack(spacing: 3){
                            Text("Suivant")
                                .font(.system(size: 15))
                                .foregroundColor(Color("purple1"))
                                .fontWeight(.semibold)
                            Image("thinarrowright")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(Color("purple1"))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(Color.white)
                        .cornerRadius(25)
                        .frame(alignment: .center)
                    })
                    .padding(.trailing)
                }
                .offset(y: 15)
                ,alignment:.bottom
            )
            
            Spacer()
            
            // options...
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 10){
                    Button(action: {selected = questionel.a}, label: {
                        formulatext(text: questionel.a, width: UIScreen.main.bounds.width*0.7, color: isSubmitted && questionel.a == questionel.answer ? Color("white") : selected == questionel.a ? Color("white") : Color("brown"))
                        .padding()
                        .background(color(option: questionel.a) == Color("black") ? Color("whitebutton") : color(option: questionel.a)).animation(.spring())
                        .cornerRadius(5)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(color(option: questionel.a).opacity(0.1),lineWidth: 1)
                        )
                        .shadow(color: color(option: questionel.a).opacity(0.1), radius: 2, x: 0, y: 2)
                    })
                    
                    Button(action: {selected = questionel.b}, label: {
                        formulatext(text: questionel.b, width: UIScreen.main.bounds.width*0.7, color: isSubmitted && questionel.b == questionel.answer ? Color("white") : selected == questionel.b ? Color("white") : Color("brown"))
                        .padding()
                        .background(color(option: questionel.b) == Color("black") ? Color("whitebutton") : color(option: questionel.b)).animation(.spring())
                        .cornerRadius(5)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(color(option: questionel.b).opacity(0.1),lineWidth: 1)
                        )
                        .shadow(color: color(option: questionel.b).opacity(0.1), radius: 2, x: 0, y: 2)
                    })
                    
                    Button(action: {selected = questionel.c}, label: {
                        formulatext(text: questionel.c, width: UIScreen.main.bounds.width*0.7, color: isSubmitted && questionel.c == questionel.answer ? Color("white") : selected == questionel.c ? Color("white") : Color("brown"))
                        .padding()
                        .background(color(option: questionel.c) == Color("black") ? Color("whitebutton") : color(option: questionel.c)).animation(.spring())
                        .cornerRadius(5)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(color(option: questionel.c).opacity(0.1),lineWidth: 1)
                        )
                        .shadow(color: color(option: questionel.c).opacity(0.1), radius: 2, x: 0, y: 2)
                    })
                }
                .padding()
                .padding(.bottom)
            }
            .frame(width: UIScreen.main.bounds.width)
            .overlay(
                Rectangle()
                    .fill(Color.black.opacity(0.05))
                    .frame(height: 7, alignment: .center)
                    .cornerRadius(5)
                    .padding(.top, 5)
                    .offset(y: -14)
                    .frame(width: UIScreen.main.bounds.width*0.9, alignment: .center)
                ,alignment: .top
            )
            .overlay(
                Text("?")
                    .foregroundColor(Color("purple1"))
                    .fontWeight(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.white)
                    .cornerRadius(95)
                    .offset(y: -23)
                    .frame(width: UIScreen.main.bounds.width*0.9, alignment: .center)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x:0, y:5)
                ,alignment: .top
            )
            .overlay(
                HStack{
                    Spacer()
                    Button(action: {
                        if isSubmitted && !clicked {
                            withAnimation{
                                clicked = true
                                isSubmitted.toggle()
                                answered += 1
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                                    clicked = false
                                }
                            }
                        }
                        else if !clicked {
                            clicked = true
                            checkAns()
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                                clicked = false
                            }
                        }
                    }, label: {
                        HStack(spacing: 3){
                            Text("Suivant")
                                .font(.system(size: 15))
                                .foregroundColor(Color("purple1"))
                                .fontWeight(.semibold)
                            Image("thinarrowright")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(Color("purple1"))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(Color.white)
                        .cornerRadius(25)
                        .frame(alignment: .center)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x:0, y:5)
                    })
                    .padding(.trailing)
                }
                .frame(width: UIScreen.main.bounds.width*0.9, alignment: .center)
                .offset(y: -21)
                ,alignment:.top
            )
            
            Spacer(minLength: 0)
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .top)
        .background(Color("lightgrey"))
    }
    
    func color(option: String)->Color{
        
        if option == selected{
            
            // displaying if correct means green else red...
            
            if isSubmitted{
                
                if selected == questionel.answer{
                    return Color("green")
                }
                else{
                    return Color("red")
                }
            }
            else{
                return Color("orange")
            }
        }
        else{
            
            // displaying right if wrong selected...
            if isSubmitted && option != selected{
                if questionel.answer == option
                {return Color("green")}
            }
            return Color("black")
        }
    }
    
    // check answer...
    
    func checkAns(){
        
        if selected == questionel.answer{
            correct += 1
        }
        else{
            wrong += 1
        }
        
        isSubmitted.toggle()
    }
}
