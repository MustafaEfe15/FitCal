//
//  UserFormView.swift
//  FitCal
//
//  Created by Mustafa Efe on 7.08.2024.
//

import SwiftUI

struct UserFormViewWithSwiftForm: View {
    
    @Binding var name: String
    @Binding var lastname: String
    @Binding var age: String
    @Binding var gender: String
    @Binding var muscleIntense: String?
    
    @State var weight: Double = 50
    @State var length: Double = 50
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Seni Tanıyalım")
                .font(.title)
                .bold()
                .padding()
            
            Form {
                Section("Kişisel Bilgiler") {
                    TextField("Adınız: ", text: $name)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    
                    TextField("Soyadınız: ", text: $lastname)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    
                    TextField("Yaşınız: ", text: $age)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                
                    VStack(alignment: .leading) {
                        Text("Cinsiyetiniz: ")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(.systemGray3))
                            .bold()
                        
                        HStack(spacing: 15) {
                            Image("male")
                                .resizable()
                                .foregroundColor(.yellow)
                                .frame(width: 50, height: 50)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(.secondary, lineWidth: gender == "male" ? 3 : 1)
                                        .foregroundColor(gender == "male" ? .blue : .secondary)
                                )
                                .onTapGesture {
                                    self.gender = "male"
                                }
                            
                            Image("female")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 50, height: 50)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(.secondary, lineWidth: gender == "female" ? 3 : 1)
                                        .foregroundColor(gender == "female" ? .blue : .secondary)
                                        
                                )
                                .onTapGesture {
                                    self.gender = "female"
                                }
                        }
                    }
                }
                
                Section("Vücut Bilgileri") {
                    HStack {
                        VStack {
                            Stepper {
                                Text("Boyunuz: \(length.formatted()) cm" )
                            } onIncrement: {
                                self.length += 1
                            } onDecrement: {
                                self.length -= 1
                            }
                            .padding(5)
                            
                            Slider(
                                value: $length,
                                in: 0...250,
                                step: 1
                            )
                        }
                    }
                    
                    HStack {
                        VStack {
                            Stepper {
                                Text("Kilonuz: \(weight.formatted()) kg" )
                            } onIncrement: {
                                self.weight += 1
                            } onDecrement: {
                                self.weight -= 1
                            }
                            .padding(5)
                            
                            Slider(
                                value: $weight,
                                in: 25...300,
                                step: 1
                            )
                        }
                    }
                }
            }
        }
    }
}



#Preview {
    UserFormViewWithSwiftForm(name: Binding<String>.constant(""),
                 lastname: Binding<String>.constant(""),
                 age: Binding<String>.constant(""),
                 gender: Binding<String>.constant(""),
                 muscleIntense: Binding<String?>.constant(""))
}
