//
//  settingcredits.swift
//  Quizz
//
//  Created by matteo on 02/08/2021.
//

import SwiftUI

struct settingcredits: View {
    @Binding var showsetting : String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .top, spacing: 0){
                
                Text("Crédits")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                VStack(alignment: .center, spacing: 20){
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        VStack(spacing: 15){
                            VStack(spacing: 0){
                                Text("Merci à Flaticon")
                                    .font(.subheadline)
                                Text("Pour l'ensemble des icônes de cette application.")
                                    .font(.caption)
                                    .foregroundColor(.black.opacity(0.5))
                                    .multilineTextAlignment(.center)
                                Link("flaticon.com", destination: URL(string: "https://flaticon.com")!)
                                    .font(.caption)
                            }
                            VStack(spacing: 0){
                                Text("Merci à Freepik")
                                    .font(.subheadline)
                                Text("Pour l'ensemble des avatars de cette application.")
                                    .font(.caption)
                                    .foregroundColor(.black.opacity(0.5))
                                    .multilineTextAlignment(.center)
                                Link("freepik.com", destination: URL(string: "https://freepik.com")!)
                                    .font(.caption)
                            }
                            VStack(spacing: 0){
                                Text("Merci à Piqo Design")
                                    .font(.subheadline)
                                Text("Pour leur bibliothèque d'icônes Iconly 2.3 utilisée dans cette application.")
                                    .font(.caption)
                                    .foregroundColor(.black.opacity(0.5))
                                    .multilineTextAlignment(.center)
                                Link("znap.link/piqodesign", destination: URL(string: "https://znap.link/piqodesign/")!)
                                    .font(.caption)
                            }
                            VStack(spacing: 0){
                                Text("Merci à Smashicons")
                                    .font(.subheadline)
                                Text("Pour les différentes images des chapitres ou matières utilisée dans cette application.")
                                    .font(.caption)
                                    .foregroundColor(.black.opacity(0.5))
                                    .multilineTextAlignment(.center)
                                Link("flaticon.com/smashicons", destination: URL(string: "https://flaticon.com/authors/smashicons")!)
                                    .font(.caption)
                            }
                            VStack(spacing: 0){
                                Text("Merci à Kavsoft")
                                    .font(.subheadline)
                                Text("Pour l'inspiration et l'aide à la conception des différentes interfaces de cette application")
                                    .font(.caption)
                                    .foregroundColor(.black.opacity(0.5))
                                    .multilineTextAlignment(.center)
                                Link("kavsoft.dev", destination: URL(string: "https://kavsoft.dev")!)
                                    .font(.caption)
                            }
                        }
                    })
                    
                    
                }
                .frame(width: UIScreen.main.bounds.width*0.55)
            }
            
            Spacer()
            
        }
        .padding()
        .padding(.top)
        .background(Color("lightgrey"))
    }
}

struct settingcredits_Previews: PreviewProvider {
    static var previews: some View {
        settingcredits(showsetting: Binding.constant(""))
    }
}
