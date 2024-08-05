//
//  AppInitialView.swift
//  FitCal
//
//  Created for gathering body detail from the user such as weight, length, sex etc
//
//  Created by Mustafa Efe on 5.08.2024.
//

import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

struct AppInitialView: View {
    
    @State var repating = false
    
    var body: some View {
        VStack {
            Image("confessional")
                .resizable()
                .frame(width: 250, height: 250)
                .cornerRadius(125)
            
            Text("FitCal'a Hoşgeldin")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding(.top, 20)
            
            Text("Hadi seni tanıyalım")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .padding(.top, 20)
            
            Button(action: {
                
            }) {
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 50)
                    .foregroundColor(Color(hex: 0x6750A4, opacity: 1))
                    .padding()
                    .overlay {
                        HStack {
                            Text("Başlayalım")
                                .foregroundStyle(.white)
                                .bold()
                            
                            Image(systemName: "arrow.forward")
                                .foregroundStyle(.white)
                                .bold()
                                .scaleEffect(self.repating ? 0.95 : 1)
                                .offset(x: repating ? 0 : 15, y: 0)
                                .animation(.linear(duration: 0.5).repeatForever(), value: repating)
                                .onAppear() {
                                    self.repating = true
                                }
                        }
                    }
            }
            .padding(.top, 50)
        }
    }
}

#Preview {
    AppInitialView()
}
