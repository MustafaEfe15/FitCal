//
//  ContentView.swift
//  FitCal
//
//  Created by Mustafa Efe on 4.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    var body: some View {
        if userInfoStore.isActive {
            TableView()
            Button(action: {
                self.doPassive()
            }) { Text("Reset") }
        }
        else {
            AppInitialView().environmentObject(userInfoStore)
        }
        
    }
        
    
    func doPassive() {
        self.userInfoStore.isActive = false
    }
}

#Preview {
    ContentView().environmentObject(UserInfoStore())
}
