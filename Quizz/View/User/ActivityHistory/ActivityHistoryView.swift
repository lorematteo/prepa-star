//
//  ActivityHistoryView.swift
//  Quizz
//
//  Created by matteo on 03/07/2021.
//

import SwiftUI

struct ActivityHistoryView: View {
    
    var sample: Bool = false
    
    @State var selectedIndex: Int = 6
    @State var activitylogs : [ActivityLog] = []
    
    var body: some View {
        VStack(spacing: 20) {
            // Stats
            ActivityHistoryText(logs: activitylogs, selectedIndex: $selectedIndex, sample: sample)
            
            // Graph
            ActivityGraph(logs: activitylogs, selectedIndex: $selectedIndex)
            
        }
        .padding(.horizontal)
        .onAppear(perform: {
            if !sample {
                self.activitylogs = DB_Manager().getActivityALL()
            }
        })
    }
}
