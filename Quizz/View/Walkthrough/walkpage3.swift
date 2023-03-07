//
//  walkpage3.swift
//  Quizz
//
//  Created by matteo on 26/07/2021.
//

import SwiftUI
import MessageUI

struct walkpage3: View {
    
    @State var alertnomail: Bool = false
    @State var voirmail: Bool = false
    
    var body: some View{
        VStack{
            Spacer()
            ZStack(){
                VStack(alignment: .leading, spacing: 15){
                    Text("Hello !")
                        .foregroundColor(Color("purple1"))
                        .fontWeight(.bold)
                        .font(.title)
                    Text("Je m'appelle Mattéo, PrépaStar est une petite application dont je suis l'unique dévellopeur. Étant en prépa, je n'ai pas énormément de temps libre, donc si tu veux aider pour :")
                        .font(.body)
                        .foregroundColor(.black.opacity(0.6))
                    VStack(alignment: .leading, spacing: 3){
                        HStack{
                            Circle()
                                .fill(Color.black.opacity(0.6))
                                .frame(width: 7, height: 7)
                            Text("rédiger des quizzs")
                                .font(.body)
                                .foregroundColor(.black.opacity(0.6))
                        }
                        HStack{
                            Circle()
                                .fill(Color.black.opacity(0.6))
                                .frame(width: 7, height: 7)
                            Text("dévelloper sous iOS ou Android")
                                .font(.body)
                                .foregroundColor(.black.opacity(0.6))
                        }
                        HStack{
                            Circle()
                                .fill(Color.black.opacity(0.6))
                                .frame(width: 7, height: 7)
                            Text("simplement faire partie du projet")
                                .font(.body)
                                .foregroundColor(.black.opacity(0.6))
                        }
                    }
                    Text("N'hésite pas à prendre contact !")
                        .font(.body)
                        .foregroundColor(.black.opacity(0.6))
                    HStack{
                        Link("@loremattteo", destination: URL(string: "https://instagram.com/loremattteo")!)
                        Button(action: {
                            if MFMailComposeViewController.canSendMail() {
                                self.voirmail.toggle()
                            } else {
                                self.alertnomail.toggle()
                            }
                        }, label: {
                            Text("loremattteo@gmail.com")
                        })
                    }
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width*0.9)
                .background(Color("lightgrey"))
                .cornerRadius(15)
            
            }
            .frame(width: UIScreen.main.bounds.width)
            .overlay(
                ZStack{
                    Circle()
                        .fill(Color("purple3").opacity(0.5))
                        .frame(width: UIScreen.main.bounds.width*0.4, height: UIScreen.main.bounds.width*0.4)
                    Image("memoji")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width*0.4, height: UIScreen.main.bounds.width*0.4)
                }
                .overlay(Circle().stroke(Color("white"), lineWidth: 5).shadow(radius: 10))
                .background(Color("lightgrey").clipShape(Circle()).clipped().shadow(color: .black.opacity(0.3), radius: 10, x: 0.0, y: 0.0))
                .offset(y: -UIScreen.main.bounds.width*0.5/2)
                .padding(.trailing, UIScreen.main.bounds.width*0.15)
                , alignment: .topTrailing
            )
            Spacer()
        }
        .background(Color("purple1").ignoresSafeArea(edges: .all))
        .alert(isPresented: $alertnomail, content: {
            Alert(title: Text("Aucune application de mail initialisée. Rendez vous dans les Réglages de votre téléphone."))
        })
        .sheet(isPresented: $voirmail) {
            MailComposeViewController(result: Binding.constant(nil), resulttype: Binding.constant(""), toRecipients: Binding.constant(["loremattteo@gmail.com"]), subject: Binding.constant(""), mailBody: Binding.constant("")){}
        }
        
    }
}
