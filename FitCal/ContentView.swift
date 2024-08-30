//
//  ContentView.swift
//  FitCal
//
//  Created by Mustafa Efe on 4.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var showLoadingPage = true
    @State var isLoaded = false
    
    var body: some View {
        VStack {
            if showLoadingPage && !isLoaded {
                AppLoadingView(isLoaded: $isLoaded)
            }
            else {
                Text("Val: \(self.showLoadingPage)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
