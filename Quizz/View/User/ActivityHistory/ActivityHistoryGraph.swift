//
//  ActivityHistoryGraph.swift
//  Quizz
//
//  Created by matteo on 03/07/2021.
//

import SwiftUI

struct ActivityGraph: View {
    
    var logs: [ActivityLog]
    @Binding var selectedIndex: Int
    
    @State var lineOffset: CGFloat = 8
    @State var selectedXPos: CGFloat = 8
    @State var selectedYPos: CGFloat = 0
    @State var isSelected: Bool = false
    
    init(logs: [ActivityLog], selectedIndex: Binding<Int>) {
        self._selectedIndex = selectedIndex
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "fr_FR")
        let now = formatter.date(from: formatter.string(from: Date())) // Today's Date
        
        var mergedLogs: [ActivityLog] = []

        for i in 0..<7 {

            var weekLog: ActivityLog = ActivityLog()

            for log in logs {
                if log.date.distance(to: Calendar.current.date(byAdding: .day, value: -i,to: now!)!) == 0 {
                    weekLog.daystring = log.daystring
                    weekLog.quizznbr += log.quizznbr
                    weekLog.duration += log.duration
                    weekLog.reussiteperc += log.reussiteperc
                }
            }
            
            if weekLog.quizznbr != 0{
                weekLog.reussiteperc = weekLog.reussiteperc/Double(weekLog.quizznbr)
            }

            mergedLogs.insert(weekLog, at: 0)
        }

        self.logs = mergedLogs
    }
    
    var body: some View {
        drawGrid()
            .background(Color("lightgrey"))
            .opacity(0.2)
            .overlay(drawActivityGradient(logs: logs))
            .overlay(drawActivityLine(logs: logs))
            .overlay(drawLogPoints(logs: logs))
            .overlay(addUserInteraction(logs: logs))
    }
    
    func drawActivityLine(logs: [ActivityLog]) -> some View {
        GeometryReader { geo in
            Path { p in
                let maxNum = logs.reduce(0) { (res, log) -> Int in
                    return max(res, Int(log.quizznbr))
                }
                
                var scale = maxNum == 0 ? 1 : geo.size.height / CGFloat(maxNum)
                
                var index: CGFloat = 0
                
                p.move(to: CGPoint(x: 8, y: geo.size.height - (CGFloat(logs[0].quizznbr) * scale)))
                
                for _ in logs {
                    if index != 0 {
                        p.addLine(to: CGPoint(x: 8 + ((geo.size.width - 16) / 6) * index, y: geo.size.height - (CGFloat(logs[Int(index)].quizznbr) * scale)))
                    }
                    index += 1
                }
            }
            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 80, dash: [], dashPhase: 0))
            .foregroundColor(Color("orange"))
        }
    }
    
    func drawActivityGradient(logs: [ActivityLog]) -> some View {
        LinearGradient(gradient: Gradient(colors: [Color("orange"), Color("lightgrey")]), startPoint: .top, endPoint: .bottom)
            .padding(.horizontal, 8)
            .padding(.bottom, 1)
            .opacity(0.8)
            .mask(
                GeometryReader { geo in
                    Path { p in
                        // Used for scaling graph data
                        let maxNum = logs.reduce(0) { (res, log) -> Int in
                            return max(res, Int(log.quizznbr))
                        }
                        
                        let scale = geo.size.height / CGFloat(maxNum)
                        
                        var index: CGFloat = 0
                        
                        // Move to the starting y-point on graph
                        p.move(to: CGPoint(x: 8, y: geo.size.height - (CGFloat(logs[Int(index)].quizznbr) * scale)))
                        
                        // For each week draw line from previous week
                        for _ in logs {
                            if index != 0 {
                                p.addLine(to: CGPoint(x: 8 + ((geo.size.width - 16) / 6) * index, y: geo.size.height - (CGFloat(logs[Int(index)].quizznbr) * scale)))
                            }
                            index += 1
                        }

                        // Finally close the subpath off by looping around to the beginning point.
                        p.addLine(to: CGPoint(x: 8 + ((geo.size.width - 16) / 6) * (index - 1), y: geo.size.height))
                        p.addLine(to: CGPoint(x: 8, y: geo.size.height))
                        p.closeSubpath()
                    }
                }
            )
    }
    
    func drawLogPoints(logs: [ActivityLog]) -> some View {
        GeometryReader { geo in
            
            let maxNum = logs.reduce(0) { (res, log) -> Int in
                return max(res, Int(log.quizznbr))
            }
            
            var scale = maxNum == 0 ? 1 : geo.size.height / CGFloat(maxNum)
            

            ForEach(logs.indices) { i in
                
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round, miterLimit: 80, dash: [], dashPhase: 0))
                    
                    .frame(width: 10, height: 10, alignment: .center)
                    .foregroundColor(Color("orange"))
                    .background(Color("whitebutton"))
                    .cornerRadius(5)
                    .offset(x: 8 + ((geo.size.width - 16) / 6) * CGFloat(i) - 5, y: (geo.size.height - (CGFloat(logs[i].quizznbr) * scale)) - 5)
            }
        }
    }
    
    func drawGrid() -> some View {
        VStack(spacing: 0) {
            Color("black").frame(height: 1, alignment: .center)
            HStack(spacing: 0) {
                Color.clear
                    .frame(width: 8, height: 100)
                ForEach(0..<6) { i in
                    Color("black").frame(width: 1, height: 100, alignment: .center)
                    Spacer()
                        
                }
                Color("black").frame(width: 1, height: 100, alignment: .center)
                Color.clear
                    .frame(width: 8, height: 100)
            }
            Color("black").frame(height: 1, alignment: .center)
        }
    }
    
    func addUserInteraction(logs: [ActivityLog]) -> some View {
        GeometryReader { geo in
            
            let maxNum = logs.reduce(0) { (res, log) -> Int in
                return max(res, Int(log.quizznbr))
            }
            
            var scale = maxNum == 0 ? 1 : geo.size.height / CGFloat(maxNum)
            
           ZStack(alignment: .leading) {
                // Line and point overlay
                Color("orange")
                    .frame(width: 2)
                    .overlay(
                        Circle()
                            .frame(width: 24, height: 24, alignment: .center)
                            .foregroundColor(Color("orange"))
                            .opacity(0.2)
                            .overlay(
                                Circle()
                                    .fill()
                                    .frame(width: 12, height: 12, alignment: .center)
                                    .foregroundColor(Color("orange"))
                            )
                            .offset(x: 0, y: isSelected ? 12 - (selectedYPos * scale) : 12 - (CGFloat(logs[selectedIndex].quizznbr) * scale))
                        , alignment: .bottom)
                    
                    .offset(x: isSelected ? lineOffset : 8 + ((geo.size.width - 16) / 6) * CGFloat(selectedIndex), y: 0)
                    .animation(Animation.spring().speed(4))
                
                // Drag Gesture Code
                Color("whitebutton").opacity(0.1)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { touch in
                                let xPos = touch.location.x
                                self.isSelected = true
                                let index = (xPos - 8) / (((geo.size.width - 16) / 6))
                                
                                if index > 0 && index < 6 {
                                    let m = (logs[Int(index) + 1].quizznbr - logs[Int(index)].quizznbr)
                                    self.selectedYPos = CGFloat(m) * index.truncatingRemainder(dividingBy: 1) + CGFloat(logs[Int(index)].quizznbr)
                                }
                                
                                
                                if index.truncatingRemainder(dividingBy: 1) >= 0.5 && index < 6{
                                    self.selectedIndex = Int(index) + 1
                                } else {
                                    if index < 0{
                                        self.selectedIndex = 0
                                    } else {
                                        if index > 6{
                                            self.selectedIndex = 6
                                        } else {
                                            self.selectedIndex = Int(index)
                                        }
                                    }
                                }
                                self.selectedXPos = min(max(8, xPos), geo.size.width - 8)
                                self.lineOffset = min(max(8, xPos), geo.size.width - 8)
                            }
                            .onEnded { touch in
                                let xPos = touch.location.x
                                self.isSelected = false
                                let index = (xPos - 8) / (((geo.size.width - 16) / 6))
                                
                                if index.truncatingRemainder(dividingBy: 1) >= 0.5 && index < 6{
                                    self.selectedIndex = Int(index) + 1
                                } else {
                                    if index < 0{
                                        self.selectedIndex = 0
                                    } else {
                                        if index > 6{
                                            self.selectedIndex = 6
                                        } else {
                                            self.selectedIndex = Int(index)
                                        }
                                    }
                                }
                            }
                    )
            }
            
        }
    }
}
