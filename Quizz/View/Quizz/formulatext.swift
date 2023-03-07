//
//  formulatext.swift
//  Quizz
//
//  Created by matteo on 02/08/2021.
//

import SwiftUI
import iosMath

struct mathtext: UIViewRepresentable{
    
    var text: String
    var color: Color
    
    func makeUIView(context: Context) -> MTMathUILabel {
        let mathtext = MTMathUILabel()
        mathtext.labelMode = .text
        mathtext.latex = text
        mathtext.textColor = UIColor(color)
        mathtext.textAlignment = .center
        mathtext.sizeToFit()
        return mathtext
    }
    
    func updateUIView(_ uiView: MTMathUILabel, context: Context) {
        uiView.latex = text
        uiView.textColor = UIColor(color)
        uiView.textAlignment = .center
        uiView.sizeToFit()
    }
}

struct formulatext: View {
    
    var text: String
    var width: CGFloat
    var color: Color = Color.black
    var font: Font = .body
    
    var body: some View {
        
        if width == 0{
            VStack(alignment: .center){
                
                let lines = text.components(separatedBy:  "[math]")
                ForEach(lines, id:\.self){ line in
                    if line.contains("[/math]"){
                        let comp = line.components(separatedBy: "[/math]")
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                Spacer()
                                mathtext(text: comp[0], color: color)
                                Spacer()
                            }
                            .padding(.vertical, 5)
                        }
                        Text(comp[1])
                            .foregroundColor(color)
                            .font(font)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text(line)
                            .foregroundColor(color)
                            .font(font)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        } else {
            VStack(alignment: .center, spacing: 0){
                
                let lines = text.components(separatedBy:  "[math]")
                ForEach(lines, id:\.self){ line in
                    if line.contains("[/math]"){
                        let comp = line.components(separatedBy: "[/math]")
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                Spacer()
                                mathtext(text: comp[0], color: color)
                                Spacer()
                            }
                            .padding(.vertical, 5)
                            .frame(minWidth: width)
                        }
                        Text(comp[1])
                            .foregroundColor(color)
                            .font(font)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text(line)
                            .foregroundColor(color)
                            .font(font)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .frame(width: width)
        }
    }
}
