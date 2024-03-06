//
//  ContentView.swift
//  SwiftUIColorizedApp
//
//  Created by horze on 05.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    @State private var displayedValue = 0
    @State private var userRedSliderValue = ""
    @State private var userGreenSliderValue = ""
    @State private var userBlueSliderValue = ""


    
    var body: some View {
        VStack (spacing: 40) {
            Image(systemName: "rectangle.fill")
                .resizable()
                .foregroundStyle(Color(red: redSliderValue / 255, green: greenSliderValue / 255, blue: blueSliderValue / 255))
                .frame(width: 300, height: 200)
            ColorSliderView(sliderValue: $redSliderValue, userSliderValue: $userRedSliderValue, colorSlider: Color.red)
            ColorSliderView(sliderValue: $greenSliderValue, userSliderValue: $userGreenSliderValue, colorSlider: Color.green)
            ColorSliderView(sliderValue: $blueSliderValue, userSliderValue: $userBlueSliderValue, colorSlider: Color.blue)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct ColorSliderView: View {
    @Binding var sliderValue: Double
    @Binding var userSliderValue: String
    var colorSlider: Color
    
    var body: some View {
        HStack {
            Text(lround(sliderValue).formatted())
                .frame(width: 45)
                .foregroundStyle(colorSlider)
            Slider(value: $sliderValue, in: 0...255, step: 1)

            TextField("", text: $userSliderValue)
                .frame(width: 45, height: 25)
                .foregroundStyle(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 2)
                )
                .keyboardType(.numberPad)
            
                
        }
    }
}
