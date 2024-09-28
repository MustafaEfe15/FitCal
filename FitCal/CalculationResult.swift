//
//  CalculationResult.swift
//  FitCal
//
//  Created by Mustafa Efe (Inspark) on 27.09.2024.
//

import SwiftUI

struct CalculationResult: View {
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Kalori Detayınız")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.top)
            .padding(.horizontal)
            
            HStack(alignment: .center) {
                Image(systemName: "info.circle")
                
                Text("Verdiğiniz bilgilere göre günlük almanız gereken kalori miktarı ve makro değerlerini aşağıda bulabilirsiniz.")
                    .font(.caption)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding()
            .background(Color(hex: 0xf8f8ff))
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image("plate-colorful")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .tint(.red)
                    VStack(alignment: .leading) {
                        Text("Günlük kalori ihtiyacınız ")
                            .fontWeight(.bold)
                        Text("\(CustomDoubleFormatter.twoFractiondigits(userInfoStore.caloriRequirement)) kkal/gün")
                            .font(.footnote)
                            .fontWeight(.medium)
                    }
                    .padding(.leading)
                }
                Divider()
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Image("wheat")
                            .resizable()
                            .frame(width: 30, height: 30)
                        VStack(alignment: .leading) {
                            Text("Karbonhidrat ")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("\(CustomDoubleFormatter.twoFractiondigits(userInfoStore.carbs)) gr. ")
                                .font(.footnote)
                                .fontWeight(.medium)
                        }
                    }
                    Divider()
                    HStack {
                        Image("fat")
                            .resizable()
                            .frame(width: 30, height: 30)
                        VStack(alignment: .leading) {
                            Text("Yağ ")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("\(CustomDoubleFormatter.twoFractiondigits(userInfoStore.fats)) gr. ")
                                .font(.footnote)
                                .fontWeight(.medium)
                        }
                    }
                    Divider()
                    HStack {
                        Image("meat")
                            .resizable()
                            .frame(width: 30, height: 30)
                        VStack(alignment: .leading) {
                            Text("Protein ")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("\(CustomDoubleFormatter.twoFractiondigits(userInfoStore.proteins)!) gr. ")
                                .font(.footnote)
                                .fontWeight(.medium)
                        }
                    }
                    
                }
                .padding(.leading, 18)
                .padding(.top, 24)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .fontWeight(.medium)
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("Veriler hakkında")
                        .font(.headline)
                    
                    Image(systemName: "questionmark.circle")
                }
                
                VStack {
                    ScrollView() {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                Image(systemName: "arrow.forward.circle")
                                    .frame(width: 8, height: 15)
                                Text("BMR, vücudunuzun dinlenirken harcadığı enerji miktarını temsil eder. BMR'niz yaş, cinsiyet, boy, kilo ve kas kütlesi gibi faktörlere bağlı olarak değişir. BMR hesaplamak için çeşitli matematiksel formüller kullanılabilir, burada kullanılan Harris-Benedict denklemleridir.")
                            }
                                
                            HStack(alignment: .top) {
                                Image(systemName: "arrow.forward.circle")
                                    .frame(width: 8, height: 15)
                                Text("BMR ile birlikte aktivite seviyeniz de belirlenir ve toplam enerji gereksinimizin hesaplanır. Aktivite seviyeniz gün içinde ne kadar hareketli oldğunuza, işinize ya da sporla uğraşmanıza göre değişecektir.")
                            }
                            
                            HStack(alignment: .top) {
                                Image(systemName: "arrow.forward.circle")
                                    .frame(width: 8, height: 15)
                                
                                VStack(alignment: .leading) {
                                    Text("Makro hesabı ise yine bilimsel olarak belirlenmiş kurallara göre hesaplanır. Genel olarak tavsiye edilen makro oranları şöyledir;")
                                    
                                    VStack(alignment: .leading) {
                                        Text("* Karbonhidratlar: %45-65")
                                        Text("* Yağlar: %10-35")
                                        Text("* Proteinler: %20-35")
                                    }
                                    .padding(.leading, 8)
                                }
                            }
                        }
                    }
                    .font(.caption)
                }
                .padding(.top, 4)
            }
            .padding()
            .background(Color(hex: 0xf8f8ff))
            
            Button(action: {
                self.activateUserDefaultsAndRedirect()
            }) {
                HStack{
                    Text("Anasayfa")
                    Image(systemName: "house")
                }
                .font(.system(.headline, design: .rounded))
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundStyle(.white)
                .background(Color(hex: 0x6750A4))
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
    
    func activateUserDefaultsAndRedirect() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                self.userInfoStore.isActive = true
            }
        }
    }
}

#Preview {
    CalculationResult().environmentObject(UserInfoStore())
}
