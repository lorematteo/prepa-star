//
//  Home.swift
//  Quizz
//
//  Created by matteo on 13/05/2021.
//

import SwiftUI

struct chapselection: View {
    
    @Binding var showview: String
    
    @State var matiere : String
    @State var filiere : String
    
    @State var chapitres : [Chapitre] = []
    
    @State var showquizz: Bool = false
    
    // pour stocker le chap choisit
    @State var selected: Bool = false
    @State var selectedchap : Chapitre = Chapitre()
    @State var selectedquizzid : String = ""
    @State var selectedquizzauteur: String = ""
    @State var selectedquizzmess: String = ""
    
    
    var body: some View {
        
        VStack {
            
            ZStack{
                HStack{
                    Button(action: {withAnimation(.spring()){showview = "detailview"}} ) {
                        HStack(spacing: 5){
                            
                            Image("thinarrowleft")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                        }
                    }
                    Spacer()
                    Button(action: {withAnimation(.spring()){showview = ""}} ) {
                        HStack(spacing: 5){
                            
                            Image("home")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                        }
                    }
                }
                .padding(.horizontal)
                
                VStack{
                    Text(matiere)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text(filiere)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.7)
                        .multilineTextAlignment(.center)
                    
                }
            }
            .padding(.top, 30)
            
            VStack {
                
                Spacer(minLength: 0)
                
                // Selection du chapitre...
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHGrid(rows: Array( repeating: GridItem(.flexible(),spacing: 0),count: 1),spacing: 0, content: {
                        
                        // Chapitres...
                        ForEach(chapitres.indices, id: \.self){index in
                            
                            chapcard(selected: $selected, selectedchap: $selectedchap, selectedquizzid: $selectedquizzid, selectedquizzauteur: $selectedquizzauteur, selectedquizzmess: $selectedquizzmess, filiere: filiere, matiere: matiere, chapitre: chapitres[index])
                            
                        }
                        .padding(10)
                    })
                    .padding(.horizontal, UIScreen.main.bounds.width*0.5 - UIScreen.main.bounds.width*0.7/2 - 10)
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.75)
                
                Spacer(minLength: 0)
                
                ZStack{
                    
                    Button(action: {
                        showquizz = true
                    }, label: {
                        Text("Lancer le Quizz")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(width: UIScreen.main.bounds.width - 45)
                            .background(Color("orange"))
                            .clipShape(Capsule())
                    })
                    .opacity(selected ? 1 : 0).animation(.spring())
                    
                    VStack {
                        Image("thinarrowup")
                            .renderingMode(.template)
                            .foregroundColor(.gray)
                        
                        Text("Choisit une catégorie")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .opacity(selected ? 0 : 1)
                    .offset(y: selected ? 100 : 0)
                    .animation(.spring())
                }
                .offset(y: -UIScreen.main.bounds.height*0.1/2)
                
                Spacer(minLength: 0)
            }
            .background(Color("lightgrey").clipShape(CustomCorner(corners: [.topLeft,.topRight], size: 35)).ignoresSafeArea(.all, edges: .top))
            .padding(.top)
        }
        .onAppear(perform: {
            self.chapitres = DB_Manager().getChapitres(filiereValue: filiere, matiereValue: matiere)
        })
        .background(Color("purple1").ignoresSafeArea())
        .fullScreenCover(isPresented: $showquizz, content: {
            QA(chap: selectedchap, quizzid: selectedquizzid, auteur: selectedquizzauteur, endmessage: selectedquizzmess)
        })
    }
}


struct chapcard: View{
    
    
    @Binding var selected: Bool
    @Binding var selectedchap: Chapitre
    @Binding var selectedquizzid: String
    @Binding var selectedquizzauteur: String
    @Binding var selectedquizzmess: String
    
    var filiere: String
    var matiere: String
    var chapitre: Chapitre
    
    @State private var flipped: Bool = false
    @State var contentRotation = 0.0
    @State var sorted: String = "no"
    @State var finishloading: String = ""
    
    @StateObject var fbq = FirebaseQuizz()
    
    var body: some View{
        
        ZStack{
            
            VStack(){
                
                Image("\(filiere.lowercased())\(matiere.lowercased())chap\(chapitre.num)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                
                Text(chapitre.name)
                    .foregroundColor(Color("black"))
                    .font(.title2)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                Text("CHAPITRE \(String(chapitre.num))")
                    .foregroundColor(Color("black"))
                    .opacity(0.6)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width*0.70, height: UIScreen.main.bounds.height*0.58)
            .background(Color("whitebutton"))
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 0)
            .onTapGesture(perform: {
                if selectedchap.name != chapitre.name{
                    withAnimation(.easeIn){
                        selectedchap = chapitre
                        selectedquizzid = ""
                        selected = false
                    }
                    if checkNewQuizz(){
                        DB_Manager().saveNewSaw(quizzidValue: fbq.lastquizz[0].id ?? "")
                    }
                    flip()
                    fbq.getQuizzListe(filiere: filiere, matiere: matiere.lowercased(), chapitre: Int(chapitre.num), completion: { result in
                                        if result{
                                            finishloading = "true"
                                        } else {
                                            finishloading = "error"
                                        }
                    })
                }
                
            })
            .opacity(flipped ? 0 : 1)
            .overlay(
                LottieView(filename: "newbadge")
                    .frame(width: 50, height: 50)
                    .opacity(fbq.lastquizz.isEmpty ? 0 : checkNewQuizz() ? 1 : 0)
                    .padding(.bottom)
                ,alignment: .topTrailing
            )
            
            
            VStack{
                
                HStack{
                    Text("Liste des quizzs")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action:{withAnimation(.easeIn){selectedquizzid = ""; selected = false; selectedchap = Chapitre()}; flip()}, label:{
                        Image("thinarrowleft")
                            .renderingMode(.template)
                            .foregroundColor(Color("black"))
                            .opacity(0.9)
                            .frame(width: 21, height: 21)
                    })
                }
                .padding()
                
                HStack{
                    
                    Button(action: {if sorted != "star"{ sorted = "star" } else { sorted = "no" }}, label: {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("yellow"))
                            .font(.subheadline)
                    })
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color("black").opacity(sorted == "star" ? 0.6 : 0.3), lineWidth: 1))
                    .animation(.easeIn)
                    
                    Button(action: {if sorted != "diff"{ sorted = "diff" } else { sorted = "no" }}, label: {
                        HStack(spacing: 3){
                            Capsule()
                                .fill(Color("green"))
                                .frame(width: 5, height: 9)
                            Capsule()
                                .fill(Color("orange"))
                                .frame(width: 5, height: 14)
                            Capsule()
                                .fill(Color("red"))
                                .frame(width: 5, height: 9)
                        }
                    })
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color("black").opacity(sorted == "diff" ? 0.6 : 0.3), lineWidth: 1))
                    .animation(.easeIn)
                    
                    Button(action: {if sorted != "time"{ sorted = "time" } else { sorted = "no" }}, label: {
                        Image(systemName: "clock")
                            .font(.subheadline)
                    })
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color("black").opacity(sorted == "time" ? 0.6 : 0.3), lineWidth: 1))
                    .animation(.easeIn)
                    
                }
                .padding(.bottom, 5)
                
                let quizzliste = fbq.quizzliste
                let quizzlistestar : [fbquizz] = fbq.quizzliste.sorted{ $0.avgRating > $1.avgRating }
                let quizzlistediff : [fbquizz] = fbq.quizzliste.sorted{ $0.difficulty < $1.difficulty }
                let quizzlistetime : [fbquizz] = fbq.quizzliste.sorted{ $0.creationDate < $1.creationDate }
                
                ScrollView(showsIndicators: false){
                    VStack{
                        if finishloading == "true"{
                            if sorted == "star"{
                                ForEach(quizzlistestar.indices, id:\.self){ index in
                                    quizzcard(selected: $selected, selectedchap: $selectedchap, selectedquizzid: $selectedquizzid, selectedquizzauteur: $selectedquizzauteur, selectedquizzmess: $selectedquizzmess,quizz: quizzlistestar[index], chapitre: selectedchap)
                                        .padding(.vertical, 3)
                                }
                            } else if sorted == "diff"{
                                ForEach(quizzlistediff.indices, id:\.self){ index in
                                    quizzcard(selected: $selected, selectedchap: $selectedchap, selectedquizzid: $selectedquizzid, selectedquizzauteur: $selectedquizzauteur, selectedquizzmess: $selectedquizzmess,quizz: quizzlistediff[index], chapitre: selectedchap)
                                        .padding(.vertical, 3)
                                }
                            } else if sorted == "time"{
                                ForEach(quizzlistetime.indices, id:\.self){ index in
                                    quizzcard(selected: $selected, selectedchap: $selectedchap, selectedquizzid: $selectedquizzid, selectedquizzauteur: $selectedquizzauteur, selectedquizzmess: $selectedquizzmess,quizz: quizzlistetime[index], chapitre: selectedchap)
                                        .padding(.vertical, 3)
                                }
                            } else if quizzliste == []{
                                Spacer()
                                Text("Pas encore de quizzs de la communautée disponible, soit le premier à en créer un !")
                                    .font(.caption)
                                    .foregroundColor(.gray.opacity(0.7))
                                    .padding()
                                    .multilineTextAlignment(.center)
                                Spacer()
                            } else {
                                ForEach(quizzliste.indices, id:\.self){ index in
                                    quizzcard(selected: $selected, selectedchap: $selectedchap, selectedquizzid: $selectedquizzid, selectedquizzauteur: $selectedquizzauteur, selectedquizzmess: $selectedquizzmess, quizz: fbq.quizzliste[index], chapitre: selectedchap)
                                        .padding(.vertical, 3)
                                }
                            }
                        }
                        if finishloading == "error" {
                            Spacer()
                            Text("Erreur lors du chargement des quizzs, réessaie plus tard. Si le problème persiste contacte moi ! :)")
                                .font(.caption)
                                .foregroundColor(.gray.opacity(0.7))
                                .padding()
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        if finishloading == ""{
                            Spacer()
                            Loader()
                                .frame(width: 50, height: 50)
                            Text("Chargement...")
                                .font(.footnote)
                                .foregroundColor(.gray.opacity(0.7))
                            Spacer()
                        }
                    }
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width*0.70, height: UIScreen.main.bounds.height*0.58)
            .background(Color("whitebutton"))
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 0)
            .rotation3DEffect(.degrees(180), axis: (x:0, y:1, z:0))
            .opacity(flipped ? 1 : 0)
            .onTapGesture {
                withAnimation(.easeIn){selectedquizzid = ""; selected = false; selectedchap = Chapitre()}; flip()
            }
            
        }
        .rotation3DEffect(.degrees(contentRotation), axis: (x:0, y:1, z:0))
        .onAppear(perform: {
            fbq.getLastQuizz(filiere: filiere, matiere: matiere.lowercased(), chapitre: Int(chapitre.num))
        })
    }
    
    func flip() {
        let animationTime = 0.5
        withAnimation(Animation.easeOut(duration :animationTime)){
            contentRotation += 180
            flipped.toggle()
        }
    }
    
    func checkNewQuizz() -> Bool{
        if fbq.lastquizz.isEmpty{
            return false
        } else {
            let delta = Date.today() - fbq.lastquizz[0].creationDate
            if delta < 86400{
                if DB_Manager().checkIfNewSaw(quizzidValue: fbq.lastquizz[0].id ?? ""){
                    return false
                } else {
                    return true
                }
            } else {
                return false
            }
        }
    }
}

struct quizzcard: View{
    
    @Binding var selected: Bool
    @Binding var selectedchap: Chapitre
    @Binding var selectedquizzid: String
    @Binding var selectedquizzauteur: String
    @Binding var selectedquizzmess: String
    
    @State var quizz: fbquizz
    @State var chapitre: Chapitre
    
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                Text(quizz.name)
                    .font(.footnote)
                    .foregroundColor(Color("brown"))
                    .lineLimit(1)
                Text(quizz.auteur)
                    .font(.caption)
                    .foregroundColor(Color("brown").opacity(0.7))
                    .lineLimit(1)
            }
            
            Spacer()
            
            VStack(spacing: 2){
                Text("\(quizz.duration)m")
                    .font(.body)
                    .fontWeight(.thin)
                    .font(.title2)
                HStack(spacing: 3){
                    let difficulty = quizz.difficulty
                    Capsule()
                        .fill(Color("green"))
                        .frame(width: 5, height: difficulty == 1 ? 14 : difficulty == 2 ? 9 : 5)
                    Capsule()
                        .fill(Color("orange"))
                        .frame(width: 5, height: difficulty == 1 ? 9 : difficulty == 2 ? 14 : 9)
                    Capsule()
                        .fill(Color("red"))
                        .frame(width: 5, height: difficulty == 1 ? 5 : difficulty == 2 ? 9 : 14)
                }
            }
        }
        .padding()
        .background(Color("lightgrey"))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: selectedquizzid == quizz.id ? 3 : 0)
                .opacity(1)
                .animation(.easeIn)
        )
        .cornerRadius(15)
        .overlay(
            HStack(spacing: 7){
                HStack{
                    Rectangle()
                        .foregroundColor(Color("yellow"))
                        .frame(width: UIScreen.main.bounds.width*0.2 / 5 * CGFloat(quizz.avgRating), height: 20)
                    Spacer(minLength: 0)
                }
                .background(Color.gray)
                .mask(
                    HStack(spacing: 5){
                        ForEach(1...5, id: \.self){ index in
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(.largeTitle)
                        }
                    }
                )
                .frame(width: UIScreen.main.bounds.width*0.2, height: 20)
                
                Text("/ \(quizz.numRatings)")
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            .padding(4)
            .padding(.horizontal, 4)
            .background(Color("whitebutton").opacity(0.8))
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding(.horizontal)
            .offset(y: 15)
            ,alignment: .bottomLeading
        )
        .onTapGesture {
            withAnimation(.easeIn){
                if selectedquizzid == quizz.id{
                    selectedquizzid = ""
                    selected = false
                } else {
                    selectedquizzid = quizz.id ?? ""
                    selectedquizzauteur = quizz.auteur
                    selectedquizzmess = quizz.message
                    selectedchap = chapitre
                    if selectedquizzid != ""{
                        selected = true
                    }
                }
            }
        }
        .padding(.bottom)
    }
}
