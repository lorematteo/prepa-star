//
//  walkpage1.swift
//  Quizz
//
//  Created by matteo on 26/07/2021.
//

import SwiftUI

struct walkpage1: View {
    var body: some View {
        VStack{
            Spacer()
            
            Text("Bienvenue sur PrépaStar !")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color(.white))
                .padding()
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color("purple1").ignoresSafeArea(edges: .all))
    }
}
