//
//  TestView.swift
//  Quizz
//
//  Created by matteo on 06/07/2021.
//

import SwiftUI

struct TestView: View {
    
    let countries = ["Afghanistan", "Saint Rémi", "Germany", "Anglettere", "Australie"]
    @State private var searchString = ""
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View{
        
        VStack{
            
            HStack{
                
                Image("thinarrowleft")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                
                Spacer()
            }
            
            searchbar(searchText: $searchString)
            
            List(){
                ForEach(searchString == "" ? countries: countries.filter { $0.contains(searchString)}, id: \.self){ country in
                    Text(country)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .padding(.top, -15)
        }
        .padding()
        .frame(height: UIScreen.main.bounds.width*1)
        .background(Color("lightgrey").cornerRadius(15))
        .padding()
        
    }
}
        

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

