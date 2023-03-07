//
//  RewardWheel.swift
//  Quizz
//
//  Created by matteo on 26/07/2021.
//

import SwiftUI
import Lottie

struct LuckyWheel: View {
    
    @Binding var show: String
    
    var randomitems: [AvatarColor]
    
    @State var offset: CGFloat = 2126/2 + 2.5 - 264
    @State var lighted : Bool = false
    @State var spinned: Bool = false
    @State var finishspinned: Bool = false
    @State var result: [AvatarColor] = []
    
    init(show: Binding<String>){
        
        func getRandomItems() -> [AvatarColor]{
            let legendary = DB_Manager().getUnlockableItemsByRarity(rarityValue: "legendary")
            let epic = DB_Manager().getUnlockableItemsByRarity(rarityValue: "epic")
            let rare = DB_Manager().getUnlockableItemsByRarity(rarityValue: "rare")
            let common = DB_Manager().getUnlockableItemsByRarity(rarityValue: "common")
            
            var randomitems: [AvatarColor] = []
            while randomitems.count < 10{
                let randint = Int.random(in: 1...100)
                if randint > 0 && randint < 6{
                    if legendary.count > 0{
                        randomitems.append(legendary.randomElement()!)
                    }
                }
                if randint > 5 && randint < 21{
                    if epic.count > 0{
                        randomitems.append(epic.randomElement()!)
                    }
                }
                if randint > 20 && randint < 51{
                    if rare.count > 0{
                        randomitems.append(rare.randomElement()!)
                    }
                }
                else {
                    if common.count > 0{
                        randomitems.append(common.randomElement()!)
                    }
                }
            }
            return randomitems
        }
        
        self._show = show
        self.randomitems = getRandomItems()
    }
    
    var body: some View {
        ZStack{
            HStack(spacing: 7){
                ForEach(1...2, id: \.self){ repeatition in
                    ForEach(0...9, id: \.self){ index in
                        let item = randomitems[index]
                        if repeatition == 2 && index == 7{
                            wheelslot(index: index, element: item)
                                .padding(.vertical)
                                .padding(.vertical)
                                .onAppear(perform: {
                                    DB_Manager().unlockAvatarOrColor(typeValue: item.type, nameValue: item.name)
                                })
                        } else {
                            wheelslot(index: index, element: item)
                                .padding(.vertical)
                                .padding(.vertical)
                        }
                    }
                }
            }
            .offset(x: offset)
            .background(Color("purple1").shadow(color: Color("yellow"), radius: 40, x: 0.0, y: 0.0))
            .border(Color("purple2"), width: 10)
            .frame(width: UIScreen.main.bounds.width)
            .overlay(
                ZStack{
                    VStack{
                        Triangle()
                            .foregroundColor(Color("purple2"))
                            .frame(width: 10, height: 10)
                            .rotationEffect(Angle(degrees: 180))
                        
                        Spacer()
                        
                        Triangle()
                            .foregroundColor(Color("purple2"))
                            .frame(width: 10, height: 10)
                    }
                    .padding(10)
                    
                    VStack{
                        HStack{
                            ForEach(1..<7){ i in
                                Spacer()
                                Circle()
                                    .fill(i % 2  != 0 ? lighted ? Color("yellow") : Color("white") : !lighted ? Color("yellow") : Color("white"))
                                    .frame(width: 14, height: 14)
                                if i==6{
                                    Spacer()
                                }
                                
                            }
                        }
                        .offset(y: -5)
                        
                        Spacer()
                        
                        HStack{
                            ForEach(1..<7){ i in
                                Spacer()
                                Circle()
                                    .fill(i % 2  == 0 ? lighted ? Color("yellow") : Color("white") : !lighted ? Color("yellow") : Color("white"))
                                    .frame(width: 14, height: 14)
                                if i==6{
                                    Spacer()
                                }
                                
                            }
                        }
                        .offset(y: 5)
                    }
                }
            )
            .onAppear(perform: {
                withAnimation(.spring().repeatForever(autoreverses: true)){
                    lighted.toggle()
                }
            })
            
            
            Button(action: {
                if !spinned {
                    withAnimation(.timingCurve(0, 0.6, 0.2, 1, duration: 7)){
                        offset = -offset
                    }
                    spinned = true
                    DispatchQueue.main.asyncAfter(deadline: .now()+6.5){
                        finishspinned = true
                    }
                }
                if spinned && finishspinned {
                    withAnimation{show = ""}
                }
            }, label: {
                if !spinned{
                    ZStack{
                        LottieView(filename: "custombutton")
                            .frame(width: 200, height: 100)
                        
                        Text("LANCER")
                            .foregroundColor(Color("white"))
                            .font(.headline)
                    }
                } else {
                    Text(finishspinned ? "Réclamer" : "...")
                        .foregroundColor(Color("white"))
                        .font(.headline)
                        .padding(10)
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 25).foregroundColor(Color("orange")))
                        .animation(.easeInOut)
                }
            })
            .offset(y: 175)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color("purple3").ignoresSafeArea().opacity(0.7))
    }
}

struct wheelslot: View{
    
    var index: Int
    var element: AvatarColor
    
    var tiny: Bool = false
    
    var body: some View{
        
        
        Image(element.name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(RadialGradient(gradient: Gradient(colors: element.rarity == "common" ? [Color("lightgrey")] : element.rarity == "rare" ? [Color("rarityrare"), Color("lightgrey")] : element.rarity == "epic" ? [Color("rarityepic"), Color("lightgrey")] : [Color("raritylegendary"), Color("lightgrey")]), center: .center, startRadius: 0, endRadius: 45))
                    .overlay(LottieView(filename: "rotatinglight").frame(width: 115, height: 115).opacity(element.rarity == "legendary" ? 1 : 0))
            )
            .frame(width: 100, height: 100)
            .overlay(
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(Color("raritylegendary"), lineWidth: 5)
                    .opacity(element.rarity == "legendary" ? 1 : 0)
            )

    }
}
