//
//  author-rating-view.swift
//  Quizz
//
//  Created by matteo on 23/07/2021.
//

import SwiftUI

struct AuthorRatingView: View {
    
    @AppStorage("userid") var userid: String = ""
    
    @Binding var ended: Bool
    
    var filiere: String
    var quizzid: String
    var auteur: String
    var endmessage: String
    var nombredeq: Int
    var canrate: Bool
    
    @State var rating: Int = 0
    
    var body: some View {
        
        VStack{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    Text(auteur)
                        .foregroundColor(Color("brown"))
                        .font(.title3)
                        .lineLimit(1)
                        .padding()
                    Text(endmessage)
                        .foregroundColor(Color("brown").opacity(0.8))
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
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
                Text("\(String(nombredeq))/\(String(nombredeq))")
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
                        withAnimation(.spring()){
                            if canrate{
                                if rating > 0{
                                    FirebaseQuizz().rateQuizz(filiere: filiere, quizzid: quizzid, userid: userid, rating: rating)
                                    withAnimation(.spring()){ended = true}
                                }
                            } else {
                                withAnimation(.spring()){ended = true}
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
            
            RatingView(rating: $rating)
                .opacity(canrate ? 1 : 0)
                .padding()
                .frame(width: UIScreen.main.bounds.width*0.7)
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.75, alignment: .top)
        .background(Color("lightgrey"))
    }
}
