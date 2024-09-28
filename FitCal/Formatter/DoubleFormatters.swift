//
//  DoubleFormatters.swift
//  FitCal
//
//  Created by Mustafa Efe (Inspark) on 28.09.2024.
//

import Foundation

struct CustomDoubleFormatter {
    
    // Two fraction digits and round to down.
    static func twoFractiondigits(_ number: Double) -> String!  {
        let formatter = NumberFormatter()
        formatter.roundingMode = .down
        formatter.maximumFractionDigits = 2

        let number = NSNumber(value: number)
        let formattedValue = formatter.string(from: number)
        return "\(formattedValue ?? "0")"
    }
}
