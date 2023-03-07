//
//  walkpage2.swift
//  Quizz
//
//  Created by matteo on 26/07/2021.
//

import SwiftUI

struct walkpage2: View {
    
    var activitylogs: [ActivityLog] {
        var activitylogssample : [ActivityLog] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let days = ["Dimanche", "Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"]

        let sampleData: [ActivityLogStruct] = [
            ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date())) ?? Date(), daystring: days[Date().get(.weekday)-1], quizznbr: 1, duration: 1500, reussiteperc: 24.3),
            ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date().addingTimeInterval(-86400))) ?? Date(), daystring: days[Date().addingTimeInterval(-86400).get(.weekday)-1], quizznbr: 3, duration: 3000, reussiteperc: 57.9),
            ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date().addingTimeInterval(-172800))) ?? Date(), daystring: days[Date().addingTimeInterval(-172800).get(.weekday)-1], quizznbr: 0, duration: 0, reussiteperc: 0),
            ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date().addingTimeInterval(-259200))) ?? Date(), daystring: days[Date().addingTimeInterval(-259200).get(.weekday)-1], quizznbr: 2, duration: 2000, reussiteperc: 88.9),
            ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date().addingTimeInterval(-345600))) ?? Date(), daystring: days[Date().addingTimeInterval(-345600).get(.weekday)-1], quizznbr: 1, duration: 900, reussiteperc: 34.8),
            ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date().addingTimeInterval(-432000))) ?? Date(), daystring: days[Date().addingTimeInterval(-432000).get(.weekday)-1], quizznbr: 4, duration: 3500, reussiteperc: 68.4),
            ActivityLogStruct(date: dateFormatter.date(from: dateFormatter.string(from: Date().addingTimeInterval(-518400))) ?? Date(), daystring: days[Date().addingTimeInterval(-518400).get(.weekday)-1], quizznbr: 2, duration: 1400, reussiteperc: 54.1)
        ]
        
        for activity in sampleData {
            let activitylog = ActivityLog()
            activitylog.date = activity.date
            activitylog.daystring = activity.daystring
            activitylog.duration = activity.duration
            activitylog.quizznbr = activity.quizznbr
            activitylog.reussiteperc = activity.reussiteperc
            activitylogssample.append(activitylog)
        }
        return activitylogssample
    }
    @State var selectedtab: Int = 1
    
    var body: some View {
        VStack{
            TabView(selection: $selectedtab){
                VStack(alignment: .center, spacing: 5){
                    Text("Révise")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("purple2"))
                    Text("Entraine toi sur les différents quizzs afin de préserver tes connaissances sur le long terme.")
                        .foregroundColor(.black.opacity(0.6))
                        .font(.subheadline)
                        .multilineTextAlignment(.center)

                    Spacer()

                    QuestionSample(question: "Dans Mn(R), si AB=AC a t'on B=C ?", repa: "Oui, nécessairement", repb: "Non, jamais", repc: "Cela dépend", answer: "Cela dépend")
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0.0, y: -10)
                    
                }
                .padding(.top)
                .padding(.horizontal)
                .tag(1)

                VStack(alignment: .center, spacing: 5){
                    Text("Organise")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("purple2"))
                    Text("Suit tes progrès et ton activité, la régularité est la clé d'un apprentissage réussit.")
                        .foregroundColor(.black.opacity(0.6))
                        .font(.subheadline)
                        .multilineTextAlignment(.center)

                    Spacer()

                    ActivityHistoryView(sample: true, selectedIndex: 6, activitylogs: activitylogs)
                        .padding(.horizontal, -2)
                        .padding(.bottom)

                }
                .padding()
                .tag(2)
                
                VStack(alignment: .center, spacing: 5){
                    Text("Partage")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("purple2"))
                    Text("Compare toi avec tes amis dans des compétitions hebdomadaire et bien plus encore !")
                        .foregroundColor(.black.opacity(0.6))
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    LeaderboardSample()
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0.0, y: -10)
                    
                    
                }
                .padding(.top)
                .padding(.horizontal)
                .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(width: UIScreen.main.bounds.width*0.85, height: UIScreen.main.bounds.width*1.2)
            .background(Color("lightgrey"))
            .cornerRadius(15)
            .padding(.top)
            .padding()
            .overlay(
                HStack{
                    ForEach(1...3, id:\.self){ index in
                        Circle()
                            .fill(index == selectedtab ? Color(.white) : Color("black").opacity(0.4))
                            .frame(width: 7, height: 7)
                    }
                }, alignment: .bottom
            )
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color("purple1").ignoresSafeArea(edges: .all))
    }
}

struct QuestionSample: View {
    
    var question: String
    var repa : String
    var repb : String
    var repc : String
    var answer : String
    
    @State var selected = ""
    @State var isSubmitted = false
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 0){
                ZStack{
                    
                    VStack{
                        Spacer(minLength: 25)
                        HStack{
                            Spacer(minLength: 25)
                            Text(question)
                                .font(.subheadline)
                                .foregroundColor(Color("brown"))
                                .minimumScaleFactor(0.25)
                                .multilineTextAlignment(.center)
                            Spacer(minLength: 25)
                        }
                        Spacer(minLength: 25)
                    }
                    .background(Color("orange2").opacity(0.45))
                    .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.height*0.15, alignment: .center)
                    .cornerRadius(5)
                    
                    VStack{
                        Text("0/1")
                            .font(.caption)
                            .foregroundColor(Color("purple1"))
                            .fontWeight(.regular)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.white)
                            .cornerRadius(25)
                        
                        Spacer()
                        
                        Button(action: {
                            if isSubmitted {
                                withAnimation{
                                    isSubmitted.toggle()
                                    answered += 1
                                }
                            }
                            else{
                                checkAns()
                            }
                        }, label: {
                            HStack(spacing: 3){
                                Text("Suivant")
                                    .font(.caption)
                                    .foregroundColor(Color("purple1"))
                                    .fontWeight(.regular)
                                Image("thinarrowright")
                                    .renderingMode(.template)
                                    .resizable()
                                    .foregroundColor(Color("purple1"))
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.white)
                            .cornerRadius(25)
                            .frame(alignment: .center)
                        })
                    }
                }
                .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.height*0.19, alignment: .center)
                
                // options...
                
                Button(action: {selected = repa}, label: {
                    Text(repa)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(isSubmitted && repa == answer ? Color(.white) : selected == repa ? Color.white : Color("brown")).animation(.spring())
                        .padding(10)
                        .frame(width: UIScreen.main.bounds.width*0.45)
                        .background(color(option: repa) == Color("black") ? Color("whitebutton") : color(option: repa)).animation(.spring())
                        .cornerRadius(5)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(color(option: repa).opacity(0.1),lineWidth: 1)
                        )
                        .shadow(color: color(option: repa).opacity(0.1), radius: 2, x: 0, y: 2)
                })
                .padding(.top, 10)
                
                Button(action: {selected = repb}, label: {
                    Text(repb)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(isSubmitted && repb == answer ? Color.white : selected == repb ? Color.white : Color("brown")).animation(.spring())
                        .padding(10)
                        .frame(width: UIScreen.main.bounds.width*0.45)
                        .background(color(option: repb) == Color("black") ? Color("whitebutton") : color(option: repb)).animation(.spring())
                        .cornerRadius(5)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(color(option: repb).opacity(0.1),lineWidth: 1)
                        )
                        .shadow(color: color(option: repb).opacity(0.1), radius: 2, x: 0, y: 2)
                })
                .padding(.top, 10)
                
                Button(action: {selected = repc}, label: {
                    Text(repc)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(isSubmitted && repc == answer ? Color.white : selected == repc ? Color.white : Color("brown")).animation(.spring())
                        .padding(10)
                        .frame(width: UIScreen.main.bounds.width*0.45)
                        .background(color(option: repc) == Color("black") ? Color("whitebutton") : color(option: repc)).animation(.spring())
                        .cornerRadius(5)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(color(option: repc).opacity(0.1),lineWidth: 1)
                        )
                        .shadow(color: color(option: repc).opacity(0.1), radius: 2, x: 0, y: 2)
                })
                .padding(.top, 10)
                
                Spacer(minLength: 0)
            }
            .padding()
            .ignoresSafeArea()
            .frame(width: UIScreen.main.bounds.width*0.65)
            .background(Color("lightgrey"))
        }
    }
    
    func color(option: String)->Color{
        
        if option == selected{
            
            // displaying if correct means green else red...
            
            if isSubmitted{
                
                if selected == answer{
                    return Color("green")
                }
                else{
                    return Color("red")
                }
            }
            else{
                return Color("orange")
            }
        }
        else{
            
            // displaying right if wrong selected...
            if isSubmitted && option != selected{
                if answer == option
                {return Color("green")}
            }
            return Color("black")
        }
    }
    
    // check answer...
    
    func checkAns(){
        
        if selected == answer{
            correct += 1
        }
        else{
            wrong += 1
        }
        
        isSubmitted.toggle()
    }
}

struct LeaderboardSample: View {
    
    @State private var rect1: CGRect = CGRect()
    
    var body: some View {
        ZStack(alignment: .top){
            
            VStack{
                ScrollView(.vertical, showsIndicators: false){
                    
                    let walkthroughusers: [dbuser] = [dbuser(name: "etienne.cap", filiere: "MPSI", prepa: "", weeklyscore: 624, bimonthlyscore: 4351, monthlyscore: 11268, icon: "heroset2", color: "ambiancepalette4"), dbuser(name: "justin_czn", filiere: "PC", prepa: "", weeklyscore: 522, bimonthlyscore: 4024, monthlyscore: 10423, icon: "fairyset5", color: "peachpalette2"), dbuser(name: "benjam1", filiere: "MP", prepa: "", weeklyscore: 431, bimonthlyscore: 3104, monthlyscore: 9745, icon: "baseset3", color: "ambiancepalette1"), dbuser(name: "tomdupont", filiere: "MP", prepa: "", weeklyscore: 945, bimonthlyscore: 5471, monthlyscore: 15223, icon: "medievalset1", color: "peachpalette6"), dbuser(name: "emily_cathy21", filiere: "PT", prepa: "", weeklyscore: 733, bimonthlyscore: 7513, monthlyscore: 45623, icon: "fairyset2", color: "peachpalette1"), dbuser(name: "lndeforas", filiere: "MP", prepa: "", weeklyscore: 132, bimonthlyscore: 1235, monthlyscore: 4561, icon: "fairyset8", color: "ambiancepalette8"), dbuser(name: "kimle", filiere: "BCPST", prepa: "",weeklyscore: 54, bimonthlyscore: 1741, monthlyscore: 2541, icon: "medievalset9", color: "peachpalette6"), dbuser(name: "hortense", filiere: "PTSI", prepa: "", weeklyscore: 452, bimonthlyscore: 2466, monthlyscore: 7895, icon: "fairyset3", color: "peachpalette9")]
                    
                    VStack{
                        ForEach(4...9, id:\.self){ index in
                            
                            leadercard(index: index, user: walkthroughusers[index-4], general: true, scoretype: "weekly", selfcard: false, sample: true)
                        }
                    }
                    .padding(.bottom, UIScreen.main.bounds.height*0.035)
                    .padding(.top, 50)
                }
            }
            .padding(.top, rect1.height-35)
            
            VStack(spacing: 0){
                HStack {
                
                Text("Classement")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {}, label: {
                    Image("Classement")
                        .renderingMode(.template)
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                })
                }
                .padding(.horizontal)
                .padding(.top)
                .frame(width: UIScreen.main.bounds.width*0.65)
                
                let walktop3: [dbuser] = [dbuser(name: "mattéo", filiere: "MP", prepa: "", weeklyscore: 1421, bimonthlyscore: 5469, monthlyscore: 27268, icon: "baseset1", color: "ambiancepalette5"), dbuser(name: "ayoub_ssd", filiere: "PSI", prepa: "", weeklyscore: 1328, bimonthlyscore: 4351, monthlyscore: 19543, icon: "heroset7", color: "ambiancepalette9"), dbuser(name: "jeanette", filiere: "PC", prepa: "", weeklyscore: 984, bimonthlyscore: 3545, monthlyscore: 14268, icon: "fairyset7", color: "ambiancepalette7")]
                
                top3view(users: walktop3, general: true, scoretype: "weekly", sample: true)
            }
            .padding(.bottom, 10)
            .frame(width: UIScreen.main.bounds.width*0.65)
            .background(Color("purple1").opacity(1)
                            .clipShape(CustomCorner(corners: [.bottomLeft,.bottomRight], size: 45))
                            .ignoresSafeArea(.all, edges: .top))
            .overlay(Color.clear.modifier(GeometryGetterMod(rect: $rect1)))
            
            
        }
        .frame(width: UIScreen.main.bounds.width*0.65)
        .background(Color("lightgrey").ignoresSafeArea(.all, edges: .all))
    }
}
