//
//  BadgesView.swift
//  Quizz
//
//  Created by matteo on 03/07/2021.
//

import SwiftUI


struct BadgesView: View {
    
    @State private var selectedtab = 0
    @State var badgesModels: [Badge] = []
    
    @State var showall: Bool = false
    
    var userfiliere: String
    var usersousfiliere: String
    
    var menu: [String]
    var shortmenu: [String]
    
    init(userfiliere: String, usersousfiliere: String) {
        self.userfiliere = userfiliere
        self.usersousfiliere = usersousfiliere
        menu = ["Général"]
        let filieres = DB_Manager().getFilieres()
        for filiere in filieres{
            menu.append(filiere.name)
        }
        shortmenu = ["Général", userfiliere, usersousfiliere]
    }
    
    var body: some View {
        
        VStack(spacing: 0){
            
            VStack(alignment: .leading){
                HStack{
                    Text("LISTE DES BADGES")
                        .font(Font.headline.weight(.heavy))
                        .foregroundColor(Color("black").opacity(0.7))
                    Spacer()
                }
                HStack{
                    Text("Fait un appui long pour inspecter le badge.")
                        .font(.caption)
                        .foregroundColor(Color("black").opacity(0.5))
                    Spacer()
                }
            }
            .padding(.bottom, 16)
            
            if !showall{
                
                HStack(spacing: 0){
                    
                    ForEach(shortmenu.indices,id: \.self){index in
                        Button(action: {selectedtab = index}, label: {
                            Text(shortmenu[index])
                                .font(.system(size: 15))
                                .fontWeight(selectedtab == index ? .bold : .none)
                                .foregroundColor(selectedtab == index ? Color("black") : Color("black").opacity(0.7))
                                .padding(.vertical, 5)
                                .padding(.horizontal, 20)
                            
                        })
                            Spacer(minLength: 0)
                    }
                    
                    Button(action: {showall = true}, label: {
                        Text("+")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .padding(5)
                            .padding(.horizontal, 5)
                            .background(Color("whitebutton"))
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.2), radius: 5)
                            .padding(5)
                            .padding(.horizontal, 5)
                        
                    })
                }
                .padding(.vertical, 5)
                
                badgestabview(selectedtab: $selectedtab, menu: shortmenu)
            } else {
                
                ScrollView(.horizontal, showsIndicators: false){
                        
                        HStack(spacing: 0){
                            
                            ForEach(menu.indices,id: \.self){index in
                                Button(action: {selectedtab = index}, label: {
                                    Text(menu[index])
                                        .font(.system(size: 15))
                                        .fontWeight(selectedtab == index ? .bold : .none)
                                        .foregroundColor(selectedtab == index ? Color("black") : Color("black").opacity(0.7))
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 20)
                                    
                                })
                                Spacer(minLength: 0)
                            }
                            Button(action: {selectedtab = 0; showall = false}, label: {
                                Text("-")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .padding(5)
                                    .padding(.horizontal, 5)
                                    .background(Color("whitebutton"))
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.2), radius: 5)
                                    .padding(5)
                                    .padding(.horizontal, 5)
                            })
                        }
                        .padding(.vertical, 5)
                }
                
                badgestabview(selectedtab: $selectedtab, menu: menu)
                
            }
            
        }
        .padding(.horizontal)
    }
}


//struct BadgeVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        BadgesView()
//    }
//}
