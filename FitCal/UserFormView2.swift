//
//  UserFormView2.swift
//  FitCal
//
//  Created by Mustafa Efe on 9.08.2024.
//

import SwiftUI

protocol CustomSelectListProtocol {
    var rawData: String {get}
    var text: String {get}
    var helpText: String? {get}
}

enum GenderType: String, CaseIterable, CustomSelectListProtocol {
    case woman = "female"
    case man = "male"
    
    /*init(type: String) {
        switch type {
        case "female": self = .woman
        case "male: self = .man
        }
    }*/
    
    var rawData: String {
        self.rawValue
    }
    
    var text: String {
        switch self {
        case .woman: "Kadın"
        case .man: "Erkek"
        }
    }
    
    var helpText: String? {
        nil
    }
}

enum LifeStyleType: String, CaseIterable, CustomSelectListProtocol {
    case lf_segment1 = "lf_segment1"
    case lf_segment2 = "lf_segment2"
    case lf_segment3 = "lf_segment3"
    case lf_segment4 = "lf_segment4"
    case lf_segment5 = "lf_segment5"
    
    var rawData: String {
        self.rawValue
    }
    
    var text: String {
        switch self {
        case .lf_segment1: return "Sedanter"
        case .lf_segment2: return "Az hareketli"
        case .lf_segment3: return "Orta derece hareketli"
        case .lf_segment4: return "Çok hareketli"
        case .lf_segment5: return "Aşırı hareketli"
        }
    }
    
    var helpText: String? {
        switch self {
        case .lf_segment1: "Hareket etmiyorum veya çok az hareket ediyorum."
        case .lf_segment2: "Hafif hareketli bir yaşam / Haftada 1-3 gün egzersiz yapıyorum."
        case .lf_segment3: "Hareketli bir yaşam / Haftada 3-5 gün egzersiz yapıyorum."
        case .lf_segment4: "Çok hareketli bir yaşam / Haftada 6-7 gün egzersiz yapıyorum."
        case .lf_segment5: "Profesyonel sporcu, atlet seviyesi."
        }
    }
}

struct UserFormView2: View {
    
    // FORM ATTRIBUTES
    @Binding var name: String
    @Binding var lastname: String
    @Binding var age: Double
    @Binding var gender: String
    @Binding var muscleIntense: String?
    @Binding var weight: Double
    @Binding var length: Double
    @Binding var lifeStyle: String
    
    @Binding var stage: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .center) {
                Text("Seni Tanıyalım")
                    .font(.title)
                    .bold()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.top, 12)
            
            
            HStack {
                ForEach(0...2, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 5)
                        .foregroundStyle(Color(hex: index <= stage ? 0x6750A4 : 0xDEE2FF))
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            .padding(.bottom, 24)
            
            // USER FORM
            VStack(alignment: .leading) {
                if stage == 0 {
                    Text("1. Kişisel Bilgiler: ")
                        .font(.body)
                        .bold()
                        .foregroundStyle(Color(.black))
                        .padding(.bottom, 6)
                    
                    CustomTextField(value: $name, label: "İsminiz: ")
                    CustomTextField(value: $lastname, label: "Soyisminiz: ")
                        .padding(.bottom, 6)
                    
                    //person.badge.clock.fill
                    CustomSliderView(label: "Yaşınız", maxValue: 75, step: 1, measure: "", iconName: "age", value: $age)
                        .padding(.bottom, 6)
                    
                    CustomSelectList(iconName: "figure.dress.line.vertical.figure", label: "Cinsiyetiniz: ", /*options: genderOptionImages, labelDict: genderOptionDict,*/options: GenderType.allCases, selectedValue: $gender)
                }
                else if stage == 1 {
                    Text("2. Vücut Bilgileri: ")
                        .font(.body)
                        .bold()
                        .foregroundStyle(Color(.black))
                        .padding(.bottom, 6)
                    
                    CustomSliderView(label: "Boyunuz", maxValue: 250, step: 1, measure: "cm", iconName: "length", value: $length)
                        .padding(.bottom, 24)
                    
                    CustomSliderView(label: "Kilonuz", maxValue: 250, step: 0.1, measure: "kg", iconName: "weight", value: $weight)
                    
                }
                else if stage == 2 {
                    Text("3. Yaşam Tarzı: ")
                        .font(.body)
                        .bold()
                        .foregroundStyle(Color(.black))
                        .padding(.bottom, 6)
                    
                    CustomSelectList(iconName: "figure.disc.sports", label: "Günlük Hareketlilik Seviyeniz: ", /*options: lifeStyleOptionImages, labelDict: lifeStyleDict, helpTextDict: helpTextDict,*/options: LifeStyleType.allCases, selectedValue: $lifeStyle)
                }
            }
            .padding()
        }
    }
}

#Preview {
    UserFormView2(name: .constant(""),
                  lastname: .constant(""),
                  age: .constant(25),
                  gender: .constant("male"),
                  muscleIntense: Binding<String?>.constant(""),
                  weight: .constant(50),
                  length: .constant(50),
                  lifeStyle: .constant(""),
                  stage: .constant(0)
                )
}

struct CustomTextField: View {
    
    @Binding var value: String
    @State var label: String
    @State var iconName = "person.circle"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: iconName)
                    .foregroundStyle(Color(.systemGray2))
                TextField(label, text: $value)
                    .font(.system(.body, design: .rounded, weight: .semibold))
                    .foregroundStyle(Color(.black))
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(hex: 0xdee2ff), lineWidth: 2)
            }
            .padding(.bottom, 8)
        }
    }
}

extension Image {
    func optionModifier() -> some View {
        self
            .resizable()
            .frame(width: 50, height: 50)
   }
}

struct CustomSelectList: View {
    
    @State var iconName: String
    @State var label: String
    @State var options: [CustomSelectListProtocol]
    
    @Binding var selectedValue: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(Color(.systemGray2))
                Text(label)
                    .font(.system(.body, design: .rounded, weight: .semibold))
                    .foregroundColor(Color(.systemGray2))
            }
            .padding(.bottom)
            
            VStack(alignment: .center) {
                ForEach(options, id: \.text) { option in
                    HStack(alignment: .center) {
                        Image(option.rawData)
                            .optionModifier()
                        
                        VStack(alignment: .leading) {
                            Text(option.text)
                                .font(.system(.body, design: .rounded, weight: .semibold))
                                .padding(.horizontal)
                            
                            if let hText = option.helpText {
                                Text(hText)
                                    .font(.system(.caption, design: .rounded, weight: .medium))
                                    .foregroundStyle(Color(.systemGray2))
                                    .padding(.horizontal)
                                    .padding(.top, 2)
                            }
                        }
                        
                        if option.helpText != nil { Spacer() }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        HStack {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.secondary, lineWidth: selectedValue == option.text ? 4 : 2)
                                .foregroundColor(Color(hex: selectedValue == option.text ?  0x6750A4 : 0xdee2ff))
                        }
                    )
                    .onTapGesture {
                        selectedValue = option.text
                    }
                }
            }
            .padding()
        }
    }
}

struct CustomSliderView: View {
    
    @State var label: String
    @State var maxValue: Double
    @State var step: Double
    @State var measure: String
    @State var iconName: String
    @Binding var value: Double
    
    var body: some View {
        HStack {
            VStack {
                Stepper {
                    HStack {
                        Image(iconName)
                            .resizable()
                            .foregroundColor(Color(.systemGray2))
                            .tint(.blue)
                            .frame(width: 20, height: 20)
                            
                        Text("\(label): \(value.formatted()) \(measure)" )
                            .font(.system(.body, design: .rounded, weight: .semibold))
                        .foregroundStyle(Color(.systemGray2))
                    }
                } onIncrement: {
                    self.value += step
                } onDecrement: {
                    self.value -= step
                }
                
                Slider(
                    value: $value,
                    in: 0...maxValue,
                    step: step
                )
                .tint(Color(hex: 0x6750A4))
            }
        }
        .padding(.horizontal)
    }
}
