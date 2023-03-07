//
//  CustomProfilView.swift
//  
//
//  Created by matteo on 24/07/2021.
//

import SwiftUI

struct CustomProfilView: View {
    
    @AppStorage("userid") var userid: String = ""
    @AppStorage("useravatar") var useravatar : String = "baseset1"
    @AppStorage("usercolor") var usercolor : String = "basepalette1"
    
    @Binding var show: String
    
    @State var sets: [String]
    @State var palettes: [String]
    
    @State var selectedmenu: String = "avatar"
    
    @State var selectedavatar: String = ""
    @State var selectedcolor: String = ""
    
    @State var editing: Bool = false
    
    
    @State var showerror: Bool = false
    
    @State var selectedtabavatar: Int = 0
    @State var selectedtabcolor: Int = 0
    
    @State var appeared: Bool = false
    
    
    init(show: Binding<String>){
        self._show = show
        self.sets = DB_Manager().getSets(typeValue: "avatar")
        self.palettes = DB_Manager().getSets(typeValue: "color")
    }
    
    var body: some View {
        ZStack{
            VStack{
                
                HStack{
                    Button(action: {withAnimation(.easeInOut){show = ""}}, label: {
                        Image("thinarrowleft")
                            .renderingMode(.template)
                            .foregroundColor(Color(.gray))
                    })
                    .padding(.leading)
                    
                    Spacer()
                    Button(action: {
                        if selectedavatar != "" || selectedcolor != ""{
                            if selectedavatar != useravatar || selectedcolor != usercolor{
                                Leaderboard().updateUserProfil(userID: userid, newicon: selectedavatar == "" ? useravatar : selectedavatar, newcolor: selectedcolor == "" ? usercolor : selectedcolor) { done in
                                    if done {
                                        useravatar = (selectedavatar == "" ? useravatar : selectedavatar)
                                        usercolor = (selectedcolor == "" ? usercolor : selectedcolor)
                                        withAnimation(.spring()){show = ""}
                                    } else {
                                        showerror = true
                                    }
                                }
                            } else {
                                withAnimation(.spring()){show = ""}
                            }
                        } else {
                            withAnimation(.spring()){show = ""}
                        }
                    }, label: {
                        Text("Sauvegarder")
                            .foregroundColor(Color(.gray))
                    })
                }
                .padding()
                
                Circle()
                    .fill(selectedcolor == "" ? Color(usercolor) : Color(selectedcolor))
                    .frame(width: UIScreen.main.bounds.width*0.4, height: UIScreen.main.bounds.width*0.4)
                    .overlay(
                        Image(selectedavatar == "" ? useravatar : selectedavatar)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, UIScreen.main.bounds.width*0.4*0.1)
                            .clipShape(Circle())
                        ,alignment: .center
                    )
                    .overlay(Circle().stroke(Color(.white), lineWidth: 5).shadow(radius: 10))
                    .offset(y: appeared ? 10 : 0)
                    .animation(.spring())
                
                menuanimated(selectedmenu: $selectedmenu)
                .padding(.top)
                
                if selectedmenu == "avatar"{
                    TabView(selection: $selectedtabavatar){
                        displayset(elements: DB_Manager().getAvatarsOrColor(typeValue: "avatar", setValue: "Base"), selectedavatar: $selectedavatar, selectedcolor: $selectedcolor)
                            .tag(-1)
                        ForEach(sets.indices, id:\.self){ index in
                            displayset(elements: DB_Manager().getAvatarsOrColor(typeValue: "avatar", setValue: sets[index]), selectedavatar: $selectedavatar, selectedcolor: $selectedcolor)
                                .tag(index)
                        }
                        displayaleatoire(elements: DB_Manager().getAvatarsOrColor(typeValue: "avatar", setValue: "Aléatoire"), selectedavatar: $selectedavatar, selectedcolor: $selectedcolor)
                            .tag(sets.count)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .overlay(
                        HStack(spacing: 5){
                            ForEach(1...(sets.count+2), id:\.self){ index in
                                Circle()
                                    .foregroundColor(selectedtabavatar == index-2 ? Color("purple1") : Color.gray.opacity(0.6))
                                    .frame(width: 7, height: 7)
                            }
                        }
                        .padding()
                        ,alignment: .bottom
                    )
                } else {
                    TabView(selection: $selectedtabcolor){
                        displayset(elements: DB_Manager().getAvatarsOrColor(typeValue: "color", setValue: "Base"), selectedavatar: $selectedavatar, selectedcolor: $selectedcolor)
                            .tag(-1)
                        ForEach(palettes.indices, id:\.self){ index in
                            displayset(elements: DB_Manager().getAvatarsOrColor(typeValue: "color", setValue: palettes[index]), selectedavatar: $selectedavatar, selectedcolor: $selectedcolor)
                                .tag(index)
                        }
                        displayaleatoire(elements: DB_Manager().getAvatarsOrColor(typeValue: "color", setValue: "Aléatoire"), selectedavatar: $selectedavatar, selectedcolor: $selectedcolor)
                            .tag(sets.count)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .overlay(
                        HStack(spacing: 5){
                            ForEach(1...(sets.count+2), id:\.self){ index in
                                Circle()
                                    .foregroundColor(selectedtabcolor == index-2 ? Color("purple1") : Color.gray.opacity(0.6))
                                    .frame(width: 7, height: 7)
                            }
                        }
                        .padding()
                        ,alignment: .bottom
                    )
                }
                
            }
            .frame(width: UIScreen.main.bounds.width*0.85, height: UIScreen.main.bounds.height*0.85)
            .background(Color("lightgrey"))
            .cornerRadius(25)
            .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color("whitebutton"), lineWidth: 5))
            .shadow(color: .black.opacity(0.5), radius: 10, x: 0.0, y: 0.0)
            .alert(isPresented: $showerror, content: {
                Alert(title: Text("Erreur !"), message: Text("Merci de réessayer plus tard, si le problème persite contacte moi :)"), dismissButton: .cancel(Text("Ok")))
            })
            .onAppear {
                selectedavatar = useravatar
                selectedcolor = usercolor
                self.appeared = true
            }
            .onDisappear(perform: {
                self.appeared = false
            })
        }
    }
}


struct menuanimated: View{
    
    @Binding var selectedmenu: String
    
    var body: some View{
        
        HStack(alignment: .center, spacing: 0){
            Button(action: {selectedmenu = "avatar"}, label: {
                Text("AVATARS")
                    .font(.subheadline)
                    .fontWeight(selectedmenu == "avatar" ? .semibold : .none)
                    .foregroundColor(selectedmenu == "avatar" ? Color("black") : Color(.white))
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                    .padding(.leading, 5)
                    .animation(.easeIn)
            })
            Spacer()
            Button(action: {selectedmenu = "couleur"}, label: {
                    Text("COULEURS")
                        .font(.subheadline)
                        .fontWeight(selectedmenu == "couleur" ? .semibold : .none)
                        .foregroundColor(selectedmenu == "couleur" ? Color("black") : Color(.white))
                        .padding(.vertical, 12)
                        .padding(.horizontal, 12)
                        .padding(.trailing, 5)
                        .animation(.easeIn)
            })
        }
        .frame(width: UIScreen.main.bounds.width*0.6)
        .background(
            Color(.gray).opacity(0.7)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("whitebutton"))
                        .frame(width: selectedmenu == "avatar" ? 85 : 100, height: 35)
                        .padding(5)
                    ,alignment: selectedmenu == "avatar" ? .leading : .trailing
                )
                .animation(.spring())
        )
        .cornerRadius(25)
    }
}

struct displayset: View{
    
    var elements: [AvatarColor]
    
    @Binding var selectedavatar: String
    @Binding var selectedcolor: String
    
    var twocolumns: [GridItem] = [
        GridItem(.fixed(64), spacing: 5),
        GridItem(.fixed(64), spacing: 5)
    ]
    
    var threecolumns: [GridItem] = [
        GridItem(.fixed(64), spacing: 5),
        GridItem(.fixed(64), spacing: 5),
        GridItem(.fixed(64), spacing: 5)
    ]
    var body: some View{
        
        LazyVGrid(columns: elements[0].set == "Base" || elements[0].set == "Base" ? twocolumns : threecolumns, alignment: .center, spacing: 5){
            
            if elements[0].set == "Base"{
                ForEach(1...4, id: \.self){ count in
                    Button(action: {
                        if elements[0].type == "avatar"{
                            selectedavatar = elements[count-1].name
                        } else {
                            selectedcolor = elements[count-1].name
                        }
                    }, label: {
                        if elements[0].type == "avatar"{
                            Image("\(elements[count-1].name)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            ZStack{
                                Image("splash")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(Color(elements[count-1].name))
                                    .aspectRatio(contentMode: .fit)
                                    .overlay(
                                        Image("splashcover")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    )
                            }
                        }
                    })
                }
            }
            else {
                ForEach(1...9, id: \.self) { count in
                    
                    Button(action: {
                        if elements[0].type == "avatar"{
                            selectedavatar = elements[count-1].name
                        } else {
                            selectedcolor = elements[count-1].name
                        }
                    }, label: {
                        
                        if elements[0].type == "avatar"{
                            ZStack{
                                Image("\(elements[count-1].name)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Image("\(elements[count-1].name)")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.gray)
                                    .frame(width: 64, height: 64)
                                    .opacity(elements[count-1].unlocked ? 0 : 0.6)
                            }
                        } else {
                            ZStack{
                                Image("splash")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(Color(elements[count-1].name))
                                    .aspectRatio(contentMode: .fit)
                                    .overlay(
                                        Image("splashcover")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    )
                                Image("splash")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.gray)
                                    .aspectRatio(contentMode: .fit)
                                    .overlay(
                                        Image("splashcover")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    )
                                    .opacity(elements[count-1].unlocked ? 0 : 0.8)
                            }
                        }
                    })
                    .disabled(!elements[count-1].unlocked)
                }
            }
        }
        .overlay(
            Text(elements[0].set == "Base" ? "Set de Base" : "Set \(elements[0].set)")
                .foregroundColor(.gray.opacity(0.6))
                .font(.callout)
                .offset(y: -35)
            , alignment: .top
        )
    }
}

struct displayaleatoire: View{
    
    var elements: [AvatarColor]
    
    @Binding var selectedavatar: String
    @Binding var selectedcolor: String
    
    let triplerows = [
        GridItem(.fixed(64), spacing: 5),
        GridItem(.fixed(64), spacing: 5),
        GridItem(.fixed(64), spacing: 5)
    ]
    
    @State var common: [AvatarColor]
    @State var rare: [AvatarColor]
    @State var epic: [AvatarColor]
    @State var legendary: [AvatarColor]
    
    
    init(elements: [AvatarColor], selectedavatar: Binding<String>, selectedcolor: Binding<String>){
        self.elements = elements
        self._selectedavatar = selectedavatar
        self._selectedcolor = selectedcolor
        
        let el = elements
        
        self.common = el.filter { $0.rarity.elementsEqual("common")}
        self.rare = el.filter { $0.rarity.elementsEqual("rare")}
        self.epic = el.filter { $0.rarity.elementsEqual("epic")}
        self.legendary = el.filter { $0.rarity.elementsEqual("legendary")}
    }
    
    
    var body: some View{
        
        ScrollView(.horizontal, showsIndicators: false){
            
            HStack{
                
                raritygrid(rarityset: common, selectedavatar: $selectedavatar, selectedcolor: $selectedcolor, rarityname: "Commun", raritycolor: "raritycommon", raritytext: "commontext")
                
                raritygrid(rarityset: rare, selectedavatar: $selectedavatar, selectedcolor: $selectedcolor, rarityname: "Rare", raritycolor: "rarityrare", raritytext: "raretext")
                
                raritygrid(rarityset: epic, selectedavatar: $selectedavatar, selectedcolor: $selectedcolor, rarityname: "Épique", raritycolor: "rarityepic", raritytext: "epictext")
                
                raritygrid(rarityset: legendary, selectedavatar: $selectedavatar, selectedcolor: $selectedcolor, rarityname: "Légendaire", raritycolor: "raritylegendary", raritytext: "legendarytext")
                    
            }
            .padding(.horizontal, UIScreen.main.bounds.width*0.15)
        }
    }
}

struct raritygrid: View{
    
    @State var rarityset: [AvatarColor]
    
    @Binding var selectedavatar: String
    @Binding var selectedcolor: String
    
    var rarityname: String
    var raritycolor: String
    var raritytext: String
    
    let triplerows = [
        GridItem(.fixed(64), spacing: 5),
        GridItem(.fixed(64), spacing: 5),
        GridItem(.fixed(64), spacing: 5)
    ]
    
    var body: some View{
        
        HStack(spacing: 15){
            ZStack(alignment: .bottomTrailing){
                Color(raritycolor)
                    .frame(width: 50)
                
                Image(raritytext)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom)
                    .frame(width: raritytext == "commontext" ? 25 : raritytext == "raretext" ? 25 : raritytext == "legendarytext" ? 27 : 30)
                    .offset(x: raritytext == "epictext" ? 3 : 0)
            }
            .padding(.leading)
            
            LazyHGrid(rows: triplerows, alignment: .center){
                
                ForEach(rarityset.indices, id:\.self){ index in
                    
                    Button(action: {
                        if rarityset[0].type == "avatar"{
                            selectedavatar = rarityset[index].name
                        } else {
                            selectedcolor = rarityset[index].name
                        }
                    }, label: {
                        
                        if rarityset[0].type == "avatar"{
                            ZStack{
                                Image("\(rarityset[index].name)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Image("\(rarityset[index].name)")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.gray)
                                    .frame(width: 64, height: 64)
                                    .opacity(rarityset[index].unlocked ? 0 : 0.6)
                            }
                        } else {
                            ZStack{
                                Image("splash")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(Color(rarityset[index].name))
                                    .aspectRatio(contentMode: .fit)
                                    .overlay(
                                        Image("splashcover")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    )
                                Image("splash")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.gray)
                                    .aspectRatio(contentMode: .fit)
                                    .overlay(
                                        Image("splashcover")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    )
                                    .opacity(rarityset[index].unlocked ? 0 : 0.8)
                            }
                        }
                    })
                    .disabled(!rarityset[index].unlocked)
                }
            }
            .overlay(
                Text(rarityname)
                    .foregroundColor(Color(raritycolor))
                    .font(.body)
                    .fontWeight(.semibold)
                    .padding(.leading)
                , alignment: .topLeading
            )
        }
    }
}
