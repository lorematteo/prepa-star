//
//  SwiftUIView.swift
//  Quizz
//
//  Created by matteo on 12/07/2021.
//

import SwiftUI

struct leadercard: View {
    
    var index: Int
    var user: dbuser
    var general: Bool
    var scoretype: String
    
    var selfcard: Bool = false
    var sample: Bool = false
    
    var body: some View {
        
        HStack(spacing: sample ? 3 : 7){
            
            if index < 10{
                Text(String(index))
                    .foregroundColor(selfcard ? Color(.white) : Color("brown"))
                    .font(sample ? .callout : .title3)
                    .fontWeight(.regular)
                    .padding(.trailing, sample ? 5 : 10)
                    .unredacted()
            } else {
                Text("0")
                    .foregroundColor(selfcard ? Color(.white) : Color("brown"))
                    .font(sample ? .callout : .title3)
                    .fontWeight(.regular)
                    .padding(.trailing, sample ? 5 : 10)
                    .unredacted()
                    .opacity(0)
            }
            
            userIcon(size: 0, linewidth: 3, otheruser: true, otheruseravatar: user.icon, othusercolor: user.color)
                .aspectRatio(contentMode: .fit)
                .padding(.trailing, sample ? 2 : 5)
            if general{
                Text(user.filiere)
                    .font( sample ? .caption : .subheadline)
                    .foregroundColor(selfcard ? Color(.white) : Color("brown"))
                    .fontWeight(sample ? .regular : .medium)
                
                if sample{
                    Rectangle()
                        .fill(selfcard ? Color(.white).opacity(0.3) : Color("black").opacity(0.3))
                        .frame(width: 1)
                        .padding(.vertical, 5)
                } else {
                    Rectangle()
                        .fill(selfcard ? Color(.white).opacity(0.3) : Color("black").opacity(0.3))
                        .frame(width: 1)
                        .padding(.vertical)
                }
            }
            
            Text(user.name)
                .font( sample ? .caption : .headline)
                .foregroundColor(selfcard ? Color(.white) : Color("brown"))
                .fontWeight(sample ? .regular : .medium)
                .lineLimit(1)
            
            Spacer()
            
            Text(scoretype == "weekly" ? String(user.weeklyscore) : scoretype == "bimonthly" ? String(user.bimonthlyscore) : String(user.monthlyscore))
                .font(sample ? .headline : .title2)
                .foregroundColor(selfcard ? Color(.white) : Color("brown"))
                .fontWeight(.thin)
        }
        .padding(.vertical, 7)
        .padding(.horizontal)
        .frame(width: sample ? UIScreen.main.bounds.width*0.6 : UIScreen.main.bounds.width*0.9, height: sample ? UIScreen.main.bounds.width*0.125 : UIScreen.main.bounds.width*0.2)
        .background(selfcard ? Color("purple1").opacity(0.8) : Color("purple3").opacity(0.1))
        .cornerRadius(10)
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        leadercard(index: 1, user: User(name: "loremattteo", score: 423), sample: true)
//    }
//}
