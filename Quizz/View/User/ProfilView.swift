//
//  profilview.swift
//  Quizz
//
//  Created by matteo on 29/07/2021.
//

import SwiftUI

struct ProfilView: View {
    
    @AppStorage("username") var username: String = ""
    @AppStorage("userfiliere") var userfiliere: String = ""
    
    @Binding var showview: String
    
    @State var xpprogress: CGFloat
    @State var userInfos: Informations
    @State var expInfos: ExperienceStruct
    
    @State var animpoint : Bool = false
    
    init(showview: Binding<String>){
        let userinfo = DB_Manager().getUserInfos()
        let expinfo = Experience().getXPInfos(exp: Double(userinfo.exp))
        let xppro = CGFloat((Double(expinfo.exp)/Double(expinfo.xpneeded)))
        
        self.userInfos = userinfo
        self.expInfos = expinfo
        self.xpprogress = xppro
        self._showview = showview
    }
    
    var body: some View {
        
        VStack(spacing: 0){
            
            HStack {
                
                Text("Profil")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Spacer()
                
                Button(action: {withAnimation(.spring()){self.showview = "settings"}}, label: {
                    Image("Paramètres")
                        .renderingMode(.template)
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                })
                
                
            }
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView(showsIndicators: false){
                
                Button(action:{}, label:{
                    Text("NIVEAU \(expInfos.niveau)")
                        .foregroundColor(.white)
                        .padding(5)
                        .padding(.horizontal)
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color("whitebutton"), lineWidth: 2))
                })
                .padding(.bottom, 10)
                .padding(.top, 1)
                
                VStack{
                    
                    ZStack(alignment: .top){
                        
                        VStack{
                            
                            HStack(){
                                VStack(alignment: .leading, spacing: 1){
                                        Text(username)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .scaledToFit()
                                    
                                        Text(userfiliere)
                                            .font(.subheadline)
                                            .foregroundColor(.white).opacity(0.6)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 1){
                                    Text(expInfos.rang)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .scaledToFit()
                                    
                                    Text("\(String(expInfos.exp))/\(String(expInfos.xpneeded))XP")
                                        .lineLimit(1)
                                        .font(.subheadline)
                                        .foregroundColor(.white).opacity(0.6)
                                }
                            }
                            .padding()
                            
                            Spacer()
                        }
                        
                        userIcon(size: UIScreen.main.bounds.width*0.4)
                            .overlay(
                                
                                CircularProgress(progress: xpprogress)
                            )
                            .overlay(
                                Button(action:{withAnimation(.spring()){self.showview = "customprofil"}}, label:{
                                    Circle()
                                        .fill(Color("orange"))
                                        .frame(width: 36, height: 36)
                                        .overlay(Circle().stroke(Color(.white), lineWidth: 5).shadow(radius: 10))
                                        .overlay(Image("Quizz").resizable().renderingMode(.template).foregroundColor(.white).aspectRatio(contentMode: .fit).padding(10))
                                })
                                ,alignment: .bottomTrailing
                            )
                        
                    }
                    .frame(height: UIScreen.main.bounds.width*0.4)
                    
                    Spacer()
                    
                    ActivityHistoryView()
                        .padding(.top, UIScreen.main.bounds.height > 750 ? 25 : 7)
                    
                    Spacer()
                }
                .offset(y: -UIScreen.main.bounds.width*0.2)
                .frame(width: UIScreen.main.bounds.width)
                .background(
                    Color("lightgrey")
                        .clipShape(CustomCorner(corners: [.topLeft,.topRight], size: 55))
                        .ignoresSafeArea(.all, edges: .top))
                .padding(.top, UIScreen.main.bounds.width*0.2)
                .overlay(Rectangle().fill(Color("lightgrey")).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.2).offset(y: UIScreen.main.bounds.height*0.2), alignment: .bottom)
            }
            .padding(.top, UIScreen.main.bounds.height > 750 ? 35 : 0)
            
        }
        .background(Color("purple1"))
        .onAppear(perform: {
            self.userInfos = DB_Manager().getUserInfos()
            self.expInfos = Experience().getXPInfos(exp: Double(userInfos.exp))
            self.xpprogress = CGFloat((Double(expInfos.exp)/Double(expInfos.xpneeded)))
        })
        .onDisappear(perform: {
            self.animpoint = false
        })
    }
}

struct CircularProgress: View{
    
    @State var progress: CGFloat
    @State var animation: Bool = false
    
    var body: some View{
        ZStack{
            Circle()
                .trim(from: 0, to: 1)
                .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round))
                .foregroundColor(Color("white"))
                .aspectRatio(contentMode: .fit)
                .rotationEffect(Angle(radians: Double.pi))
            
            
            Circle()
                .trim(from: 0.0, to: animation ? progress : 0)
                .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("green"))
                .aspectRatio(contentMode: .fit)
                .rotationEffect(Angle(radians: .pi/2))
                .animation(.easeInOut(duration: 2))
        }
        .onAppear(perform: {
            let userInfos = DB_Manager().getUserInfos()
            let expInfos = Experience().getXPInfos(exp: Double(userInfos.exp))
            self.progress = CGFloat((Double(expInfos.exp)/Double(expInfos.xpneeded)))
            self.animation = true
        })
        .onDisappear(perform: {
            self.animation = false
        })
    }
}
