//
//  settingselectedcompte.swift
//  Quizz
//
//  Created by matteo on 24/06/2021.
//

import SwiftUI
import MessageUI

struct settingacc: View {
    
    @AppStorage("userid") var userid: String = ""
    @AppStorage("username") var username: String = ""
    @AppStorage("userfiliere") var userfiliere: String = ""
    @AppStorage("usersousfiliere") var usersousfiliere: String = ""
    @AppStorage("userannee") var userannee: Int = 0
    @AppStorage("profilupdate") var profilupdate: Int = 1
    
    @Binding var showsetting : String
    @Binding var customprofil: String
    
    @State var newusername: String = ""
    @State var newfiliere: String = ""
    @State var newsousfiliere: String = ""
    @State var newannee: Int = 0
    
    @State var alertnomail: Bool = false
    @State var voirmail: Bool = false
    
    @State var handler: String = ""
    @State var usernameavailable: Bool = false
    @State var validusername: Bool = false
    @State var showalert: Bool = false
    @State var commited: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            HStack(alignment: .top, spacing: 0){
                Text("Profil")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                userIcon(size: 100)
                
                Spacer()
            }
            
            HStack(spacing: 0){
                Text("Pseudo")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                VStack(spacing: 0){
                    
                    TextField(newusername == "" ? username : newusername, text: $newusername, onCommit: {
                        newusername = newusername.removeWhiteSpaces()
                        if newusername.count <= 10 && newusername.count > 2{
                            Leaderboard().checkUsernameAvailability(username: newusername) { available in
                                usernameavailable = available
                                if available{ validusername = true } else{ validusername = false}
                            }
                            commited = true
                        }
                    })
                    .keyboardType(.asciiCapable)
                    .disableAutocorrection(true)
                    .font(.title3)
                    .foregroundColor(Color("black"))
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .frame(width: UIScreen.main.bounds.width*0.65, alignment: .leading)
                    .padding(.trailing, 5)
                    .onTapGesture {
                        commited = false
                    }
                    
                    Rectangle()
                        .fill(Color.gray)
                        .opacity(0.5)
                        .frame(width: UIScreen.main.bounds.width*0.65, height: 1)
                }
                
            }
            
            HStack(spacing: 0){
                Text("Filière")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                VStack(spacing: 0){
                    
                    Menu{
                        let filieres = DB_Manager().getFilieres()
                        ForEach(filieres.indices, id:\.self){ index in
                            Button(filieres[index].name, action: {newfiliere = filieres[index].name; newsousfiliere = filieres[index].sousfiliere; newannee = 2})
                            Button(filieres[index].sousfiliere, action: {newfiliere = filieres[index].sousfiliere; newsousfiliere = filieres[index].name; newannee = 1})
                        }
                    } label: {
                        Text(newfiliere == "" ? userfiliere : newfiliere)
                            .font(.title3)
                            .foregroundColor(newfiliere == "" ? Color.gray : Color("black"))
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .frame(width: UIScreen.main.bounds.width*0.65, alignment: .leading)
                            .padding(.trailing, 5)
                    }

                    Rectangle()
                        .fill(Color.gray)
                        .opacity(0.5)
                        .frame(width: UIScreen.main.bounds.width*0.65, height: 1)
                }
                
            }
            
            HStack{
                Spacer()
                VStack(spacing: 0){
                    Text(newusername == "" ? "" : newusername.count < 3 ? "pseudo trop court" : newusername.count > 10 ? "pseudo trop long" : "")
                        .foregroundColor(.gray)
                        .font(.caption)
                    Text(usernameavailable ? "" : "pseudo indisponible")
                        .foregroundColor(.gray)
                        .font(.caption)
                        .opacity(commited ? 1 : 0)
                }
                .frame(width: UIScreen.main.bounds.width*0.65, alignment: .leading)
            }
            
            Spacer()
            
            HStack{
                Spacer()
                
                Button(action: {
                    if profilupdate > 0{
                        if newusername != "" || newfiliere != ""{
                            if validusername{
                                if newusername != ""{
                                    if newusername.count > 2 && newusername.count < 11{
                                        showalert = true
                                    }
                                }
                            }
                            if newfiliere != "" && newusername == ""{
                                showalert = true
                            }
                        }
                    }
                    
                }, label: {
                    Text(handler == "" ? "Valider" : handler == "done" ? "Validé !" : "Erreur")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(7)
                        .padding(.horizontal)
                        .background(Color(handler == "" ? "orange" : handler == "done" ? "green" : "red"))
                        .clipShape(Capsule())
                        .opacity(!(validusername || newfiliere != "") || profilupdate == 0 ? 0.6 : 1)
                })
                .disabled(!(validusername || newfiliere != "") || profilupdate == 0)
            }
            .padding(.bottom)
            .padding(.trailing)
            
            Text("\(Text("Attention").fontWeight(.semibold)) tu ne peut changer qu'\(Text("une seule fois").fontWeight(.semibold)) ! Pour tout changement supplémentaire, contacte moi par mail ou instagram. Je m'en occuperais si t'es gentil/ille :)")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 5)
            
            HStack{
                Spacer()
                Link("@loremattteo", destination: URL(string: "https://instagram.com/loremattteo")!)
                Spacer()
                Button(action: {
                    if MFMailComposeViewController.canSendMail() {
                        self.voirmail.toggle()
                    } else {
                        self.alertnomail.toggle()
                    }
                }, label: {
                    Text("loremattteo@gmail.com")
                })
                .alert(isPresented: $alertnomail, content: {
                    Alert(title: Text("Aucune application de mail initialisée. Rendez vous dans les Réglages de votre téléphone."))
                })
                Spacer()
            }
            .padding(.bottom)
        }
        .padding()
        .ignoresSafeArea(.keyboard)
        .frame(width: UIScreen.main.bounds.width)
        .padding(.top)
        .background(Color("lightgrey"))
        .alert(isPresented: $showalert){
            Alert(
                title: Text("Est-tu sûr ?"),
                message: Text("Tu ne peut actualiser tes informations qu'une seule fois, est tu certain d'effectuer les changements suivant ?\nPSEUDO : \(newusername == "" ? username : newusername)\nFILIÈRE : \(newfiliere == "" ? userfiliere : newfiliere)"),
                primaryButton: .cancel(Text("Non")),
                secondaryButton: .default(Text("Oui"), action: {
                    Leaderboard().updateUser(userID: userid, newusername: newusername == "" ? username : newusername, newfiliere: newfiliere == "" ? userfiliere : newfiliere) { done in
                        if done{
                            username = newusername == "" ? username : newusername
                            userfiliere = newfiliere == "" ? userfiliere : newfiliere
                            usersousfiliere = newsousfiliere == "" ? usersousfiliere : newsousfiliere
                            userannee = newfiliere == "" ? userannee : newannee
                            profilupdate = 0
                            handler = "done"
                        } else {
                            handler = "error"
                        }
                    }
                })
            )
        }
        .sheet(isPresented: $voirmail) {
            MailComposeViewController(result: Binding.constant(nil), resulttype: Binding.constant(""), toRecipients: Binding.constant(["loremattteo@gmail.com"]), subject: Binding.constant(""), mailBody: Binding.constant("")){}
        }
    }
}
