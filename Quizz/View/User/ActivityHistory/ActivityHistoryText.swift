//
//  ActivityHistoryText.swift
//  Quizz
//
//  Created by matteo on 03/07/2021.
//

import SwiftUI

struct ActivityHistoryText: View {
    
    var sample: Bool
    var logs: [ActivityLog] = [ActivityLog(),ActivityLog(),ActivityLog(),ActivityLog(),ActivityLog(),ActivityLog(),ActivityLog()]
    var successMax: Int
    
    @Binding var selectedIndex: Int
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter
    }
    
    init(logs: [ActivityLog], selectedIndex: Binding<Int>, sample: Bool) {
        self._selectedIndex = selectedIndex
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
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

            mergedLogs.append(weekLog)
        }

        self.logs = mergedLogs
        self.successMax = Int(mergedLogs.max(by: { $0.reussiteperc < $1.reussiteperc})?.reussiteperc ?? 0)
        self.sample = sample
    }

    
    var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                
                VStack(alignment: .leading){
                    Text("CETTE SEMAINE")
                        .font(Font.headline.weight(.heavy))
                        .foregroundColor(Color("black").opacity(0.7))
                    Text("Suit tes révisions de la semaine précédente.")
                        .font(.caption)
                        .foregroundColor(Color("black").opacity(0.5))
                }
                .padding(.bottom, 5)
                
                VStack(alignment: .leading, spacing: 5){
                    Text("\(dateFormatter.string(from: Date().addingTimeInterval(-604800))) - \(dateFormatter.string(from: Date()))".uppercased())
                        .font(Font.caption.weight(.heavy))
                        .foregroundColor(Color("black"))
                    
                    HStack(spacing: sample ? 6 : 10) {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Jour")
                                .font(.caption)
                                .foregroundColor(Color("black").opacity(0.5))
                            Text(String(logs[6-selectedIndex].daystring ))
                                .font(Font.system(size: sample ? 15 : 20, weight: .medium, design: .default))
                                .foregroundColor(Color("black"))
                        }
                        
                        Color.gray
                            .opacity(0.5)
                            .frame(width: 1, height: 30, alignment: .center)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Quizz")
                                .font(.caption)
                                .foregroundColor(Color("black").opacity(0.5))
                            Text(String(logs[6-selectedIndex].quizznbr))
                                .font(Font.system(size: sample ? 15 : 20, weight: .medium, design: .default))
                                .foregroundColor(Color("black"))
                        }
                        
                        Color.gray
                            .opacity(0.5)
                            .frame(width: 1, height: 30, alignment: .center)
                            
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Temps")
                                .font(.caption)
                                .foregroundColor(Color("black").opacity(0.5))
                            Text(String(format: "%.0fh", logs[6-selectedIndex].duration / 3600) + String(format: " %.0fm", ceil(logs[6-selectedIndex].duration.truncatingRemainder(dividingBy: 3600) / 60)))
                                .font(Font.system(size: sample ? 15 : 20, weight: .medium, design: .default))
                                .foregroundColor(Color("black"))
                        }
                        
                        Color.gray
                            .opacity(0.5)
                            .frame(width: 1, height: 30, alignment: .center)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Réussite")
                                .font(.caption)
                                .foregroundColor(Color("black").opacity(0.5))
                            Text("\(String(format: "%.1f", logs[6-selectedIndex].reussiteperc))%")
                                .font(Font.system(size: sample ? 15 : 20, weight: .medium, design: .default))
                                .foregroundColor(Color("black"))
                        }
                        
                        Spacer()
                    }
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("7 DERNIERS JOURS")
                        .font(Font.caption.weight(.heavy))
                        .foregroundColor(Color("black").opacity(0.7))
                    Text("meilleure réussite de \(successMax)%")
                        .font(Font.caption)
                        .foregroundColor(Color("black").opacity(0.5))
                }
                .padding(.top, 5)
                
                
            }
    }
}


extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
