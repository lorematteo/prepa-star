//
//  SmallView.swift
//  Quizz
//
//  Created by matteo on 01/07/2021.
//

import SwiftUI

struct JustifyText: UIViewRepresentable {
    var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        textView.textAlignment = .justified
        textView.backgroundColor = UIColor(Color("lightgrey"))
        textView.isEditable = false
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

// custom corner view

struct CustomCorner : Shape {
    
    var corners : UIRectCorner
    var size: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}

struct MultiPicker: View {
    
    typealias Label = String
    typealias Entry = String
    
    let data: [ (Label, [Entry])]
    @Binding var selection: [Entry]
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(0..<self.data.count) { column in
                    Picker(self.data[column].0, selection: self.$selection[column]) {
                        ForEach(0..<self.data[column].1.count) { row in
                            Text(verbatim: self.data[column].1[row])
                                .tag(self.data[column].1[row])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / CGFloat(self.data.count), height: geometry.size.height)
                    .clipped()
                }
            }
        }
    }
}

struct userIcon: View {
    
    @AppStorage("useravatar") var useravatar : String = "baseset1"
    @AppStorage("usercolor") var usercolor : String = "basepalette1"
    
    var size: CGFloat
    var linewidth: CGFloat = 5
    var otheruser: Bool = false
    var otheruseravatar: String = ""
    var othusercolor: String = ""
    
    var body: some View{
        
        if size == 0{
            Circle()
                .fill(otheruser ? Color(othusercolor) : Color(usercolor))
                .overlay(
                    Image(otheruser ? otheruseravatar : useravatar)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, size*0.1)
                        .clipShape(Circle())
                    ,alignment: .center
                )
                .overlay(Circle().stroke(Color(.white), lineWidth: linewidth).shadow(radius: 10))
        } else {
            Circle()
                .fill(otheruser ? Color(othusercolor) : Color(usercolor))
                .frame(width: size, height: size)
                .overlay(
                    Image(otheruser ? otheruseravatar : useravatar)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, size*0.1)
                        .clipShape(Circle())
                    ,alignment: .center
                )
                .overlay(Circle().stroke(Color(.white), lineWidth: linewidth).shadow(radius: 10))
        }
    }
}


struct MoneyIndicator: View{
    
    @Binding var total: Int
    var tiny: Bool = false
    
    var body: some View{
        HStack{
            Image("coin")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: tiny ? 15 : 25, height: tiny ? 15 : 25)
                .padding(tiny ? 2 : 5)
                .padding(.horizontal, tiny ? 7 : 10)
                .background(Capsule().fill(Color("yellow").opacity(0.7)))
            Spacer()
            Text("\(total)")
                .foregroundColor(Color("brown"))
                .fontWeight(.semibold)
                .padding(.trailing)
                .lineLimit(1)
        }
        .frame(width: total > 10000 ? tiny ? 110 : 145 : tiny ? 105 : 135)
        .background(Capsule().fill(Color("whitebutton")))
        .overlay(Capsule().stroke(Color("purple2"), lineWidth: 2))
    }
    
    func addNumberWithRollingAnimation(addvalue: Int, delay: Double = 0) {
        if addvalue != 0{
            DispatchQueue.main.asyncAfter(deadline: .now() + delay){
                
                withAnimation {
                    
                    // Decide on the number of animation steps
                    let animationDuration = 1000 // milliseconds
                    let steps = min(abs(addvalue), 100)
                    let stepDuration = (animationDuration / steps)
                    
                    // add the remainder of our entered num from the steps
                    self.total += addvalue % steps
                    
                    (0..<steps).forEach { step in
                        let updateTimeInterval = DispatchTimeInterval.milliseconds(step * stepDuration)
                        let deadline = DispatchTime.now() + updateTimeInterval
                        DispatchQueue.main.asyncAfter(deadline: deadline) {
                            // Add piece of the entire entered number to our total
                            self.total += Int(addvalue / steps)
                        }
                    }
                }
            }
        }
    }
}

struct ScoreIndicator: View{
    
    @Binding var total: Int
    var tiny: Bool = false
    
    var body: some View{
        HStack{
            Image("crown")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: tiny ? 15 : 25, height: tiny ? 15 : 25)
                .padding(tiny ? 2 : 5)
                .padding(.horizontal, tiny ? 7 : 10)
                .background(Capsule().fill(Color("purered").opacity(0.7)))
            Spacer()
            Text("\(total)")
                .foregroundColor(Color("brown"))
                .fontWeight(.semibold)
                .padding(.trailing)
                .lineLimit(1)
                .redacted(reason: total == -1 ? .placeholder : [])
        }
        .frame(width: total > 10000 ? tiny ? 110 : 145 : tiny ? 105 : 135)
        .background(Capsule().fill(Color("whitebutton")))
        .overlay(Capsule().stroke(Color("purple2"), lineWidth: 2))
    }
    
    func addNumberWithRollingAnimation(addvalue: Int, delay: Double = 0) {
        if addvalue != 0{
            DispatchQueue.main.asyncAfter(deadline: .now() + delay){
                withAnimation {
                    
                    // Decide on the number of animation steps
                    let animationDuration = 1000 // milliseconds
                    let steps = min(abs(addvalue), 100)
                    let stepDuration = (animationDuration / steps)
                    
                    // add the remainder of our entered num from the steps
                    self.total += addvalue % steps
                    
                    (0..<steps).forEach { step in
                        let updateTimeInterval = DispatchTimeInterval.milliseconds(step * stepDuration)
                        let deadline = DispatchTime.now() + updateTimeInterval
                        DispatchQueue.main.asyncAfter(deadline: deadline) {
                            // Add piece of the entire entered number to our total
                            self.total += Int(addvalue / steps)
                        }
                    }
                }
            }
        }
    }
}

struct RatingView: View{
    
    @Binding var rating: Int
    
    var body: some View{
        ZStack{
            starsView
                .overlay(overlayView.mask(starsView))
        }
    }
    
    private var overlayView: some View{
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(Color("yellow"))
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View{
        HStack{
            ForEach(1...5, id:\.self){ index in
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            rating = index
                        }
                    }
            }
        }
    }
}


struct Loader: View{
    let style = StrokeStyle(lineWidth: 4, lineCap: .round)
    @State var animate = false
    let color1 = Color.gray
    let color2 = Color.gray.opacity(0.5)
    
    var body: some View{
        ZStack{
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(
                    AngularGradient(gradient: .init(colors: [color1, color2]), center: .center), style: style)
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
        }
        .onAppear(){
            self.animate.toggle()
        }
    }
}


struct GeometryGetterMod: ViewModifier {
    @Binding var rect: CGRect
    
    func body(content: Content) -> some View {
        print(content)
        return GeometryReader { (g) -> Color in
            DispatchQueue.main.async {
                self.rect = g.frame(in: .global)
            }
            return Color.clear
        }
    }
}
