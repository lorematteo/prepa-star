//
//  detailview.swift
//  Quizz
//
//  Created by matteo on 01/08/2021.
//

import SwiftUI

struct DetailView : View {
    
    @AppStorage("userannee") var userannee = 0
    
    @Binding var showview : String
    @Binding var matiere : Matiere
    @Binding var filiere: Filiere
    @Binding var sousfiliere: Bool
    @Binding var disabled: Bool
    
    var body: some View{
        
        VStack{
            VStack{
                HStack{
                    
                    Button(action: {
                        withAnimation(.spring())
                            {disabled = true; showview = ""}
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            disabled = false
                        }
                    }) {
                        HStack(spacing: 10){
                            
                            Image(systemName: "arrow.left")
                                .font(.system(size: 24))
                                .foregroundColor(Color("black"))
                        
                            Text("RETOUR")
                                .foregroundColor(Color("black"))
                        }
                    }
                        
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image("star")
                            .renderingMode(.template)
                            .font(.system(size: 25))
                            .foregroundColor(Color("black"))
                    })
                    
                }
                .padding()
                
                Image("\(matiere.filiere)\(matiere.title.lowercased())")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, UIScreen.main.bounds.height > 750 ? 75 : 45)
                    .background(Color("whitebutton").clipShape(Circle()).padding(.top, 50))
                    .padding(.top, 25)
                
                Spacer()
                
                HStack(spacing: 25){
                    
                    Button(action: {withAnimation(.spring()){sousfiliere = true}}) {
                        ZStack{
                            Circle()
                                .fill(Color("lightblue"))
                                .frame(width: 24, height: 24)
                            
                            Circle()
                                .stroke(Color("black"), lineWidth: 1)
                                .frame(width: 32, height: 32)
                                .opacity(sousfiliere ? 1 : 0)
                        }
                    }
                    
                    Button(action: {withAnimation(.spring()){sousfiliere = false}}) {
                        ZStack{
                            Circle()
                                .fill(Color("red"))
                                .frame(width: 24, height: 24)
                            
                            Circle()
                                .stroke(Color("black"), lineWidth: 1)
                                .frame(width: 32, height: 32)
                                .opacity(!sousfiliere ? 1 : 0)
                        }
                    }
                }
                .padding(.top,25)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text(matiere.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("black"))
                    
                    Text((!sousfiliere ? matiere.filiere : matiere.sousfiliere))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(!sousfiliere ? Color("red") : Color("lightblue"))
                    
                    Text((!sousfiliere ? matiere.descf : matiere.descsf))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("grey"))
                        .padding(.top, 8)
                }
                .padding(.top, 15)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.bottom, 25)
            .background(Color("lightgrey").clipShape(CustomCorner(corners: [.bottomLeft,.bottomRight], size: 45)).ignoresSafeArea(.all, edges: .top))
            
            Button(action: {withAnimation(.spring()){self.showview = "chapselection"}}) {
                Text("Parcourir les Quizzs")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 45)
                    .background(Color("orange"))
                    .clipShape(Capsule())
                    .padding(.vertical)
                    .padding(.bottom)
                
            }
        }
        .background(Color("purple1").ignoresSafeArea())
    }
}
