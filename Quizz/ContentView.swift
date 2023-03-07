//
//  ContentView.swift
//  Quizz
//
//  Created by matteo on 13/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("firstlaunch") var firstlaunch: Bool = true
    
    @State var animate: Bool = false
    @State var invisible: Bool = false
    
    var body: some View {
            
        ZStack{
            
            if firstlaunch{
                WalkthroughView()
            } else {
                Accueil()
            }
            
            ZStack{
                Color("purple1")
                Image("icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 85, height: 85)
                    .scaleEffect(animate ? 50 : 1)
                    .animation(Animation.easeIn(duration: 0.2))
            }
            .opacity(invisible ? 0 : 1)
            .animation(.easeIn(duration: 0.2))
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    animate.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    invisible.toggle()
                }
            })
        }
    }
}

struct Accueil : View {
    
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @AppStorage("userannee") var userannee: Int = 0
    
    @State var showview: String = ""
    
    @State var selected = "Quizz"
    
    @State var selectedfiliere: Filiere = Filiere()
    @State var selectedmatiere: Matiere = Matiere()
    @State var sousfiliere: Bool = false
    
    @State var reward: AvatarColor = AvatarColor(type: "avatar", name: "", set: "", unlocked: true, rarity: "", price: 0)
    
    @State var disabled: Bool = false
    
    var body: some View{
        
        ZStack {
            
            TabView(selection: $selected){
                
                QuizzView(showview: $showview, selectedfiliere: $selectedfiliere, selectedmatiere: $selectedmatiere, disabled: $disabled)
                    .tag("Quizz")
                
                LeaderboardView()
                    .tag("Classement")
                
                ProfilView(showview: $showview)
                    .tag("Profil")
                
                ShopView(showview: $showview, reward: $reward)
                    .tag("Shop")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .background(Color("purple1").ignoresSafeArea(.all))
            .blur(radius: showview != "" ?  3.0 : 0)
            .disabled(showview != "")
            
            VStack{
                Spacer()
                tabbar(selected: $selected)
                    .shadow(color: Color("black").opacity(0.3), radius: 10, x: 0.0, y: -5)
                    .blur(radius: showview != "" ?  3.0 : 0)
                    .disabled(showview != "")
            }
            
            if showview == "customprofil"{
                CustomProfilView(show: $showview)
                    .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    .zIndex(1)
            }
            
            if showview == "reward"{
                RewardView(show: $showview, reward: reward)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    .zIndex(1)
            }
            if showview == "wheel"{
                LuckyWheel(show: $showview)
                    .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    .zIndex(1)
            }
            
            if showview == "settings"{
                SettingsView(showview: $showview, darkModeEnabled: $darkModeEnabled)
                    .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    .zIndex(1)
            }
            
            if showview == "detailview"{
                DetailView(showview: $showview, matiere: $selectedmatiere, filiere: $selectedfiliere, sousfiliere: $sousfiliere, disabled: $disabled)
                    .zIndex(1)
                    .transition(.opacity)
            }
            
            if showview == "chapselection"{
                chapselection(showview: $showview, matiere: selectedmatiere.title, filiere: sousfiliere ? selectedfiliere.sousfiliere : selectedfiliere.name)
                    .zIndex(2)
                    .transition(.opacity)
            }
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color("purple1"))
        .onAppear{
            if userannee == 1{
                sousfiliere = true
            }
            SystemThemeManager
                .shared
                .handleTheme(darkMode: darkModeEnabled)
        }
    }
}

struct tabbar: View{
    
    @Binding var selected: String
    
    let menu: [String] = ["Quizz", "Classement", "Profil", "Shop"]
    
    var body: some View{
        
        HStack(spacing: 0){
            
            ForEach(menu,id: \.self){item in
                
                Button(action: {
                    withAnimation(.easeIn){
                        selected = item
                    }
                }, label: {
                    
                    VStack(spacing: 3){
                        
                        Image(item)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 26, height: 26)
                            .foregroundColor(selected == item ? Color("tabbarbutton") : Color("grey"))
                            .animation(.easeIn)
                    }
                    .padding(.vertical, 10)
                    .frame(width: 70, height: 50)
                    .offset(y: selected == item ? 0 : 5)
                    .animation(.easeIn)
                })
                
                if item != menu.last{Spacer(minLength: 0)}
                
            }
        }
        .padding(.horizontal, 25)
        // for smaller size iphone padding will be 15 and for notch phone no padding
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 5 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        .background(Color("lightgrey").opacity(1).ignoresSafeArea())
        
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarButton(selected: Binding.constant(false), value: "Quizz", centerX: Binding.constant(0), rect: CGRect)
//    }
//}
