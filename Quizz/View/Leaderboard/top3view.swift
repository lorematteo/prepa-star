//
//  top3view.swift
//  Quizz
//
//  Created by matteo on 12/07/2021.
//

import SwiftUI

struct top3view: View {
    
    @AppStorage("username") var username: String = ""
    
    var users: [dbuser]
    var general: Bool
    var scoretype: String
    
    var sample: Bool = false
    
    init(users: [dbuser], general: Bool, scoretype: String, sample: Bool){
        let nouser: dbuser = dbuser(name: "", filiere: "", prepa: "", weeklyscore: 0, bimonthlyscore: 0, monthlyscore: 0, icon: "", color: "basepalette1")
        
        self.general = general
        self.scoretype = scoretype
        self.users = users + [nouser, nouser, nouser]
        self.sample = sample
    }
    
    
    var body: some View {
        ZStack{
            HStack{
                Circle()
                    .fill(Color("purple2").opacity(0.1))
                    .frame(width: sample ? UIScreen.main.bounds.width*0.125 : UIScreen.main.bounds.width*0.25, height: sample ? UIScreen.main.bounds.width*0.125 : UIScreen.main.bounds.width*0.25)
                Circle()
                    .fill(Color("purple2").opacity(0.1))
                    .frame(width: sample ? UIScreen.main.bounds.width*0.2 : UIScreen.main.bounds.width*0.45, height: sample ? UIScreen.main.bounds.width*0.2 : UIScreen.main.bounds.width*0.45)
                Circle()
                    .fill(Color("purple2").opacity(0.1))
                    .frame(width: sample ? UIScreen.main.bounds.width*0.125 : UIScreen.main.bounds.width*0.25, height: sample ? UIScreen.main.bounds.width*0.125 : UIScreen.main.bounds.width*0.25)
            }
            HStack{
                
                VStack{
                    VStack(spacing: 0){
                        Text("2")
                            .font(sample ? .caption : .callout)
                            .foregroundColor(users[1].name == username ? .yellow : .white)
                            .fontWeight(.light)
                        Image(systemName: "triangle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(users[1].name == username ? .yellow : .white)
                            .frame(width: 8, height: 8)
                            .rotationEffect(.degrees(180))
                    }
                    .unredacted()
                    
                    userIcon(size: sample ? UIScreen.main.bounds.width*0.125 : UIScreen.main.bounds.width*0.225, linewidth: sample ? 3 : 7, otheruser: true, otheruseravatar: users[1].icon, othusercolor: users[1].color)
                        .clipShape(Circle())
                        .clipped()
                        .shadow(color: users[1].name == username ? .yellow.opacity(0.5) : Color("white").opacity(0.5), radius: 20, x: 0, y: 0)
                    Text(scoretype == "weekly" ? String(users[1].weeklyscore) : scoretype == "bimonthly" ? String(users[1].bimonthlyscore) : String(users[1].monthlyscore))
                        .font(sample ? .caption : .callout)
                        .foregroundColor(users[1].name == username ? .yellow : .white)
                        .fontWeight(.thin)
                    Text(users[1].name)
                        .font(sample ? .caption : .body)
                        .foregroundColor(users[1].name == username ? .yellow : .white)
                        .fontWeight(.medium)
                        .lineLimit(1)
                    Text(users[1].filiere)
                        .font(sample ? .caption2 : .caption)
                        .foregroundColor(users[1].name == username ? .yellow.opacity(0.8) : .white.opacity(0.8))
                        .fontWeight(.medium)
                        .opacity(general ? 1 : 0)
                        .animation(.easeIn)
                    
                }
                .frame(width: sample ? UIScreen.main.bounds.width/6 : UIScreen.main.bounds.width/4)
                
                VStack{
                    Image("crown")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: sample ? 25 : 45, height:  sample ? 25 : 45)
                        .offset(y: 7)
                        .unredacted()
                    userIcon(size: sample ? UIScreen.main.bounds.width*0.15 : UIScreen.main.bounds.width*0.3, linewidth: sample ? 3 : 7, otheruser: true, otheruseravatar: users[0].icon, othusercolor: users[0].color)
                        .clipShape(Circle())
                        .clipped()
                        .shadow(color: users[0].name == username ? .yellow.opacity(0.5) : Color("white").opacity(0.5), radius: 40, x: 0, y: 0)
                    Text(scoretype == "weekly" ? String(users[0].weeklyscore) : scoretype == "bimonthly" ? String(users[0].bimonthlyscore) : String(users[0].monthlyscore))
                        .font(sample ? .footnote : .callout)
                        .foregroundColor(users[0].name == username ? .yellow : .white)
                        .fontWeight(.thin)
                    
                    Text(users[0].name)
                        .font(sample ? .subheadline : .body)
                        .foregroundColor(users[0].name == username ? .yellow : .white)
                        .fontWeight(.medium)
                    Text(users[0].filiere)
                        .font(sample ? .caption : .caption)
                        .foregroundColor(users[0].name == username ? .yellow.opacity(0.8) : .white.opacity(0.8))
                        .fontWeight(.medium)
                        .opacity(general ? 1 : 0)
                        .animation(.easeIn)
                    
                }
                .frame(width: sample ? UIScreen.main.bounds.width/5 : UIScreen.main.bounds.width/3)
                
                VStack{
                    
                    VStack(spacing: 0){
                        Text("3")
                            .font(sample ? .caption : .callout)
                            .foregroundColor(users[2].name == username ? .yellow : .white)
                            .fontWeight(.light)
                        Image(systemName: "triangle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(users[2].name == username ? .yellow : .white)
                            .frame(width: 8, height: 8)
                            .rotationEffect(.degrees(180))
                    }
                    .unredacted()
                    
                    userIcon(size: sample ? UIScreen.main.bounds.width*0.125 : UIScreen.main.bounds.width*0.225, linewidth: sample ? 3 : 7, otheruser: true, otheruseravatar: users[2].icon, othusercolor: users[2].color)
                        .clipShape(Circle())
                        .clipped()
                        .shadow(color: users[2].name == username ? .yellow.opacity(0.5) : Color("white").opacity(0.5), radius: 20, x: 0, y: 0)
                    Text(scoretype == "weekly" ? String(users[2].weeklyscore) : scoretype == "bimonthly" ? String(users[2].bimonthlyscore) : String(users[2].monthlyscore))
                        .font(sample ? .caption : .callout)
                        .foregroundColor(users[2].name == username ? .yellow : .white)
                        .fontWeight(.thin)
                    Text(users[2].name)
                        .font(sample ? .caption : .body)
                        .foregroundColor(users[2].name == username ? .yellow : .white)
                        .fontWeight(.medium)
                        .lineLimit(1)
                    Text(users[2].filiere)
                        .font(sample ? .caption2 : .caption)
                        .foregroundColor(users[2].name == username ? .yellow.opacity(0.8) : .white.opacity(0.8))
                        .fontWeight(.medium)
                        .opacity(general ? 1 : 0)
                        .animation(.easeIn)
                }
                .frame(width: sample ? UIScreen.main.bounds.width/6 : UIScreen.main.bounds.width/4)
            }
        }
        .frame(width: sample ? UIScreen.main.bounds.width*0.65 : UIScreen.main.bounds.width)
    }
}
