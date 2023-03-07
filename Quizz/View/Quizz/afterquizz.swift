//
//  afterquizz.swift
//  Quizz
//
//  Created by matteo on 21/07/2021.
//

import SwiftUI

struct afterquizz: View {
    
    @AppStorage("userid") var userid : String = ""
    
    @Binding var quizzended: Bool
    @Binding var correct : Int
    @Binding var wrong : Int
    @Binding var answered: Int
    
    @State var userInfos: Informations = Informations()
    @State var expInfos: ExperienceStruct = ExperienceStruct(exp: 7, niveau: 0, rang: "Débutant", xpneeded: 0)
    @State var xpprogress: CGFloat = 0
    @State var usermoney: Int = 0
    @State var userscore: Int = 0
    
    var chapitre : String
    var numchap : Int
    
    ///
    
    @State private var end: Int = 1
    @State private var flipped: Bool = false
    @State var contentRotation = 0.0
    
    @State var expgained: Int = 0
    @State var moneygained: Int = 0
    @State var scoregained: Int = 0
    
    @State var canclose: Bool = false
    
    @State private var animpoint = false
    @State private var animxp = false
    
    @StateObject var leaderboard = Leaderboard()
    
    @Environment(\.presentationMode) var present
    
    var body: some View {
        
        VStack(spacing: 30){
            
            Spacer()
            
            VStack(spacing: UIScreen.main.bounds.height*0.1){
                VStack(spacing: 0){
                    Text("Chapitre \(String(numchap))")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .opacity(0.8)
                    Text(chapitre.uppercased())
                        .fontWeight(.heavy)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    Text(CGFloat(correct)/CGFloat(answered) < 0.25 ? "Hard work beats talent when talent doesn't work hard." : CGFloat(correct)/CGFloat(answered) < 0.5 ? "You always pass failure on your way to success." : CGFloat(correct)/CGFloat(answered) < 0.75 ? "Doubt kills more dreams than failure ever will." : CGFloat(correct)/CGFloat(answered) < 1 ? "It always seems impossible until it is done." : "If you want something you never had, you have to do something you've never done.")
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .padding(.top, -5)
                        .foregroundColor(Color.white)
                        .opacity(0.6)
                        .padding(.horizontal)
                }
                .multilineTextAlignment(.center)
                ZStack{
                    ZStack {
                        
                        Circle()
                            .stroke(lineWidth: 20)
                            .opacity(0.3)
                            .foregroundColor(Color("purple2"))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width*0.4)
                        
                        Circle()
                            .stroke(lineWidth: 10)
                            .opacity(1)
                            .foregroundColor(Color("purple2"))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width*0.4)
                        
                        Circle()
                            .trim(from: 0.0, to: animxp ? CGFloat((Double(expInfos.exp)/Double(expInfos.xpneeded))) : xpprogress)
                            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color("green").opacity(0.9))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width*0.4)
                            .rotationEffect(Angle(degrees: 270))
                            .animation(.easeInOut(duration: 2.5))
                        
                        
                        userIcon(size: UIScreen.main.bounds.width*0.35, linewidth: 0)
                        
                    }
                    .opacity(flipped ? 1 : 0)
                    .overlay(
                        Text("+ \(expgained)XP")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .offset(y: animxp ? 35 : 45)
                            .opacity(animxp ? 1 : 0)
                        , alignment: .bottom)
                    .rotation3DEffect(.degrees(180), axis: (x:0, y:1, z:0))
                    .animation(.easeOut)
                    
                    ZStack {
                        
                        Circle()
                            .stroke(lineWidth: 20)
                            .opacity(0.3)
                            .foregroundColor(Color("purple2"))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width*0.4)
                        
                        Circle()
                            .stroke(lineWidth: 10)
                            .opacity(1)
                            .foregroundColor(Color("purple2"))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width*0.4)
                        
                        Circle()
                            .trim(from: 0.0, to: animpoint ? CGFloat(CGFloat(correct)/CGFloat(answered)) : 0)
                            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color("orange").opacity(0.9))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width*0.4)
                            .rotationEffect(Angle(degrees: 270))
                            .animation(.easeInOut(duration: 2.5))
                        
                        
                        VStack(spacing: 0){
                            HStack(alignment: .top, spacing: 0){
                                Text("\(String(format: "%.0f", (CGFloat(correct)/CGFloat(answered)*100)))")
                                    .fontWeight(.bold)
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)
                                Text("%")
                                    .fontWeight(.medium)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .offset(y: 7)
                            }
                            Text("\(String(correct))/\(String(answered))")
                                .font(.title2)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                                .offset(y: -10)
                            
                        }
                        
                    }
                    .onAppear(){self.animpoint.toggle()}
                    .opacity(flipped ? 0 : 1)
                }
                .rotation3DEffect(.degrees(contentRotation), axis: (x:0, y:1, z:0))
                ZStack{
                    HStack{
                        Spacer()
                        VStack(alignment: .leading, spacing: 5){
                            Text(CGFloat(correct)/CGFloat(answered) < 0.25 ? "Insuffisant :" : CGFloat(correct)/CGFloat(answered) < 0.5 ? "A revoir :" : CGFloat(correct)/CGFloat(answered) < 0.75 ? "Super :" : CGFloat(correct)/CGFloat(answered) < 1 ? "Très bien :" : "Excellent :")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text(CGFloat(correct)/CGFloat(answered) < 0.25 ? "Tes connaissances sur ce chapitre sont trop fragile. Revois le cours et n'hésite pas à refaire ce quizz pour t'entrainer et mémoriser les réponses. Courage !" : CGFloat(correct)/CGFloat(answered) < 0.5 ? "Tu maitrise une partie du chapitre mais ce n'est pas assez pour tout casser lors des concours ! Concentre toi sur tes difficultées et reviens faire un sans faute." : CGFloat(correct)/CGFloat(answered) < 0.75 ? "Tu à une bonne maitrise du chapitre mais tu peut encore l'améliorer ! Perfectionne tes connaissances et entraine toi sur différents quizz pour progresser." : CGFloat(correct)/CGFloat(answered) < 1 ? "Bravo ! Tu maitrise presque le chapitre à la perfection, encore un peu d'entrainement et il n'aura plus aucun secret pour toi, courage." : "Euh .. wow, calme toi un peu tu va voler mon admissibilitée aux concours, j'ai pas envie de redoubler une nouvelle fois stp.")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                        }
                        .frame(width: UIScreen.main.bounds.width*0.8, height: 140)
                        Spacer()
                    }
                    .opacity(end == 1 ? 1 : 0)
                    .animation(.easeOut(duration: 0.5))
                    
                    VStack(alignment: .leading, spacing: 10){
                        HStack{
                            MoneyIndicator(total: $usermoney)
                            HStack(spacing: 5){
                                Text("+ \(moneygained)")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Image("coin")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width : 15, height: 15)
                            }
                            .opacity(end == 2 ? 1 : 0)
                            .offset(y: end == 2 ? 0 : 10)
                            .animation(.easeOut.delay(1))
                        }
                        HStack{
                            ScoreIndicator(total: $userscore)
                            HStack(spacing: 5){
                                Text("+ \(scoregained)")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Image("crown")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15, height: 15)
                            }
                            .opacity(end == 2 ? 1 : 0)
                            .offset(y: end == 2 ? 0 : 10)
                            .animation(.easeOut.delay(scoregained > 0 ? 2 : 1.5))
                        }
                    }
                    .opacity(end == 2 ? 1 : 0)
                    .animation(.easeOut(duration: 0.5))
                }
            }
            
            Button(action: {
                if end == 1{
                    let niv = expInfos.niveau
                    if correct == answered{
                        scoregained = correct * 5 + 25
                        moneygained = correct * 2 + 10
                    } else {
                        scoregained = correct * 5
                        moneygained = correct * 2
                    }
                    let xpmultiplicator = niv < 5 ? 0.5 : niv < 10 ? 1 : 1.5
                    expgained = Int(ceil(Double(correct) * xpmultiplicator))
                    DB_Manager().ExpIncrement(nbr: Int64(expgained))
                    DB_Manager().MoneyIncrement(nbr: Int64(moneygained))
                    DB_Manager().BonneRepTotalIncrement(nbr: Int64(correct))
                    DB_Manager().QuizzTotalIncrement(nbr: Int64(1))
                    DB_Manager().MauvaiseRepTotalIncrement(nbr: Int64(wrong))
                    leaderboard.incrementUserScore(userID: userid, score: scoregained)
                    
                    self.userInfos = DB_Manager().getUserInfos()
                    self.expInfos = Experience().getXPInfos(exp: Double(self.userInfos.exp))
                    
                    flip()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        self.animxp = true
                        canclose = true
                    }
                    MoneyIndicator(total: $usermoney).addNumberWithRollingAnimation(addvalue: moneygained, delay: 1)
                    ScoreIndicator(total: $userscore).addNumberWithRollingAnimation(addvalue: scoregained, delay: 2)
                    end+=1
                } else {
                    if canclose{
                        // closing sheet...
                        present.wrappedValue.dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            quizzended = false
                            answered = 0
                            correct = 0
                            wrong = 0
                        }
                    }
                }
                
            }, label: {
                Text("Suivant")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 150)
                    .background(Color("orange"))
                    .cornerRadius(15)
                    .opacity(end == 2 ? canclose ? 1 : 0.7 : 1)
            })
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color("purple1").ignoresSafeArea())
        .onAppear(perform: {
            self.userInfos = DB_Manager().getUserInfos()
            self.expInfos = Experience().getXPInfos(exp: Double(self.userInfos.exp))
            self.xpprogress = CGFloat((Double(expInfos.exp)/Double(expInfos.xpneeded)))
            leaderboard.getUserScores(userID: userid, completion: { result in
                self.userscore = result[0]
            })
            self.usermoney = Int(userInfos.money)
        })
    }
    func flip() {
        let animationTime = 0.5
        withAnimation(Animation.easeOut(duration :animationTime)){
            contentRotation += 180
            flipped.toggle()
        }
    }
}
