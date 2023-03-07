//
//  walkpage4.swift
//  Quizz
//
//  Created by matteo on 26/07/2021.
//

import SwiftUI

struct walkpage4: View{
    
    var filieres: [Filiere]
    
    @State var showprepa: Bool = false
    
    var body: some View{
        VStack(alignment: .leading, spacing: 10){
            
            Text("Une dernière chose")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.leading)
            Text("Pour faire partie du classement et devenir le majorant de France, il te faut une image de profil et un joli nom !")
                .font(.subheadline)
                .foregroundColor(Color("lightgrey"))
                .fontWeight(.medium)
                .padding(.leading)
            
            
            ZStack(){
                
                if !showprepa{
                    profilcreation(showprepa: $showprepa, filieres: filieres)
                        .padding()
                } else {
                    prepaselection(showprepa: $showprepa)
                        .padding(.leading, 10)
                        .padding(.top)
                        .padding(.horizontal)
                        .transition(.move(edge: .trailing))
                        .zIndex(1)
                }
            }
            .frame(height: UIScreen.main.bounds.width)
            .background(Color("lightgrey"))
            .cornerRadius(10)
            .padding(.top)
            
            Text("tu ne pourra actualiser tes informations qu'\(Text("une seule").fontWeight(.semibold)) fois")
                .padding(.leading)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.6))
            
            Spacer()
        }
        .padding()
        .background(Color("purple1").ignoresSafeArea(edges: .all))
    }
}


struct profilcreation: View{
    
    @AppStorage("username") var username: String = ""
    @AppStorage("userfiliere") var userfiliere: String = ""
    @AppStorage("usersousfiliere") var usersousfiliere: String = ""
    @AppStorage("userannee") var userannee: Int = 2
    @AppStorage("useravatar") var useravatar: String = ""
    @AppStorage("usercolor") var usercolor: String = ""
    @AppStorage("userprepa") var userprepa: String = "Aucune"
    
    @Binding var showprepa: Bool
    
    @State var filieres: [Filiere]
    
    @State var validusername: Bool = false
    @State var selectedtab: Int = 1
    @State var usernameavailable: Bool = false
    @State var commited: Bool = false
    @State var selectedannee: String = "3/2"
    
    let baseset: [AvatarColor] = [AvatarColor(type: "avatar", name: "baseset1", set: "Base", unlocked: true, rarity: "common", price: 0), AvatarColor(type: "avatar", name: "baseset2", set: "Base", unlocked: true, rarity: "common", price: 0), AvatarColor(type: "avatar", name: "baseset3", set: "Base", unlocked: true, rarity: "common", price: 0), AvatarColor(type: "avatar", name: "baseset4", set: "Base", unlocked: true, rarity: "common", price: 0)]
    
    let basepalette: [AvatarColor] = [AvatarColor(type: "color", name: "basepalette1", set: "Base", unlocked: true, rarity: "common", price: 0), AvatarColor(type: "color", name: "basepalette2", set: "Base", unlocked: true, rarity: "common", price: 0), AvatarColor(type: "color", name: "basepalette3", set: "Base", unlocked: true, rarity: "common", price: 0), AvatarColor(type: "color", name: "basepalette4", set: "Base", unlocked: true, rarity: "common", price: 0)]
    
    var body: some View{
        
        VStack(alignment: .center, spacing: 25){
            HStack(spacing: 0){
                
                userIcon(size: UIScreen.main.bounds.width*0.3)
                    .padding(.leading)
                
                TabView(selection: $selectedtab){
                    
                    displayset(elements: baseset, selectedavatar: $useravatar, selectedcolor: $usercolor)
                        .tag(1)
                    
                    displayset(elements: basepalette, selectedavatar: $useravatar, selectedcolor: $usercolor)
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(width: UIScreen.main.bounds.width*0.475, height: UIScreen.main.bounds.width*0.52)
                .overlay(
                    HStack{
                        Circle()
                            .fill(selectedtab == 1 ? Color("purple1") : Color.black.opacity(0.3))
                            .frame(width: 7, height: 7)
                        Circle()
                            .fill(selectedtab == 2 ? Color("purple1") : Color.black.opacity(0.3))
                            .frame(width: 7, height: 7)
                    }
                    ,alignment: .bottom
                )
                
            }
            HStack(){
                TextField("pseudo", text: $username, onCommit: {
                    username = username.removeWhiteSpaces()
                    if username.count <= 10 && username.count > 2{
                        Leaderboard().checkUsernameAvailability(username: username) { available in
                            usernameavailable = available
                            if available{ validusername = true } else{ validusername = false}
                        }
                        commited = true
                    }
                })
                .keyboardType(.asciiCapable)
                .disableAutocorrection(true)
                .font(.title3)
                .foregroundColor(.black.opacity(0.6))
                .background(Color("lightgrey"))
                .onTapGesture {
                    commited = false
                }
                .padding(.trailing)
                .padding(.leading, 5)
                
                Menu{
                    Button("1ère année", action: {
                        userannee = 1
                        userfiliere = "MPSI"
                        usersousfiliere = "MP"
                        selectedannee = "1/2"
                    })
                    Button("2ème année", action: {
                        userannee = 2
                        userfiliere = "MP"
                        usersousfiliere = "MPSI"
                        selectedannee = "3/2"
                    })
                    Button("5/2 (force à toi)", action: {
                        userannee = 2
                        userfiliere = "MP"
                        usersousfiliere = "MPSI"
                        selectedannee = "5/2"
                    })
                } label: {
                    Text(selectedannee)
                        .font(.title3)
                        .foregroundColor(.black.opacity(0.6))
                }
                
                Rectangle()
                    .fill(Color.gray.opacity(0.7))
                    .frame(width: 1, height: 15)
                    .padding(.horizontal, 5)
                
                Menu{
                    if userannee == 1{
                        ForEach(filieres.indices, id:\.self){ index in
                            Button(filieres[index].sousfiliere, action: {
                                userfiliere = filieres[index].sousfiliere
                                usersousfiliere = filieres[index].name
                            })
                        }
                    } else {
                        ForEach(filieres.indices, id:\.self){ index in
                            Button(filieres[index].name, action: {
                                userfiliere = filieres[index].name
                                usersousfiliere = filieres[index].sousfiliere
                            })
                        }
                    }
                } label: {
                    Text(userfiliere)
                        .font(.title3)
                        .foregroundColor(.black.opacity(0.6))
                }
            }
            .padding(12)
            .background(Color("lightgrey"))
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("purple1"), lineWidth: 3))
            .overlay(
                VStack{
                    if commited{
                        Text(usernameavailable ? "" : "pseudo indisponible")
                            .foregroundColor(.gray)
                            .font(.caption)
                    } else {
                        Text(username == "" ? "" : username.count < 3 ? "pseudo trop court" : username.count > 10 ? "pseudo trop long" : "")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                }
                .offset(y: 20)
                ,alignment: .bottomLeading
            )
            HStack{
                Text("Ma prépa :")
                    .foregroundColor(Color.black.opacity(0.6))
                Button(action: {withAnimation(.spring()){showprepa = true}}, label: {
                    Text(userprepa)
                        .lineLimit(1)
                })
                Spacer()
            }
            .padding(.leading, 17)
        }
        .onAppear(perform: {
            if username.count > 2 && username.count < 11{
                Leaderboard().checkUsernameAvailability(username: username, completion: { result in
                    self.usernameavailable = result
                    commited = true
                })
            }
        })
    }
}
