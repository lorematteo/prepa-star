//
//  ThemeManager.swift
//  Quizz
//
//  Created by matteo on 19/05/2021.
//

import Foundation
import UIKit

class SystemThemeManager {
    
    static let shared = SystemThemeManager()
    private init() {}
    
    func handleTheme(darkMode: Bool){
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = darkMode ? .dark : .light
        
    }
}
