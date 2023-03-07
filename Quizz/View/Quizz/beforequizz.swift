//
//  beforequizz.swift
//  Quizz
//
//  Created by matteo on 21/07/2021.
//

import SwiftUI

struct beforequizz: View {
    
    var body: some View {
        VStack{
            Spacer()
            VStack{
                LottieView(filename: "loader2")
                    .frame(width: 250, height: 250)
            }
            Text("Chargement de votre Quizz...")
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width)
            Spacer()
        }
        .background(Color("lightgrey").ignoresSafeArea())
    }
}

