//
//  AppLoadingView.swift
//  FitCal
//
//  Created by Mustafa Efe on 15.08.2024.
//

import SwiftUI

struct AppLoadingView: View {
    
    @Binding public var isLoaded: Bool
    
    @State private var isLoading = false
    @State private var progress = 0.1
    @State private var index = 0
    
    let captions = [
        "Vücut bilgileriniz alınıyor...",
        "Vücut kitle endeksiniz hesaplanıyor...",
        "Neredeyse bitti...",
        "İşte oldu"
    ];
    
    var body: some View {
        VStack {
            if isLoaded {
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color(hex: 0x6750A4), lineWidth: 12)
                    .frame(width: 125, height: 125)
            }
            else {
                ZStack {
                    Circle()
                        .stroke(Color(hex: 0xDEE2FF), lineWidth: 12)
                        .frame(width: 125, height: 125)
                        .scaleEffect(CGSize(width: isLoading && !isLoaded ? 0.90: 1.0, height: isLoading && !isLoaded ? 0.90 : 1.0))
                        .animation(.linear(duration: 0.3).delay(0.7).repeatForever(autoreverses: true), value: isLoading)
                        .onAppear() {
                            self.isLoading = true
                        }
                    
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color(hex: 0x6750A4), lineWidth: 12)
                        .frame(width: 125, height: 125)
                        .rotationEffect(Angle(degrees: 270))
                        .scaleEffect(CGSize(width: isLoading && !isLoaded ? 0.90: 1.0, height: isLoading && !isLoaded ? 0.90 : 1.0))
                        .animation(.linear(duration: 0.3).delay(0.7).repeatForever(autoreverses: true), value: isLoading)
                        .onAppear() {
                            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { timer in
                                
                                if self.progress >= 0.9 {
                                    self.progress = 1
                                    self.isLoaded = true
                                    timer.invalidate()
                                } else {
                                    self.progress += 0.1
                                    self.index = Int((self.progress * 100) / 30)
                                }
                            }
                        }
                    
                    Text("%\(Double(progress * 100).formatted())")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Text(self.captions[index])
                    .padding()
                    .padding(.top, 32)
                    .font(.system(.caption, design: .rounded, weight: .black))
                    .foregroundStyle(Color(.systemGray3))
                }
        }
    }
}

#Preview {
    AppLoadingView(isLoaded: .constant(false))
}
