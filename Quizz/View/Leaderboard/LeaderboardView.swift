//
//  LeaderboardView.swift
//  Quizz
//
//  Created by matteo on 11/07/2021.
//

import SwiftUI

struct LeaderboardView: View {
    
    @AppStorage("username") var username : String = ""
    @AppStorage("userid") var userid : String = ""
    @AppStorage("userfiliere") var userfiliere : String = ""
    @AppStorage("userprepa") var userprepa: String = ""
    @AppStorage("usersousfiliere") var usersousfiliere : String = ""
    @AppStorage("useravatar") var usericon : String = ""
    @AppStorage("usercolor") var usercolor : String = ""
    
    @StateObject var leaderboard = Leaderboard()
    
    @State private var selectedTab = 0
    @State private var userweeklyscore : Int = -1
    @State private var userbimonthlyscore: Int = -1
    @State private var usermonthlyscore: Int = -1
    @State private var weeknum: Int = 1
    
    @State private var headersize: CGRect = CGRect()
    
    let nouser: dbuser = dbuser(name: "", filiere: "", prepa: "", weeklyscore: 0, bimonthlyscore: 0, monthlyscore: 0, icon: "", color: "basepalette1")
    
    var body: some View {
        
        ZStack(alignment: .top){
            VStack(){
                ScrollView(.vertical, showsIndicators: false){
                    
                    VStack{
                        
                        if selectedTab == 0{
                            ForEach(4...9, id:\.self){ index in
                                leadercard(index: index, user: leaderboard.top10ALL.isEmpty ? sampleusers[index-1] : leaderboard.top10ALL.count < index ? nouser : leaderboard.top10ALL[index-1], general: true, scoretype: "weekly", selfcard: leaderboard.top10ALL.isEmpty ? false : leaderboard.top10ALL.count < index ? false : leaderboard.top10ALL[index-1].name == username ? true : false)
                                    .redacted(reason: leaderboard.top10ALL.isEmpty ? .placeholder : [])
                            }
                            if userweeklyscore <= leaderboard.top10ALL.last?.weeklyscore ?? Int.min && username != leaderboard.top10ALL.last?.name ?? ""{
                                leadercard(index: 10, user: dbuser(name: username, filiere: userfiliere, prepa: userprepa, weeklyscore: userweeklyscore, bimonthlyscore: userbimonthlyscore, monthlyscore: usermonthlyscore, icon: usericon, color: usercolor), general: selectedTab == 0, scoretype: "weekly", selfcard: true)
                            }
                        }
                        if selectedTab == 1{
                            ForEach(4...9, id:\.self){ index in
                                leadercard(index: index, user: leaderboard.top10Fil.isEmpty ? sampleusers[index-1] : leaderboard.top10Fil.count < index ? nouser : leaderboard.top10Fil[index-1], general: false, scoretype: "bimonthly", selfcard: leaderboard.top10Fil.isEmpty ? false : leaderboard.top10Fil.count < index ? false : leaderboard.top10Fil[index-1].name == username ? true : false)
                                    .redacted(reason: leaderboard.top10Fil.isEmpty ? .placeholder : [])
                            }
                            if userbimonthlyscore <= leaderboard.top10Fil.last?.bimonthlyscore ?? Int.min && username != leaderboard.top10Fil.last?.name ?? ""{
                                leadercard(index: 10, user: dbuser(name: username, filiere: userfiliere, prepa: userprepa, weeklyscore: userweeklyscore, bimonthlyscore: userbimonthlyscore, monthlyscore: usermonthlyscore, icon: usericon, color: usercolor), general: selectedTab == 0, scoretype: "bimonthly", selfcard: true)
                            }
                        }
                        if selectedTab == 2{
                            ForEach(4...9, id:\.self){ index in
                                leadercard(index: index, user: leaderboard.top10Classe.isEmpty ? sampleusers[index-1] : leaderboard.top10Classe.count < index ? nouser : leaderboard.top10Classe[index-1], general: false, scoretype: "monthly", selfcard: leaderboard.top10Classe.isEmpty ? false : leaderboard.top10Classe.count < index ? false : leaderboard.top10Classe[index-1].name == username ? true : false)
                                    .redacted(reason: leaderboard.top10Classe.isEmpty ? .placeholder : [])
                            }
                            if usermonthlyscore <= leaderboard.top10Classe.last?.monthlyscore ?? Int.min && username != leaderboard.top10Classe.last?.name ?? ""{
                                leadercard(index: 10, user: dbuser(name: username, filiere: userfiliere, prepa: userprepa, weeklyscore: userweeklyscore, bimonthlyscore: userbimonthlyscore, monthlyscore: usermonthlyscore, icon: usericon, color: usercolor), general: selectedTab == 0, scoretype: "monthly", selfcard: true)
                            }
                        }
                    }
                    .padding(.top, 75)
                    .padding(.bottom, UIScreen.main.bounds.height*0.13)
                }
            }
            .padding(.top, headersize.width-100)
            .background(Color("lightgrey"))
            
            VStack(spacing: 0){
                HStack {
                    
                    Text("Classement")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image("Classement")
                            .renderingMode(.template)
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    })
                }
                .padding()
                
                HStack{
                    triplemenuanimated(selectedTab: $selectedTab)
                        .padding(.leading)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing){
                        Text("Réinitialisation")
                            .foregroundColor(.white)
                            .font(.caption)
                            .fontWeight(.light)
                        Text("dans : \(getTimeRemaining(selectedTab: selectedTab, week: weeknum))")
                            .foregroundColor(.white)
                            .font(.caption)
                            .fontWeight(.light)
                            .redacted(reason: leaderboard.top10ALL.isEmpty ? .placeholder : [])
                    }
                    .padding(.trailing)
                }
                
                if selectedTab == 0{
                    top3view(users: leaderboard.top10ALL.isEmpty ? Array(sampleusers[0..<3]) : leaderboard.top10ALL.count < 3 ? leaderboard.top10ALL : Array(leaderboard.top10ALL[0..<3]), general: true, scoretype: "weekly", sample: false)
                        .redacted(reason: leaderboard.top10ALL.isEmpty ? .placeholder : [])
                }
                if selectedTab == 1{
                    top3view(users: leaderboard.top10Fil.isEmpty ? Array(sampleusers[0..<3]) : leaderboard.top10Fil.count < 3 ? leaderboard.top10Fil : Array(leaderboard.top10Fil[0..<3]), general: false, scoretype: "bimonthly", sample: false)
                        .redacted(reason: leaderboard.top10Fil.isEmpty ? .placeholder : [])
                }
                if selectedTab == 2{
                    top3view(users: leaderboard.top10Classe.isEmpty ? Array(sampleusers[0..<3]) : leaderboard.top10Classe.count < 3 ? leaderboard.top10Classe : Array(leaderboard.top10Classe[0..<3]), general: false, scoretype: "monthly", sample: false)
                        .redacted(reason: leaderboard.top10Classe.isEmpty ? .placeholder : [])
                }
            }
            .padding(.bottom, 10)
            .background(Color("purple1").opacity(1)
                            .clipShape(CustomCorner(corners: [.bottomLeft,.bottomRight], size: 55))
                            .ignoresSafeArea(.all, edges: .top))
            .overlay(Color.clear.modifier(GeometryGetterMod(rect: $headersize)))
            
            
        }
        .background(Color("lightgrey").ignoresSafeArea(.all, edges: .all))
        .onAppear(perform: {
            leaderboard.getWeekNum { result in
                self.weeknum = result
            }
            leaderboard.getUserScores(userID: userid, completion: { result in
                self.userweeklyscore = result[0]
                self.userbimonthlyscore = result[1]
                self.usermonthlyscore = result[2]
            })
            leaderboard.getTop10ALL()
            leaderboard.getTop10Filiere(filiere: userfiliere)
            leaderboard.getTop10Classe(filiere: userfiliere, prepa: userprepa)
        })
    }
    
    func getTimeRemaining(selectedTab: Int, week: Int) -> String{
        if selectedTab == 0{
            let delta = Date.today().next(.monday) - Date.today()
            if delta > 172800{
                return String("\(Int(round(delta/86400)))j")
            } else {
                return String(format:"%02ih%02i", Int(delta)/3600, Int(delta)/60%60)
            }
        }
        if selectedTab == 1{
            let delta = Date.today().next(.monday) - Date.today() + Double(604800 * (week % 2))
            if delta > 172800{
                return String("\(Int(round(Double(delta)/86400)))j")
            } else {
                return String(format:"%02ih%02i", Int(delta)/3600, Int(delta)/60%60)
            }
        }
        if selectedTab == 2{
            let delta = Date.today().next(.monday) - Date.today() + Double(604800 * (4 - week))
            if delta > 172800{
                return String("\(Int(round(delta/86400)))j")
            } else {
                return String(format:"%02ih%02i", Int(delta)/3600, Int(delta)/60%60)
            }
        } else {
            return ""
        }
    }
}


struct triplemenuanimated: View{
    
    @AppStorage("userfiliere") var userfiliere : String = ""
    
    @Binding var selectedTab: Int
    
    var body: some View{
        
        HStack(alignment: .center, spacing: 0){
            Button(action: {selectedTab = 0}, label: {
                Text("ALL")
                    .font(.subheadline)
                    .fontWeight(selectedTab == 0 ? .semibold : .none)
                    .foregroundColor(selectedTab == 0 ? Color("black") : Color(.white))
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                    .padding(.leading, 5)
            })
            Spacer()
            Button(action: {selectedTab = 1}, label: {
                    Text(userfiliere)
                        .font(.subheadline)
                        .fontWeight(selectedTab == 1 ? .semibold : .none)
                        .foregroundColor(selectedTab == 1 ? Color("black") : Color(.white))
                        .padding(.vertical, 12)
                        .padding(.horizontal, 12)
                        .lineLimit(1)
            })
            Spacer()
            Button(action: {selectedTab = 2}, label: {
                    Text("CLASSE")
                        .font(.subheadline)
                        .fontWeight(selectedTab == 2 ? .semibold : .none)
                        .foregroundColor(selectedTab == 2 ? Color("black") : Color(.white))
                        .padding(.vertical, 12)
                        .padding(.horizontal, 12)
                        .padding(.trailing, 5)
                        .lineLimit(1)
            })
                        
        }
        .background(
            Color(.black).opacity(0.4)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("whitebutton"))
                        .frame(width: selectedTab == 0 ? 52.5 : selectedTab == 1 ? 75 : 85, height: 35)
                        .padding(5)
                        .offset(x: selectedTab == 1 ? -15 : 0)
                    ,alignment: selectedTab == 0 ? .leading : selectedTab == 1 ? .center : .trailing
                )
                .animation(.spring())
        )
        .cornerRadius(25)
        .frame(width: UIScreen.main.bounds.width*0.65)
    }
}


var sampleusers : [dbuser] = [dbuser(name: "mattéo", filiere: "MP", prepa: "", weeklyscore: 0, bimonthlyscore: 0, monthlyscore: 0, icon: "baseset5", color: "basecolor-green"), dbuser(name: "romain_mc", filiere: "PSI", prepa: "", weeklyscore: 0, bimonthlyscore: 0, monthlyscore: 0, icon: "baseset1", color: "basecolor-blue"), dbuser(name: "guigui", filiere: "PC", prepa: "", weeklyscore: 0, bimonthlyscore: 0, monthlyscore: 0, icon: "baseset3", color: "basecolor-brown"), dbuser(name: "linamelia", filiere: "MP", prepa: "", weeklyscore: 0, bimonthlyscore: 0, monthlyscore: 0, icon: "baseset4", color: "basecolor-red"), dbuser(name: "caroline", filiere: "MP", prepa: "", weeklyscore: 0, bimonthlyscore: 0, monthlyscore: 0, icon: "baseset2", color: "basecolor-purple3"), dbuser(name: "améliecati", filiere: "PSI", prepa: "", weeklyscore: 0, bimonthlyscore: 0, monthlyscore: 0, icon: "baseset8", color: "basecolor-red"), dbuser(name: "thomascart", filiere: "PCSI", prepa: "", weeklyscore: 0, bimonthlyscore: 0, monthlyscore: 0, icon: "baseset7", color: "basecolor-skyblue"), dbuser(name: "requin", filiere: "MP", prepa: "", weeklyscore: 0, bimonthlyscore: 0, monthlyscore: 0, icon: "baseset9", color: "basecolor-red"), dbuser(name: "camomille", filiere: "MP", prepa: "", weeklyscore: 0, bimonthlyscore: 0, monthlyscore: 0, icon: "baseset6", color: "basecolor-orange")]

