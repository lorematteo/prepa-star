//
//  ShoppingView.swift
//  Quizz
//
//  Created by matteo on 25/07/2021.
//

import SwiftUI

struct ShopView: View {
    
    @AppStorage("refreshshop") var refreshshopdate: String = ""
    
    @AppStorage("shopset1") var shopset1: String = ""
    @AppStorage("shopset2") var shopset2: String = ""
    @AppStorage("shopset3") var shopset3: String = ""
    
    @AppStorage("shoppalette1") var shoppalette1: String = ""
    @AppStorage("shoppalette2") var shoppalette2: String = ""
    @AppStorage("shoppalette3") var shoppalette3: String = ""
    
    
    @Binding var showview: String
    @Binding var reward: AvatarColor
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    @State var avatarsets: [String]
    @State var colorsets: [String]
    @State var usermoney: Int = 0
    
    @State var timeRemaining: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(showview: Binding<String>, reward: Binding<AvatarColor>){
        self._showview = showview
        self._reward = reward
        self.avatarsets = ["Héroique", "Animal", "Fantastique"]
        self.colorsets = ["Pêche", "Ambiance", "Fraise"]
    }
    var body: some View {
        
        ZStack{
            VStack {
                
                HStack {
                    
                    Text("Shop")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    
                    Spacer()
                    
                    MoneyIndicator(total: $usermoney, tiny: true)

                    Button(action: {withAnimation(.spring()){self.showview = "settings"}}, label: {
                            Image("Paramètres")
                                .renderingMode(.template)
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                    })
                    
                    
                }
                .padding()
                
                ScrollView(showsIndicators: false){
                    
                    LazyVGrid(
                        columns: columns,
                        alignment: .center,
                        spacing: 16,
                        pinnedViews: [.sectionHeaders]
                    ){
                        Section(
                            header:
                                HStack(alignment: .bottom){
                                    Text("Sets d'avatars")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .frame(height: 1)
                                }
                            , footer:
                                wheelcard(usermoney: $usermoney, showwheel: $showview)
                                .shadow(color: Color("yellow").opacity(0.7), radius: 15, x: 0, y: 0)
                        ){
                            ForEach(avatarsets.indices, id: \.self){ index in
                                if avatarsets[index] != "Set de Base" && avatarsets[index] != "Lucky Wheel"{
                                    setcard(usermoney: $usermoney, set: avatarsets[index], type: "avatar", showreward: $showview, reward: $reward)
                                }
                            }
                            
                        }
                        
                        Section(header:
                            HStack(alignment: .bottom){
                                Text("Palettes de couleurs")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(height: 1)
                            }
                        ){
                            ForEach(colorsets.indices, id: \.self){ index in
                                if colorsets[index] != "Lucky Wheel" && colorsets[index] != "Palette de Base"{
                                    setcard(usermoney: $usermoney, set: colorsets[index], type: "color", showreward: $showview, reward: $reward)
                                }
                            }
                            
                        }
                    }
                    .padding(.bottom, 75)
                    .padding()
                }
                .padding(.top, 1)
                .overlay(
                    Text("Actualisation dans : \(timeString(time: timeRemaining))")
                        .font(.caption)
                        .fontWeight(.thin)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.trailing)
                        .padding()
                        .offset(y: -35)
                        .onReceive(timer){ _ in
                            if self.timeRemaining > 0{
                                self.timeRemaining -= 1
                            } else{
                                self.timer.upstream.connect().cancel()
                            }
                        }
                    ,alignment: .topTrailing
                )
                
                
            }
            .background(Color("purple1").ignoresSafeArea(.all, edges: .all))
            .onAppear(perform: {
                updateSets()
                let userInfos = DB_Manager().getUserInfos()
                self.usermoney = Int(userInfos.money)
                self.timeRemaining = getTimeRemaining()
            })
        }
    }
    
    func getTimeRemaining() -> Int{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let midnight = formatter.date(from: "23:00")
        
        let diff = Calendar.current.dateComponents([.hour, .minute], from: Date(), to: midnight!)
        let date = Calendar.current.date(from: diff)
        let result = Calendar.current.component(.minute, from: date!) * 60 + Calendar.current.component(.hour, from: date!) * 3600
        return result
    }
    
    func timeString(time: Int) -> String{
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        return String(format:"%02ih%02i", hours, minutes)
    }
    
    func updateSets(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let now = formatter.string(from: Date()) // Today's Date
        
        if now != refreshshopdate{
            let sets = DB_Manager().getSets(typeValue: "avatar").shuffled()
            shopset1 = sets[0]
            shopset2 = sets[1]
            shopset3 = sets[2]
            
            let palettes = DB_Manager().getSets(typeValue: "color").shuffled()
            shoppalette1 = palettes[0]
            shoppalette2 = palettes[1]
            shoppalette3 = palettes[2]
            
            refreshshopdate = now
        }
        
        avatarsets = [shopset1, shopset2, shopset3]
        colorsets = [shoppalette1, shoppalette2, shoppalette3]
    }
}

//MARK: SetCard
struct setcard: View{
    
    @Binding var usermoney: Int
    var set: String
    var type: String
    @Binding var showreward: String
    @Binding var reward: AvatarColor
    
    @State var setelements: [AvatarColor] = []
    
    var body: some View{
        
        var element = getFirstNonUnlocked(set: DB_Manager().getAvatarsOrColor(typeValue: type, setValue: set))
        
        VStack{
            
            Text(set)
                .font(.caption)
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(element.set == "completedset" ? .white : .gray)
            
            Spacer()
            
            if type == "avatar"{
                Image(element.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(
                        ZStack{
                            Circle()
                                .fill(element.set == "completedset" ? Color("green").opacity(0.7) : Color("orange").opacity(0.7))
                                .frame(width: 15, height: 15)
                            
                            Text("\(String(element.name.last != nil ? String(element.name.last!) : ""))/9")
                                .foregroundColor(.white)
                                .font(.system(size: 7))
                        }
                        ,alignment: .bottomTrailing
                    )
            } else{
                Image("splash")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color(element.name))
                    .aspectRatio(contentMode: .fit)
                    .overlay(
                        Image("splashcover")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(0.7)
                    )
                    .overlay(
                        ZStack{
                            Circle()
                                .fill(element.set == "completedset" ? Color("green").opacity(0.7) : Color("orange").opacity(0.7))
                                .frame(width: 15, height: 15)
                            
                            Text("\(String(element.name.last != nil ? String(element.name.last!) : ""))/9")
                                .foregroundColor(.white)
                                .font(.system(size: 7))
                        }
                        ,alignment: .bottomTrailing
                    )
            }
            
            Spacer()
            
            Button(action: {
                withAnimation(.easeInOut){
                    DB_Manager().unlockAvatarOrColor(typeValue: element.type, nameValue: element.name)
                    DB_Manager().MoneyIncrement(nbr: -element.price)
                    usermoney -= Int(element.price)
                    reward = element
                    showreward = "reward"
                    setelements = DB_Manager().getAvatarsOrColor(typeValue: type, setValue: set)
                    element = getFirstNonUnlocked(set: setelements)
                }
            }, label: {
                
                if element.set == "completedset"{
                    HStack(spacing: 5){
                        Image("tick")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .font(.caption)
                            .aspectRatio(contentMode: .fit)
                    }
                    .padding(5)
                    .frame(width: 75, height: 25)
                    .background(Color("green"))
                    .cornerRadius(45)
                    .shadow(color: Color(.white).opacity(0.3), radius: 1, x: 0.0, y: 5)
                } else {
                    HStack(spacing: 5){
                        Text(String(element.price))
                            .font(.caption)
                            .foregroundColor(.white)
                        Image("coin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .padding(5)
                    .frame(width: 75, height: 25)
                    .background(Color("lightgreen"))
                    .cornerRadius(45)
                    .shadow(color: Color("green"), radius: 1, x: 0.0, y: 5)
                }
            })
            .opacity(element.set == "completedset" ? 1 : usermoney < element.price ? 0.7 : 1)
            .disabled(element.set == "completedset" ? true : usermoney < element.price)
        }
        .padding(10)
        .frame(width: 100, height: 150)
        .background(
            element.set == "completedset" ? RadialGradient(gradient: Gradient(colors: [Color("orange")]), center: .center, startRadius: 5, endRadius: 500) :
                RadialGradient(gradient: Gradient(colors: element.rarity == "common" ? [Color("lightgrey")] :
                                                    element.rarity == "rare" ? [Color("rarityrare"), Color("lightgrey")] :
                                                    element.rarity == "epic" ? [Color("rarityepic"), Color("lightgrey")] :
                                                    [Color("raritylegendary"), Color("lightgrey")]), center: .center, startRadius: 0, endRadius: 50)
        )
        .cornerRadius(25)
        .if(element.rarity == "legendary"){ view in
            view.multicolorGlow()
        }
        .frame(width: 110, height: 160)
    }
    
    func getFirstNonUnlocked(set: [AvatarColor]) -> AvatarColor{
        for el in set{
            if !el.unlocked{
                return el
            }
        }
        return AvatarColor(type: "", name: set.last?.name ?? "", set: "completedset", unlocked: true, rarity: "common", price: 0)
    }
}

//MARK: WheelCard
struct wheelcard: View{
    
    @Binding var usermoney: Int
    @Binding var showwheel: String
    
    @State var commonnum: [Int]
    @State var rarenum: [Int]
    @State var epicnum: [Int]
    @State var legendarynum: [Int]
    @State var featuredlist: [AvatarColor]
    
    @State var bought: Bool = false
    
    
    init(usermoney: Binding<Int>, showwheel: Binding<String>){
        self._usermoney = usermoney
        self._showwheel = showwheel
        self.commonnum = DB_Manager().getUnlockedNums(rarityValue: "common")
        self.rarenum = DB_Manager().getUnlockedNums(rarityValue: "rare")
        self.epicnum = DB_Manager().getUnlockedNums(rarityValue: "epic")
        self.legendarynum = DB_Manager().getUnlockedNums(rarityValue: "legendary")
        
        var fea = DB_Manager().getUnlockableItemsByRarity(rarityValue: "legendary")
        if fea.count < 5{
            fea += DB_Manager().getUnlockableItemsByRarity(rarityValue: "epic")
            if fea.count < 5{
                fea += DB_Manager().getUnlockableItemsByRarity(rarityValue: "rare")
                if fea.count < 5{
                    fea += DB_Manager().getUnlockableItemsByRarity(rarityValue: "common")
                }
            }
        }
        while fea.count > 5{
            fea.remove(at: Int.random(in: 0..<fea.count-1))
        }
        self.featuredlist = fea
    }
    
    var body: some View{
        HStack{
            ZStack{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(featuredlist.indices, id: \.self){ i in
                            Image(featuredlist[i].name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .fill(RadialGradient(gradient: Gradient(colors: featuredlist[i].rarity == "common" ? [Color("lightgrey")] : featuredlist[i].rarity == "rare" ? [Color("rarityrare"), Color("lightgrey")] : featuredlist[i].rarity == "epic" ? [Color("rarityepic"), Color("lightgrey")] : [Color("raritylegendary"), Color("lightgrey")]), center: .center, startRadius: 0, endRadius: 35))
                                        .overlay(LottieView(filename: "rotatinglight").frame(width: 85, height: 85).opacity(featuredlist[i].rarity == "legendary" ? 1 : 0))
                                )
                                .frame(width: 75, height: 75)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .stroke(Color("raritylegendary"), lineWidth: featuredlist[i].rarity == "legendary" ? 3: 0)
                                )
                        }
                    }
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 0.0, y: 0.0)
                    .padding()
                    .padding(.trailing, 150)
                }
                .background(Color("purple1"))
                .overlay(
                    VStack(spacing: 0){
                        Rectangle()
                            .fill(Color("purple2"))
                            .frame(height: 3)
                        Triangle()
                            .foregroundColor(Color("purple2"))
                            .frame(width: 7, height: 7)
                            .rotationEffect(Angle(degrees: 180))
                            .offset(x: -118)
                        
                        Spacer(minLength: 0)
                        
                        Triangle()
                            .foregroundColor(Color("purple2"))
                            .frame(width: 7, height: 7)
                            .offset(x: -118)
                        Rectangle()
                            .fill(Color("purple2"))
                            .frame(height: 3)
                    }
                )
                
                HStack{
                    Spacer()
                    VStack(alignment: .leading){
                        Text("Tente d'obtenir un objet \(Text("légendaire").foregroundColor(Color("raritylegendary")).fontWeight(.semibold)) !")
                            .font(.caption2)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        HStack{
                            VStack(alignment: .leading){
                                Text("commun : \(commonnum[0])/\(commonnum[1])")
                                    .font(.system(size: 10))
                                    .foregroundColor(Color.gray)
                                Text("rare : \(rarenum[0])/\(rarenum[1])")
                                    .font(.system(size: 10))
                                    .foregroundColor(Color("rarityrare"))
                                Text("épique : \(epicnum[0])/\(epicnum[1])")
                                    .font(.system(size: 10))
                                    .foregroundColor(Color("rarityepic"))
                                Text("légendaire : \(legendarynum[0])/\(legendarynum[1])")
                                    .font(.system(size: 10))
                                    .foregroundColor(Color("raritylegendary"))
                            }
                            Spacer()
                        }
                        Spacer()
                        HStack{
                            
                            Spacer()
                            
                            Button(action:{
                                DB_Manager().MoneyIncrement(nbr: -100)
                                usermoney -= Int(100)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                    withAnimation{showwheel = "wheel"}
                                    bought = true
                                }
                            }, label: {
                                
                                if commonnum[0] == commonnum[1] && rarenum[0] == rarenum[1] && epicnum[0] == epicnum[1] && legendarynum[0] == legendarynum[1]{
                                    HStack(spacing: 5){
                                        Image("tick")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(.white)
                                            .font(.caption)
                                            .aspectRatio(contentMode: .fit)
                                    }
                                    .padding(5)
                                    .frame(width: 75, height: 25)
                                    .background(Color("green"))
                                    .cornerRadius(45)
                                    .shadow(color: Color("lightgreen").opacity(0.3), radius: 1, x: 0.0, y: 5)
                                } else {
                                    HStack(spacing: 5){
                                        Text(String(100))
                                            .font(.caption)
                                            .foregroundColor(.white)
                                        Image("coin")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }
                                    .padding(5)
                                    .frame(width: 75, height: 25)
                                    .background(Color("lightgreen"))
                                    .cornerRadius(45)
                                    .shadow(color: Color("green"), radius: 1, x: 0.0, y: 5)
                                }
                            })
                            .opacity(commonnum[0] == commonnum[1] && rarenum[0] == rarenum[1] && epicnum[0] == epicnum[1] && legendarynum[0] == legendarynum[1] ? 1 : usermoney < 100 ? 0.7 : 1)
                            .disabled(commonnum[0] == commonnum[1] && rarenum[0] == rarenum[1] && epicnum[0] == epicnum[1] && legendarynum[0] == legendarynum[1] ? true : usermoney < 100)
                        }
                        
                    }
                    .padding(14)
                    .frame(width: 140)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("lightgrey"))
                            .shadow(color: Color("purple1").opacity(0.7), radius: 10, x: -5, y: 0.0)
                    )
                }
            }
        }
        .frame(width: 340, height: 150)
        .background(Color("purple3"))
        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color("yellow"), lineWidth: 7).shadow(color: .white.opacity(0.5), radius: 10, x: 0.0, y: 0.0))
        .cornerRadius(25)
        .overlay(
            VStack{
                Spacer()
                
                Text("De nouveaux avatars arrivent bientôt.")
                    .foregroundColor(.white)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .opacity(0.6)
            }
            .frame(width: 175)
            .padding()
            .opacity(commonnum[0] == commonnum[1] && rarenum[0] == rarenum[1] && epicnum[0] == epicnum[1] && legendarynum[0] == legendarynum[1] ? 1 : 0)
            , alignment: .leading
        )
        .onAppear(perform: {
            if bought{
                self.commonnum = DB_Manager().getUnlockedNums(rarityValue: "common")
                self.rarenum = DB_Manager().getUnlockedNums(rarityValue: "rare")
                self.epicnum = DB_Manager().getUnlockedNums(rarityValue: "epic")
                self.legendarynum = DB_Manager().getUnlockedNums(rarityValue: "legendary")
            }
        })
    }
}



//struct ShopView_Previews: PreviewProvider {
//    static var previews: some View {
//        wheelcard(usermoney: Binding.constant(200))
//    }
//}
