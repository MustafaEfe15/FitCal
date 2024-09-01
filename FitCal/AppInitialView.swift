//
//  AppInitialView.swift
//  FitCal
//
//  Created for gathering body detail from the user such as weight, length, sex etc
//
//  Created by Mustafa Efe on 5.08.2024.
//

import SwiftUI

struct AppInitialView: View {
 
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    // General Properties
    @State var isSurveyBegin = false
    @State var isBeginCalculation = false
    @State var isLoading = false
    @State var stage: Int = 0
    @State var caloriRequirement: Double = 0
    
    // Personal Information
    @State var name = "Mustafa"
    @State var lastname = "Efe"
    @State var gender = "male"
    @State var age: Double = 30
    
    // Body Information
    @State var weight: Double = 84.5
    @State var length: Double = 175
    
    // LifeStyle Information
    @State var lifeStyle = ""

    
    var body: some View {
        VStack {
            if isSurveyBegin {
                VStack {
                    ScrollView {
                         UserFormView(stage: $stage,
                                      name: $name,
                                      lastname: $lastname,
                                      age: $age,
                                      gender: $gender,
                                      weight: $weight,
                                      length: $length,
                                      lifeStyle: $lifeStyle
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
                                    
                                    self.isBeginCalculation = false
                                    self.isLoading = false
                                }) {
                                    RectangleWithIcon(iconName: "arrow.backward", label: "Geri")
                                    }
                            }
                            
                            Button(action: {
                                if stage >= 2 {
                                    self.stage = 2
                                    self.isBeginCalculation = true
                                    self.calculateBodyEndex()
                                }
                                else {
                                    self.stage += 1
                                }
                            }) {
                                if isBeginCalculation {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(height: 50)
                                        .foregroundColor(Color(hex: 0x6750A4, opacity: 1))
                                        .overlay {
                                            HStack {
                                                Circle()
                                                    .trim(from: 0, to: 0.25)
                                                    .stroke(Color(.white), lineWidth: 2)
                                                .frame(width: 25, height: 25)
                                                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                                                .animation(.linear(duration: 0.8).delay(0).repeatForever(autoreverses: false), value: isLoading)
                                                .onAppear() {
                                                    self.isLoading = true
                                                }
                                            }
                                        }
                                }
                                else {
                                    RectangleWithIcon(iconName: "arrow.forward", label: stage == 2 ? "Tamamla" : "Sonraki")
                                    }
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
    
    /** ENDEX FORMUL:
      - WOMAN: 
        655 + 9,6 x ( weight ) + 1,8 x ( length ) - 4,7 x ( age )
      - MAN
        66 + 13,7 x ( weight ) + 5 x ( length ) - 6,8 x ( age )
     */
    func calculateBodyEndex() {
        if gender == "female" {
            self.caloriRequirement = (9.6 * weight) + (1.8 * length) - (4.7 * age) + 655
        }
        else {
            self.caloriRequirement = (13.7 * weight) + (5 * length) - (6.8 * age) + 66
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                self.isBeginCalculation = false
                self.isLoading = false
                
                self.userInfoStore.name = self.name + self.lastname
                self.userInfoStore.age = Int(self.age)
                self.userInfoStore.gender = GenderType(type: self.gender)
                self.userInfoStore.weight = self.weight
                self.userInfoStore.length = self.length
                self.userInfoStore.lifeStyle = LifeStyleType(type: self.lifeStyle)
                self.userInfoStore.caloriRequirement = caloriRequirement * userInfoStore.lifeStyle.caloriFactor
                self.userInfoStore.isActive = true
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
