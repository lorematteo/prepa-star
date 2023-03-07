//
//  settingassis.swift
//  Quizz
//
//  Created by matteo on 30/07/2021.
//

import SwiftUI
import MessageUI

struct settingsselectedgeneralassis: View {
    
    @Binding var showsetting : String
    
    @State private var voirmail = false
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    @State private var resulttype: String = ""
    @State private var name = ""
    @State private var mail = ""
    @State private var sujet = ""
    @State private var message = ""
    @State private var mailbody = ""
    @State private var recipient = ["loremattteo@gmail.com"]
    @State private var statusenvoie = "Envoyer"
    @State private var alertnomail = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Un problème, un bug, une question, une recommandation ? N'hésite pas à me contacter grâce au formulaire ci dessous !")
                .foregroundColor(Color("black"))
                .font(.callout)
            
            Spacer()
            
            VStack{
                HStack(alignment: .top, spacing: 0){
                    Text("Nom")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    VStack(spacing: 0){
                        TextField("Cédric Villani", text: $name)
                            .font(.callout)
                            .foregroundColor(Color("black"))
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        Rectangle()
                            .fill(Color.gray)
                            .opacity(0.5)
                            .frame(height: 1)
                    }
                    .frame(width: UIScreen.main.bounds.width*0.55)
                }
                
                HStack(alignment: .top, spacing: 0){
                    Text("Mail")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    VStack(spacing: 0){
                        TextField("maildeprépa@gmail.com", text: $mail)
                            .keyboardType(.emailAddress)
                            .font(.callout)
                            .foregroundColor(Color("black"))
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        Rectangle()
                            .fill(Color.gray)
                            .opacity(0.5)
                            .frame(height: 1)
                    }
                    .frame(width: UIScreen.main.bounds.width*0.55)
                }
                
                HStack(alignment: .top, spacing: 0){
                    Text("Sujet")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    VStack(spacing: 0){
                        TextField("Report de bug", text: $sujet)
                            .font(.callout)
                            .foregroundColor(Color("black"))
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        Rectangle()
                            .fill(Color.gray)
                            .opacity(0.5)
                            .frame(height: 1)
                    }
                    .frame(width: UIScreen.main.bounds.width*0.55)
                }
                
                HStack(alignment: .top, spacing: 0){
                    Text("Message")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    VStack(spacing: 0){
                        TextView(placeholderText: "Votre message ...", text: $message)
                            .frame(numLines: 5)
                            .font(.callout)
                            .foregroundColor(Color("black"))
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        Rectangle()
                            .fill(Color.gray)
                            .opacity(0.5)
                            .frame(height: 1)
                    }
                    .frame(width: UIScreen.main.bounds.width*0.55)
                }
            }
            .padding(.vertical)
            
            Spacer()
            
            HStack{
                
                VStack{
                    Text("tu préfère instagram ?")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Link("@loremattteo", destination: URL(string: "https://instagram.com/loremattteo")!)
                }
                
                Spacer()
                
                Button(action: {
                    if MFMailComposeViewController.canSendMail() {
                        mailbody = "\(message)\n\(name) : \(mail)"
                        self.voirmail.toggle()
                    } else {
                        self.alertnomail.toggle()
                    }
                }, label: {
                    HStack{
                        Text(statusenvoie)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(7)
                            .padding(.horizontal)
                            .background(statusenvoie == "Envoyer" ? Color("orange") : statusenvoie == "Erreur" ? Color("red") : Color("green"))
                            .clipShape(Capsule())
                    }
                })
            }
            .padding()
        }
        .padding()
        .padding(.top)
        .background(Color("lightgrey"))
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        .alert(isPresented: $alertnomail, content: {
            Alert(title: Text("Aucune application de mail initialisée. Rendez vous dans les Réglages de votre téléphone."))
        })
        .sheet(isPresented: $voirmail) {
            MailComposeViewController(result: self.$result, resulttype: $resulttype, toRecipients: $recipient, subject: $sujet, mailBody: $mailbody){
                if resulttype == "sent"{
                    statusenvoie = "Envoyé !"
                    name = ""
                    mail = ""
                    sujet = ""
                    message = ""
                }
                if resulttype == "saved"{
                    statusenvoie = "Sauvegardé !"
                    name = ""
                    mail = ""
                    sujet = ""
                    message = ""
                }
                else if resulttype == "failed" {
                    statusenvoie = "Erreur"
                }
            }
        }
    }
}


extension UIApplication: UIGestureRecognizerDelegate {

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithotherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        tapGesture.name = "MyTapGesture"
        window.addGestureRecognizer(tapGesture)
    }
}
