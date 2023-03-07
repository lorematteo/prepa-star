//
//  badgestabview.swift
//  Quizz
//
//  Created by matteo on 15/07/2021.
//

import SwiftUI

struct badgestabview: View {
    
    @Binding var selectedtab: Int
    @State var menu: [String]
    
    @State var badgesModels: [Badge] = []
    @State var refreshed = false
    
    var body: some View {
        
        
        ForEach(menu.indices, id:\.self){ index in
            
            if index == selectedtab{
                VStack{
                    let badges = DB_Manager().getBadgesFil(selfil: menu[index])
                    let nbrbadges = badges.count
                    
                    if nbrbadges == 0{
                        HStack{
                            Spacer()
                            VStack{
                                Spacer()
                                Text("Prochainement...")
                                    .font(Font.headline.weight(.heavy))
                                    .foregroundColor(Color("black").opacity(0.6))
                                    .padding(.vertical, 5)
                                Text("Tu peut toujours t'amuser à débloquer les badges généraux !")
                                    .font(Font.subheadline.weight(.semibold))
                                    .foregroundColor(Color("black").opacity(0.5))
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width*0.6)
                            Spacer()
                        }
                    }
                    else {
                        VStack(spacing: 15){
                            ForEach(0...Int(ceil(Double(nbrbadges)/4) - 1), id:\.self){ ligne in
                                HStack(spacing: 10){
                                    ForEach(1...4, id:\.self){ index in
                                        
                                        if index+ligne*4 <= nbrbadges{
                                            if refreshed {
                                                badgeview(badges: badges, index: index+ligne*4-1, refreshed: $refreshed)
                                                    .clipShape(Circle())
                                                    .clipped()
                                                    .overlay(
                                                        ZStack {
                                                            Circle()
                                                                .fill(Color("green"))
                                                                .frame(width: 20, height: 20)
                                                                .overlay(Circle().stroke(Color.white, lineWidth: 1).shadow(radius: 10))
                                                                .overlay(
                                                                    Image("tick")
                                                                        .resizable()
                                                                        .renderingMode(.template)
                                                                        .foregroundColor(.white)
                                                                        .frame(width: 10, height: 13))
                                                                .opacity(badges[index+ligne*4-1].claimed ? 1 : 0)
                                                            
                                                            Circle()
                                                                .fill(Color("orange"))
                                                                .frame(width: 15, height: 15)
                                                                .opacity(badges[index+ligne*4-1].unlocked ? badges[index+ligne*4-1].claimed ? 0 : 1 : 0)
                                                            
                                                        }
                                                        
                                                        , alignment: badges[index+ligne*4-1].unlocked ? badges[index+ligne*4-1].claimed ? .bottomTrailing : .topTrailing : .center)
                                            }
                                            else {
                                                badgeview(badges: badges, index: index+ligne*4-1, refreshed: $refreshed)
                                                    .clipShape(Circle())
                                                    .clipped()
                                                    .overlay(
                                                        ZStack {
                                                            Circle()
                                                                .fill(Color("green"))
                                                                .frame(width: 20, height: 20)
                                                                .overlay(Circle().stroke(Color.white, lineWidth: 1).shadow(radius: 10))
                                                                .overlay(
                                                                    Image("tick")
                                                                        .resizable()
                                                                        .renderingMode(.template)
                                                                        .foregroundColor(.white)
                                                                        .frame(width: 10, height: 13))
                                                                .opacity(badges[index+ligne*4-1].claimed ? 1 : 0)
                                                            
                                                            Circle()
                                                                .fill(Color("orange"))
                                                                .frame(width: 15, height: 15)
                                                                .opacity(badges[index+ligne*4-1].unlocked ? badges[index+ligne*4-1].claimed ? 0 : 1 : 0)
                                                            
                                                        }
                                                        
                                                        , alignment: badges[index+ligne*4-1].unlocked ? badges[index+ligne*4-1].claimed ? .bottomTrailing : .topTrailing : .center)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .onAppear(perform: {
                    self.badgesModels = DB_Manager().getBadgesFil(selfil: menu[index])
                })
            }
        }
    }
}

struct badgestabview_Previews: PreviewProvider {
    static var previews: some View {
        badgestabview(selectedtab: Binding.constant(0), menu: ["Général"])
    }
}
