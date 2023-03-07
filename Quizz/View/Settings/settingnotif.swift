//
//  settingnotif.swift
//  Quizz
//
//  Created by matteo on 30/07/2021.
//

import SwiftUI
import UserNotifications

struct settingsselectedgeneralnotif: View {
    
    @AppStorage("notifEnabled") var notifEnabled : Bool = false
    @AppStorage("rappelTime") var rappelTime: String = ""
    @AppStorage("rappelFrequency") var rappelFrequency: String = ""
    
    @Binding var showsetting : String
    
    @State var notiftime : Date = Date()
    @State var notifrepetition : String = "jours"
    @State var alertactivenotif : Bool = false
    @State var notifsaved : Bool = false
    
    var body: some View {
        
//        Notifications
        let toggle = Binding<Bool> (
            get: { self.notifEnabled},
            set: { newValue in
                self.notifEnabled = newValue
                notifsaved = false
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
                    success, error in
                    if success {
                        if !self.notifEnabled {
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                        }
                    } else if self.notifEnabled {
                        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                        DispatchQueue.main.async {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            if !UIApplication.shared.isRegisteredForRemoteNotifications {
                                self.notifEnabled = false
                            } else {
                                self.notifEnabled = true
                            }
                        }
                    }
                }
                })
        
        
        VStack(alignment: .leading) {
            
            VStack{
                Text("La régularité est la clé d'une année réussie ! D'après une étude, 99.99% des personnes qui active les notifs sont admissibles.")
                    .foregroundColor(Color("black"))
                    .font(.callout)
                
                HStack(spacing: 0){
                    Text("Notifications")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Toggle(isOn:toggle, label: {
                        Text(notifEnabled ? "On" : "Off")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    })
                    .toggleStyle(SwitchToggleStyle(tint: Color("purple4")))
                }
            }
            .padding(.bottom)
            
            VStack(alignment: .leading){
                
                Text("Définir un rappel :")
                    .foregroundColor(Color("brown"))
                    .padding(.leading)
                    .onTapGesture {
                        let center = UNUserNotificationCenter.current()
                        center.getPendingNotificationRequests { requests in
                            for request in requests{
                                print(request)
                            }
                        }
                    }
                
                HStack(spacing: 0){
                    Text("Heure")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    DatePicker("", selection: $notiftime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                HStack(spacing: 0){
                    Text("Tout les")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Picker("", selection: $notifrepetition) {
                        let data = ["jours", "2 jours", "3 jours"]
                        ForEach(data, id: \.self) { element in
                            Text("\(element)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .cornerRadius(5)
                }
                
                HStack{
                    Button(action: {
                        rappelTime = ""
                        rappelFrequency = ""
                        notifsaved = false
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    }, label: {
                        Image(systemName: "trash.circle.fill")
                            .foregroundColor(.red)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                    })
                    
                    Text("rappel activé tout les \(rappelFrequency) à \(rappelTime)")
                        .foregroundColor(.gray)
                        .font(.callout)
                    
                    Spacer()
                }
                .opacity(rappelTime == "" ? 0 : 1)
                .animation(.spring())
            }
            .padding(.top)
            
            Spacer()
            
            HStack(spacing: 0){
                
                Text("Il faut activer les notifications pour définir un rappel.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .opacity(alertactivenotif ? 1 : 0).animation(.spring())
                
                Spacer()
                
                Button(action: {
                    if notifEnabled {
                        alertactivenotif = false
                        let formatter = DateFormatter()
                        formatter.dateFormat = "HH:mm"
                        if notifrepetition == "jours" {
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                            let time = Calendar.current.dateComponents([.hour, .minute], from: notiftime)
                            sendNotif(title: "IL EST L'HEURE DE RÉVISER ! \u{1F4DD}", body: "Viens tester tes connaisances et t'assurer que tu maîtrise le cours, objectif concours réussit. \u{1F4AA}", time: time, repeats: true)
                            rappelTime = formatter.string(from: notiftime)
                            rappelFrequency = "jours"
                        } else if notifrepetition == "2 jours" {
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                            for numero in [1, 2, 4, 6]{
                                let time = DateComponents(hour: Calendar.current.component(.hour, from: notiftime), minute: Calendar.current.component(.minute, from: notiftime), weekday: numero)
                                sendNotif(title: "IL EST L'HEURE DE RÉVISER ! \u{1F4DD}", body: "Viens tester tes connaisances et t'assurer que tu maîtrise le cours, objectif concours réussit. \u{1F4AA}", time: time, repeats: true)
                            }
                            rappelTime = formatter.string(from: notiftime)
                            rappelFrequency = "2 jours"
                        } else if notifrepetition == "3 jours" {
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                            for numero in [1, 2, 5]{
                                let time = DateComponents(hour: Calendar.current.component(.hour, from: notiftime), minute: Calendar.current.component(.minute, from: notiftime), weekday: numero)
                                sendNotif(title: "IL EST L'HEURE DE RÉVISER ! \u{1F4DD}", body: "Viens tester tes connaisances et t'assurer que tu maîtrise le cours, objectif concours réussit. \u{1F4AA}", time: time, repeats: true)
                            }
                            rappelTime = formatter.string(from: notiftime)
                            rappelFrequency = "3 jours"
                        }
                        notifsaved = true
                    }
                    else {
                        alertactivenotif = true
                    }
                }, label: {
                    Text(notifsaved ? "Validé !" : "Valider")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(7)
                        .padding(.horizontal)
                        .background(notifsaved ? Color("green") : Color("orange"))
                        .clipShape(Capsule())
                })
            }
            .padding()
        }
        .padding()
        .padding(.top)
        .background(Color("lightgrey"))
    }
    
    func sendNotif(title: String, body: String, time: DateComponents, repeats: Bool) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: repeats)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request){ (error) in
            if error != nil{
                print(error?.localizedDescription ?? "error adding notification")
            }
        }
    }
}
