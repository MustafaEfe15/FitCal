//
//  UserInfoStore.swift
//  FitCal
//
//  Created by Mustafa Efe on 1.09.2024.
//

import Foundation

final class UserInfoStore: ObservableObject {
    
    init() {
        UserDefaults.standard.register(defaults: [
            "user.info.isActive": false,
            "user.info.name": "",
            "user.info.age": 0,
            "user.info.gender": "female",
            "user.info.weight": 0,
            "user.info.length": 0,
            "user.info.lifeStyle": "lf_stage1",
            "user.info.caloriRequirement": 0
        ])
    }
    
    @Published var isActive: Bool = UserDefaults.standard.bool(forKey: "user.info.isActive") {
        didSet {
            UserDefaults.standard.set(isActive, forKey: "user.info.isActive")
        }
    }
    
    @Published var name: String = (UserDefaults.standard.string(forKey: "user.info.name") ?? "") {
        didSet {
            UserDefaults.standard.set(name, forKey: "user.info.name")
        }
    }
    
    @Published var age: Int = (UserDefaults.standard.integer(forKey: "user.info.age")) {
        didSet {
            UserDefaults.standard.set(age, forKey: "user.info.age")
        }
    }
    
    @Published var gender: GenderType = GenderType(rawValue: UserDefaults.standard.string(forKey: "user.info.gender") ?? "female")! {
        didSet {
            UserDefaults.standard.set(gender.rawValue, forKey: "user.info.gender")
        }
    }
    
    @Published var weight: Double = (UserDefaults.standard.double(forKey: "user.info.weight")) {
        didSet {
            UserDefaults.standard.set(weight, forKey: "user.info.weight")
        }
    }
    
    @Published var length: Double = (UserDefaults.standard.double(forKey: "user.info.length")) {
        didSet {
            UserDefaults.standard.set(weight, forKey: "user.info.length")
        }
    }
    
    @Published var lifeStyle: LifeStyleType = LifeStyleType(rawValue: UserDefaults.standard.string(forKey: "user.info.lifeStyle") ?? "lf_segment1")! {
        didSet {
            UserDefaults.standard.set(lifeStyle.rawValue, forKey: "user.info.lifeStyle")
        }
    }
    
    @Published var caloriRequirement: Double = (UserDefaults.standard.double(forKey: "user.info.caloriRequirement")) {
        didSet {
            UserDefaults.standard.set(caloriRequirement, forKey: "user.info.caloriRequirement")
        }
    }
}
