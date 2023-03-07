//
//  settings.swift
//  Quizz
//
//  Created by matteo on 18/05/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("username") var name: String = ""
    @AppStorage("userfiliere") var filiere: String = ""
    
    @Binding var showview: String
    @Binding var darkModeEnabled : Bool
    
    @State var showsetting: String = ""
    @State var customprofil: String = ""
    @State var tapped: Bool = false
    
    var body: some View {
        
        ZStack{
            
            VStack {
                
                HStack {
                    
                    Text("Paramètres")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {withAnimation(.spring()){self.showview = ""}}, label: {
                            Image("Paramètres")
                                .renderingMode(.template)
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                    })
                    
                    
                }
                .padding()
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    
//                  COMPTE
                    
                    HStack(){
                        Text("Compte")
                            .font(.title)
                            .foregroundColor(Color("brown"))
                        
                        Spacer()
                        
                        if showsetting != ""{
                            
                            HStack{
                                Spacer()
                                Button(action: {
                                    withAnimation(.spring()){self.showsetting = ""}
                                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                                        tapped = false
                                    }
                                }, label: {
                                    Image("thinarrowleft")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.gray)
                                        .frame(width: 24, height: 24)
                                })
                                .padding(.trailing)
                            }
                            .transition(.move(edge: .trailing))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.leading, UIScreen.main.bounds.width*0.05)
                    
                    ZStack{
                        
                        VStack(alignment: .leading, spacing: 0){
                            settingtab(showsetting: $showsetting, darkModeEnabled: $darkModeEnabled, tapped: $tapped, name: "Compte", color: "", image: "")
                                .padding(.vertical)
                            
                            HStack{
                                Text("Général")
                                    .font(.title)
                                    .foregroundColor(Color("brown"))
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            .padding(.leading, UIScreen.main.bounds.width*0.05)
                            
                            ScrollView(.vertical, showsIndicators: false, content: {
                                
                                VStack(spacing: 20){
                                    
                                    settingtab(showsetting: $showsetting, darkModeEnabled: $darkModeEnabled, tapped: $tapped, name: "Language", color: "orange", image: "globe")
                                    
                                    settingtab(showsetting: $showsetting, darkModeEnabled: $darkModeEnabled, tapped: $tapped, name: "Notifications", color: "lightblue", image: "bell3")
                                    
                                    settingtab(showsetting: $showsetting, darkModeEnabled: $darkModeEnabled, tapped: $tapped, name: "Dark Mode", color: "purple4", image: "moon")
                                    
                                    settingtab(showsetting: $showsetting, darkModeEnabled: $darkModeEnabled, tapped: $tapped, name: "Assistance", color: "red", image: "lifebuoy")
                                    
                                    settingtab(showsetting: $showsetting, darkModeEnabled: $darkModeEnabled, tapped: $tapped, name: "Crédits", color: "grey", image: "credits")
                                    
                                }
                                .padding(.vertical)
                            })
                        }
                        
                        if showsetting == "Compte"{
                            settingacc(showsetting: $showsetting, customprofil: $customprofil)
                                .transition(.move(edge: .trailing))
                                .zIndex(1)
                        }
                        if showsetting == "Language"{
                            settinglang(showsetting: $showsetting)
                                .transition(.move(edge: .trailing))
                                .zIndex(1)
                        }
                        if showsetting == "Notifications"{
                            settingsselectedgeneralnotif(showsetting: $showsetting)
                                .transition(.move(edge: .trailing))
                                .zIndex(1)
                        }
                        if showsetting == "Assistance"{
                            settingsselectedgeneralassis(showsetting: $showsetting)
                                .transition(.move(edge: .trailing))
                                .zIndex(1)
                        }
                        if showsetting == "Crédits"{
                            settingcredits(showsetting: $showsetting)
                                .transition(.move(edge: .trailing))
                                .zIndex(1)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding(.top)
                .padding(.top)
                .background(Color("lightgrey").clipShape(CustomCorner(corners: [.topLeft,.topRight], size: 55)).ignoresSafeArea(.all, edges: .bottom))
            }
            .blur(radius: customprofil == "true" ? 3.0 : 0)
            .zIndex(0)
            
            if customprofil == "true"{
                CustomProfilView(show: $showview)
                    .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    .zIndex(1)
            }
        }
        .background(Color("purple1").ignoresSafeArea(.all, edges: .all))
        .ignoresSafeArea(.keyboard)
    }
}


struct settingtab: View{
    
    @AppStorage("username") var username: String = ""
    @AppStorage("userfiliere") var userfiliere: String = ""
    
    @Binding var showsetting: String
    @Binding var darkModeEnabled: Bool
    @Binding var tapped: Bool
    
    @State var name: String
    @State var color: String
    @State var image: String
    
    
    var body: some View{
        
        HStack(spacing: 0){
            
            if name != "Compte"{
                ZStack{
                    Circle()
                        .fill(Color(color).opacity(0.2))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45)
                    
                    Image(image)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(Color(color))
                        .frame(width: 20, height: 20)
                }
                
                Text(name)
                    .font(.body)
                    .fontWeight(.medium)
                    .padding()
            } else {
                userIcon(size: UIScreen.main.bounds.height > 850 ? 80 : 65, linewidth: 5)
                
                VStack(alignment: .leading, spacing: 1){
                    Text(username)
                        .font(.headline)
                        .scaledToFit()
                    Text(userfiliere)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.leading)
            }
            
            Spacer()
            
            if name == "Language"{
                Text("Francais")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
            }
            
            if name != "Dark Mode"{
                Button(action: {
                        if !tapped{
                            withAnimation(.spring()){self.showsetting = name}
                            tapped = true
                        }
                }, label: {
                    ZStack{
                        Rectangle()
                            .fill(Color("whitebutton"))
                            .frame(width: 45, height: 45)
                            .cornerRadius(15)
                        Image("thinarrowright")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color("black"))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                    }
                })
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0.0, y: 0.0)
                .padding(.trailing, 10)
            } else {
                Toggle(isOn:$darkModeEnabled, label: {
                    Text(darkModeEnabled ? "On" : "Off")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                .toggleStyle(SwitchToggleStyle(tint: Color("purple4")))
                .onChange(of: darkModeEnabled, perform: { value in
                    SystemThemeManager
                        .shared
                        .handleTheme(darkMode: darkModeEnabled)
                })
                .padding(.trailing, 10)
            }
        }
        .padding(.horizontal)
        
    }
}
