//
//  ContentView.swift
//  Unit Conversion
//
//  Created by ricky on 2023-12-31.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount = 0.0
    @State private var selectedInputUnit = "Celsius"
    @State private var selectedOutputUnit = "Celsius"
    
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertedAmount: Double {
        if selectedInputUnit == "Celsius" {
            switch selectedOutputUnit {
            case "Fahrenheit":
                return Measurement(value: amount, unit: UnitTemperature.celsius).converted(to: UnitTemperature.fahrenheit).value
            case "Kelvin":
                return Measurement(value: amount, unit: UnitTemperature.celsius).converted(to: UnitTemperature.kelvin).value
            default:
                return amount
            }
        }
        
        if selectedInputUnit == "Fahrenheit" {
            switch selectedOutputUnit {
            case "Celsius":
                return Measurement(value: amount, unit: UnitTemperature.fahrenheit).converted(to: UnitTemperature.celsius).value
            case "Kelvin":
                return Measurement(value: amount, unit: UnitTemperature.fahrenheit).converted(to: UnitTemperature.kelvin).value
            default:
                return amount
            }
        }
        
        if selectedInputUnit == "Kelvin" {
            switch selectedOutputUnit {
            case "Celsius":
                return Measurement(value: amount, unit: UnitTemperature.kelvin).converted(to: UnitTemperature.celsius).value
            case "Fahrenheit":
                return Measurement(value: amount, unit: UnitTemperature.kelvin).converted(to: UnitTemperature.fahrenheit).value
            default:
                return amount
            }
        }
            
        return 0.0
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $amount, format: .number)
                    Picker("Unit", selection: $selectedInputUnit) {
                        let size = units.count
                        ForEach(units, id:\.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text(convertedAmount, format: .number.rounded(increment: 0.01))
                    Picker("Unit", selection: $selectedOutputUnit) {
                        let size = units.count
                        ForEach(units, id:\.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                
            }
            .navigationTitle("Conversion")
        }
    }
}

#Preview {
    ContentView()
}
