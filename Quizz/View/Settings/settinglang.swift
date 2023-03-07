//
//  settinglang.swift
//  Quizz
//
//  Created by matteo on 30/07/2021.
//

import SwiftUI

struct settinglang: View {
    
    @Binding var showsetting : String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .top, spacing: 0){
                
                Text("Language")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                VStack(alignment: .center, spacing: 20){
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        VStack(spacing: 0){
                            Button {
                                
                            } label: {
                                HStack{
                                    Text("Français")
                                        .font(.title3)
                                        .foregroundColor(Color("blue"))
                                    Spacer()
                                    ZStack {
                                        Circle()
                                            .frame(width: 20)
                                        Image("tick")
                                            .renderingMode(.template)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 8)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .padding(10)
                            .background(Color("skyblue").opacity(0.2))
                            .cornerRadius(5)
                            
                            
                            Button() {
                                
                            } label: {
                                HStack(){
                                    Text("Prochainement...")
                                        .font(.title3)
                                        .foregroundColor(Color("black"))
                                    Spacer()
                                }
                            }
                            .padding()

                        }
                    })
                    
                    
                }
                .frame(width: UIScreen.main.bounds.width*0.55)
            }
            
            Spacer()
            
        }
        .padding()
        .padding(.top)
        .background(Color("lightgrey"))
    }
}
