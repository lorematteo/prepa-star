//
//  FiliereMenu.swift
//  Quizz
//
//  Created by matteo on 11/07/2021.
//

import SwiftUI

struct FiliereMenu: View {
    
    @AppStorage("userannee") var userannee: Int = 0
    
    @Binding var selected : Filiere
    @Binding var matieres: [Matiere]
    
    @State var filieres: [Filiere]
    
    init(selected: Binding<Filiere>, matieres: Binding<[Matiere]>){
        self._selected = selected
        self._matieres = matieres
        self.filieres = DB_Manager().getFilieres()
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 0){
                
                ForEach(filieres.indices,id: \.self){index in
                    
                    Button(action: {withAnimation(.spring()){selected = filieres[index]; self.matieres = DB_Manager().getMatieres(filiereValue: selected.name)}}, label: {
                        Text(userannee == 1 ? filieres[index].sousfiliere : filieres[index].name)
                            .font(.system(size: 15))
                            .fontWeight(selected.name == filieres[index].name ? .bold : .none)
                            .foregroundColor(selected.name == filieres[index].name ? .white : Color.white.opacity(0.7))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color("menufilierecolor").opacity(selected.name == filieres[index].name ? 1 : 0))
                            .cornerRadius(10)
                    })
                    
                    // giving space for all except for last...
                    
                    if filieres[index].name != filieres.last!.name{
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding()
        }
    }
}
