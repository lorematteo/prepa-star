//
//  Quizz.swift
//  Quizz
//
//  Created by matteo on 14/05/2021.
//

import SwiftUI

struct QuizzView : View {
    
    @AppStorage("userfiliere") var userfiliere: String = ""
    @AppStorage("usersousfiliere") var usersousfiliere: String = ""
    @AppStorage("userannee") var userannee: Int = 2
    
    @Binding var showview : String
    @Binding var selectedfiliere : Filiere
    @Binding var selectedmatiere : Matiere
    @Binding var disabled: Bool
    
    @State var matieres: [Matiere] = []
    
    
    var body: some View{
        
        VStack {
            
            HStack {
                
                Text("Quizz")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {}, label: {
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                        Image("chat")
                            .renderingMode(.template)
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    })
                })
                
                
            }
            .padding()
            
            FiliereMenu(selected: $selectedfiliere, matieres: $matieres)
            
            ScrollView(.vertical, showsIndicators: false){
                if matieres.isEmpty{
                    VStack(alignment: .center, spacing: 50){
                        VStack(spacing: 15){
                            Text("Nouvelles matières à venir...")
                                .font(Font.headline.weight(.heavy))
                                .foregroundColor(Color("black").opacity(0.6))
                            Text("Si tu fait partie de la filière \(selectedfiliere.name) ou \(selectedfiliere.sousfiliere) et que tu aimerais créer tes propres quizzs, n'hésite pas à me contacter via l'assistance dans l'onglet paramètre du menu.")
                                .font(Font.subheadline.weight(.semibold))
                                .foregroundColor(Color("black").opacity(0.5))
                                .multilineTextAlignment(.center)
                        }
                        Text("En plus, tu aura ton nom en fin de quizz !")
                            .font(Font.subheadline.weight(.medium))
                            .foregroundColor(Color("black").opacity(0.5))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.top, 150)
                    .transition(.opacity)
                } else {
                    VStack(spacing: 15){
                        
                        ForEach(matieres,id: \.id){matiereelement in
                            
                            CardView(matiere: matiereelement, filiere: selectedfiliere)
                                .shadow(color: Color.black.opacity(0.16), radius: 5, x: 0, y: 5)
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        selectedmatiere = matiereelement
                                        showview = "detailview"
                                    }
                                }
                                .disabled(disabled)
                        }
                    }
                    .padding(.horizontal, 22)
                    .padding(.bottom, UIScreen.main.bounds.height*0.13)
                    .transition(.opacity)
                }
            }
            .padding(.bottom, 7)
            .frame(width: UIScreen.main.bounds.width)
            .background(Color("lightgrey")
                            .clipShape(CustomCorner(corners: [.topLeft,.topRight], size: 55))
                            .ignoresSafeArea(.all, edges: .bottom)
                            .padding(.top, 80))
        }
        .onAppear(perform: {
            withAnimation(.spring()){
                self.matieres = DB_Manager().getMatieres(filiereValue: userannee == 1 ? usersousfiliere : userfiliere)
                
                let defaultFiliere : Filiere = Filiere()
                defaultFiliere.name = userannee == 1 ? usersousfiliere : userfiliere
                defaultFiliere.sousfiliere = userannee == 1 ? userfiliere : usersousfiliere
                self.selectedfiliere = defaultFiliere
            }
        })
        .background(Color("purple1").ignoresSafeArea(.all, edges: .all))
    }
}


// card view...

struct CardView : View {
    
    var matiere : Matiere
    var filiere : Filiere
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
            HStack(spacing: 15){
                Text(matiere.shortTitle)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color("black"))
                    .lineLimit(1)
                
                Spacer(minLength: 0)
                Image("\(matiere.filiere)\(matiere.title.lowercased())")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                //max size
                    .frame(height: 180)
            }
            .padding(.horizontal)
            .padding(.bottom)
            .background(Color("whitebutton").cornerRadius(25).padding(.top, 35))
            .padding(.trailing, 8)
            .background(Color("cardviewcolor").cornerRadius(25).padding(.top, 35))
            
            Text("\(filiere.name) / \(filiere.sousfiliere)")
                .foregroundColor(Color("black").opacity(0.6))
                .padding(.vertical, 10)
                .padding(.horizontal, 35)
                .background(Color("cardviewcolor").opacity(0.4))
                .clipShape(CustomCorner(corners: [.topRight, .bottomLeft], size: 25))
        }
        
    }
}


