//
//  RewardView.swift
//  Quizz
//
//  Created by matteo on 25/07/2021.
//

import SwiftUI
import Lottie

struct RewardView: View {
    
    @Binding var show: String
    
    var reward: AvatarColor
    
    @State var rotationanim: Double = 0
    @State var offsetanim: CGFloat = 1
    
    var body: some View {
        ZStack{
            
            ZStack{
                ForEach(1...6, id: \.self){ index in
                    Triangle()
                        .fill(Color("yellow"))
                        .frame(width: UIScreen.main.bounds.width*0.1, height: UIScreen.main.bounds.width*0.6)
                        .offset(y: UIScreen.main.bounds.width*0.2)
                        .rotationEffect(Angle(degrees: 60*Double(index)))
                }
                ForEach(1...6, id: \.self){ index in
                    Triangle()
                        .fill(Color("orange2"))
                        .frame(width: UIScreen.main.bounds.width*0.08, height: UIScreen.main.bounds.width*0.2)
                        .offset(y: UIScreen.main.bounds.width*0.3*offsetanim)
                        .rotationEffect(Angle(degrees: 60*Double(index)))
                        .rotationEffect(Angle(degrees: 30))
                }
            }
            .rotationEffect(Angle(degrees: rotationanim))
            
            if reward.type == "avatar"{
                Circle()
                    .fill(reward.rarity == "common" ? Color("lightgrey") : reward.rarity == "rare" ? Color("rarityrare") : reward.rarity == "epic" ? Color("rarityepic") : Color("raritylegendary"))
                    .frame(width: UIScreen.main.bounds.width*0.35,height: UIScreen.main.bounds.width*0.35)
                    .shadow(color: Color("yellow"), radius: 100, x: 0.0, y: 0.0)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3).shadow(color: .black, radius: 10, x: 0.0, y: 0.0))
                    .overlay(
                        Image(reward.name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    )
            }
            if reward.type == "color" {
                Circle()
                    .fill(reward.rarity == "common" ? Color("lightgrey") : reward.rarity == "rare" ? Color("rarityrare") : reward.rarity == "epic" ? Color("rarityepic") : Color("raritylegendary"))
                    .frame(width: UIScreen.main.bounds.width*0.35,height: UIScreen.main.bounds.width*0.35)
                    .shadow(color: Color("yellow"), radius: 100, x: 0.0, y: 0.0)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3).shadow(color: .black, radius: 10, x: 0.0, y: 0.0))
                    .overlay(
                        Image("splash")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color(reward.name))
                            .aspectRatio(contentMode: .fit)
                            .overlay(
                                Image("splashcover")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            )
                            .padding()
                    )
            }
            
            LottieView(filename: "conffeti")
                .frame(width: UIScreen.main.bounds.width, height: 500)
            
            VStack{
                Spacer()
                
                VStack{
                    Text("Bravo ! ")
                        .foregroundColor(Color("brown"))
                        .font(.headline)
                    Text("Tu viens de débloquer \(reward.type == "avatar" ? "un nouvel avatar." : "une nouvelle couleur")")
                        .foregroundColor(Color("brown"))
                        .font(.subheadline)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 25).foregroundColor(Color("lightgrey")))
                .overlay(RoundedRectangle(cornerRadius:25).stroke(Color.white, lineWidth: 3).shadow(color: .black, radius: 10, x: 0.0, y: 0.0))
                
                Spacer()
                Spacer()
                Spacer()
                
                Button(action: {withAnimation{show = ""}}, label: {
                    Text("Réclamer")
                        .foregroundColor(Color("white"))
                        .font(.headline)
                })
                .padding()
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 25).foregroundColor(Color("orange")).shadow(color: .black.opacity(0.8), radius: 10, x: 0.0, y: 0.0))
                
                Spacer()
            }
            
            
        }
        .onAppear(perform: {
            withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)){
                rotationanim = 360
            }
            withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)){
                offsetanim = 0.8
            }
        })
        .background(Color.clear.ignoresSafeArea())
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

