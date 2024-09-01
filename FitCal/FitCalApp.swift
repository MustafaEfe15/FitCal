//
//  FitCalApp.swift
//  FitCal
//
//  Created by Mustafa Efe on 4.08.2024.
//

import SwiftUI

@main
struct FitCalApp: App {
    
    var userInfoStore = UserInfoStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(self.userInfoStore)
        }
    }
}
