//
//  walkthroughview.swift
//  Quizz
//
//  Created by matteo on 12/07/2021.
//

import SwiftUI

struct WalkthroughView: View {
    
    @AppStorage("firstlaunch") var firstlaunch: Bool = true
    @AppStorage("username") var username: String = ""
    @AppStorage("userid") var userid: String = ""
    @AppStorage("userfiliere") var userfiliere: String = "MP"
    @AppStorage("userprepa") var userprepa: String = ""
    @AppStorage("usersousfiliere") var usersousfiliere: String = "MPSI"
    @AppStorage("userannee") var userannee: Int = 2
    @AppStorage("useravatar") var useravatar: String = "baseset1"
    @AppStorage("usercolor") var usercolor: String = "basecolor-red"
    
    
    @State var finished: Bool = false
    
    @State var currentpage: Int = 0
    @State var order: String = "next"
    var totalpage = 3
    
    var filieres: [Filiere]
    
    init(){
        self.filieres = DB_Manager().getFilieres()
    }
    
    var body: some View {
        ZStack{
            
            if currentpage == 0{
                walkpage1()
                    .transition(order == "next" ? .asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .move(edge: .leading).combined(with: .opacity)) : .asymmetric(insertion: .move(edge: .leading).combined(with: .opacity), removal: .move(edge: .trailing).combined(with: .opacity)))
            }
            if currentpage == 1{
                walkpage2()
                    .transition(order == "next" ? .asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .move(edge: .leading).combined(with: .opacity)) : .asymmetric(insertion: .move(edge: .leading).combined(with: .opacity), removal: .move(edge: .trailing).combined(with: .opacity)))
            }
            if currentpage == 2{
                walkpage3()
                    .transition(order == "next" ? .asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .move(edge: .leading).combined(with: .opacity)) : .asymmetric(insertion: .move(edge: .leading).combined(with: .opacity), removal: .move(edge: .trailing).combined(with: .opacity)))
            }
            if currentpage == 3{
                walkpage4(filieres: filieres)
                    .transition(order == "next" ? .asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .move(edge: .leading).combined(with: .opacity)) : .asymmetric(insertion: .move(edge: .leading).combined(with: .opacity), removal: .move(edge: .trailing).combined(with: .opacity)))
            }
        }
        .onAppear(perform: {
            userfiliere = "MP"
            usersousfiliere = "MPSI"
            userannee = 2
            useravatar = "baseset1"
            usercolor = "basepalette1"
        })
        .overlay(
            ZStack{
                Button(action: {
                    order = "next"
                    withAnimation(.easeInOut){
                        if currentpage < totalpage{
                            currentpage += 1
                        }
                    }
                }, label: {
                    Image("thinarrowright")
                        .renderingMode(.template)
                        .foregroundColor(.black)
                        .frame(width: 60, height: 60)
                        .background(Color(.white))
                        .clipShape(Circle())
                        .overlay(
                            ZStack{
                                Circle()
                                    .stroke(Color.black.opacity(0.1), lineWidth: 4)
                                Circle()
                                    .trim(from:0, to: CGFloat(currentpage) / CGFloat(totalpage))
                                    .stroke(Color.white, lineWidth: 4)
                                    .rotationEffect(.init(degrees: -90))
                            }
                            .padding(-15)
                        )
                })
                .padding()
                .padding()
                .opacity(currentpage == totalpage ? 0 : 1)
                .animation(.easeIn)
            }
            ,alignment: .bottom)
        .overlay(
            VStack{
                Spacer()
                Button(action: {
                    order = "back"
                    withAnimation(.easeInOut){
                        if currentpage > 0{
                            currentpage -= 1
                        }
                    }
                }, label: {
                    Image("thinarrowleft")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                })
                .padding()
                .padding()
            }
            .ignoresSafeArea(.keyboard)
            .opacity(currentpage == 0 ? 0 : 1)
            ,alignment: .bottomLeading
        )
        .overlay(
            VStack{
                Spacer()
                Button(action: {
                    if username != ""{
                        if username.count > 2 && username.count < 11{
                            Leaderboard().checkUsernameAvailability(username: username) { available in
                                if available{
                                    Leaderboard().addUser(user: dbuser(name: username, filiere: userfiliere, prepa: userprepa, weeklyscore: 0, bimonthlyscore: 0, monthlyscore: 0, icon: useravatar, color: usercolor)){ result in self.userid = result}
                                    self.firstlaunch = false
                                }
                            }
                        }
                    }
                }, label: {
                    Text("C'est parti !")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width*0.35, height: 60)
                        .background(Color("orange"))
                        .clipShape(Capsule())
                })
                .overlay(Capsule().stroke(Color(.white), lineWidth: 3).shadow(radius: 10))
                .padding()
                .padding()
                .opacity(currentpage == totalpage ? username.count > 2 && username.count < 11 ? 1 : 0.6 : 0)
                .animation(.easeIn)
                .disabled(!(username.count > 2 && username.count < 11))
            }
            .ignoresSafeArea(.keyboard)
            ,alignment: .bottomTrailing
        )
        .background(Color("purple1").ignoresSafeArea(edges: .all))
        .onAppear(perform: {
            Leaderboard().checkUsernameAvailability(username: username) { available in
                if available{
                    if username.count <= 10 && username.count > 2{
                        self.finished = true
                    }
                }
            }
        })
    }
}
