//
//  ContentView.swift
//  Measurement Converter (SwiftUI)
//
//  Created by Gustavo Perbone on 14/12/21.
//
/*
 Your challenge
 You need to build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.

 Which units you choose are down to you, but you could choose one of these:

 Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
 Length conversion: users choose meters, kilometers, feet, yards, or miles.
 Time conversion: users choose seconds, minutes, hours, or days.
 Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
 If you were going for length conversion you might have:

 A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
 A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
 A text field where users enter a number.
 A text view showing the result of the conversion.
 */
//

import SwiftUI

struct ContentView: View {
    @State private var input : Double = 32.0
    
    @State private var unitInput: Dimension = UnitTemperature.celsius

    @State private var unitOutput: Dimension = UnitTemperature.celsius
    var converterType = ["Temperature", "Distance", "Time", "Volume"]
    
    @State var selectedUnit = 0
    
   var unitType = [
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitLength.meters, UnitLength.kilometers,
         UnitLength.inches, UnitLength.feet, UnitLength.yards, UnitLength.miles],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds],
        [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons]
    ]

    var result: String {
        let inputValue = Measurement(value: input, unit: unitInput)
        let outputValue = inputValue.converted(to: unitOutput)
        
        return outputValue.formatted()
 
        }

    var body: some View {
        NavigationView{
            Form{
                //section to choose what to convert
                Section{
                    Picker("Conversion Type",  selection: $selectedUnit) {
                        ForEach(0..<converterType.count){
                            Text(converterType[$0])
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("Choose what to convert")
                }
                
                //section to choose what the input unit is
                Section{
                 TextField("Value", value: $input, format: .number)
                     .keyboardType(.decimalPad)
                Picker("Input Unit", selection: $unitInput) {
                    ForEach(unitType[selectedUnit], id: \.self){
                        Text(MeasurementFormatter().string(from: $0).capitalized)
                    }
                } .pickerStyle(.segmented)
                } header: {
                 Text("Value to convert")
                }
                
                //section to show converted value
                Section{
                Picker("Output Unit", selection: $unitOutput) {
                    ForEach(unitType[selectedUnit], id: \.self){
                        Text(MeasurementFormatter().string(from: $0).capitalized)
                    }
                } .pickerStyle(.segmented)
                 Text(result)

                } header: {
                 Text("Converted Value")
                }

            }
            .navigationTitle("Converter")
            .onChange(of: selectedUnit) { newSelection in
                let units = unitType[newSelection]
                unitInput = units[0]
                unitOutput = units[1]
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


