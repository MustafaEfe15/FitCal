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
    
    @State var isSurveyBegin = false
    @State var questionNumber = 0
    
    @State var name = ""
    @State var lastname = ""
    @State var gender = ""
    @State var age: Double = 25
    @State var muscleIntense: String?
    @State var weight: Double = 50
    @State var length: Double = 50
    @State var stage: Int = 0
    @State var lifeStyle = ""
    
    var body: some View {
        VStack {
            if isSurveyBegin {
                VStack {
                    ScrollView {
                        UserFormView2(name: $name,
                                      lastname: $lastname,
                                      age: $age,
                                      gender: $gender,
                                      muscleIntense: $muscleIntense,
                                      weight: $weight,
                                      length: $length,
                                      lifeStyle: $lifeStyle,
                                      stage: $stage
                        )
                    }
                    
                    VStack {
                        HStack(alignment: .center) {
                            if(stage > 0) {
                                Button(action: {
                                    if stage == 0 { self.stage = 0 }
                                    else {
                                        self.stage -= 1
                                    }
                                }) {
                                    RectangleWithIcon(iconName: "arrow.backward", label: "Geri")
                                    }
                            }
                            
                            Button(action: {
                                if stage >= 2 { self.stage = 2 }
                                else {
                                    self.stage += 1
                                }
                            }) {
                                RectangleWithIcon(iconName: "arrow.forward", label: stage == 2 ? "Tamamla" : "Sonraki")
                                }
                        }
                        .padding(.horizontal)
                    }
                }
                .frame(alignment: .bottom)
            }
            else {
                StarterView(isSurveyBegin: $isSurveyBegin)
            }
        }
    }
}

#Preview {
    AppInitialView()
}

struct StarterView: View {
    @State var repating = false
    @Binding var isSurveyBegin: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Image("confessional")
                .resizable()
                .frame(width: 250, height: 250)
                .cornerRadius(125)
            
            Text("FitCal'a Hoşgeldin")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding(.top, 20)
                .padding(.bottom, 5)
            
            Text("Sağlıklı öğünlerini birlikte oluşturalım")
                .font(.body)
                .bold()
                .foregroundColor(.secondary)
         
            Button(action: {
                self.isSurveyBegin.toggle()
            }) {
                RoundedRectangle(cornerRadius: 15)
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
        }
    }
}

struct RectangleWithIcon: View {
    
    var iconName = ""
    var label = ""
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(height: 50)
            .foregroundColor(Color(hex: 0x6750A4, opacity: 1))
            .overlay {
                HStack {
                    if label == "Geri" {
                        Image(systemName: iconName)
                            .foregroundStyle(.white)
                            .bold()
                    }
                    
                    Text(label)
                        .foregroundStyle(.white)
                        .bold()
                    
                    if label != "Geri" {
                        Image(systemName: iconName)
                            .foregroundStyle(.white)
                            .bold()
                    }
                }
            }
    }
}
