//
//  ContentView.swift
//  SwiftUIColorizedApp
//
//  Created by horze on 05.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255).rounded()
    @State private var greenSliderValue = Double.random(in: 0...255).rounded()
    @State private var blueSliderValue = Double.random(in: 0...255).rounded()
    
    @FocusState private var isInputActive: Bool


    var body: some View {
        ZStack {
            VStack (spacing: 40) {
                ImageView(red: redSliderValue, green: greenSliderValue, blue: blueSliderValue)
                VStack {
                    ColorSliderView(sliderValue: $redSliderValue, colorSlider: .red)
                    ColorSliderView(sliderValue: $greenSliderValue, colorSlider: .green)
                    ColorSliderView(sliderValue: $blueSliderValue, colorSlider: .blue)
                }
                .frame(height: 150)
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isInputActive = false
                        }
                    }
                }
                Spacer()
            }
        }
        .padding()
        .background(.black)
        .onTapGesture {
            isInputActive = false
        }
    }
}

#Preview {
    ContentView()
}

struct ColorSliderView: View {
    @Binding var sliderValue: Double
    var colorSlider: Color
    
    @State private var text = ""
    @State private var showAlert = false
    
    var body: some View {
        HStack {
            Text(sliderValue.formatted())
                .frame(width: 45, alignment: .leading)
                .foregroundStyle(colorSlider)
            Slider(value: $sliderValue, in: 0...255, step: 1)
                .tint(colorSlider)
                .onChange(of: sliderValue) { _, newValue in
                    text = newValue.formatted()
                }
            TextFieldView(TextFieldValue: $text, action: checkValue)
                .alert("Wrong Format", isPresented: $showAlert, actions: {}) {
                    Text("Please enter value from 0 to 255")
                }
        }
        .onAppear {
            text = sliderValue.formatted()
        }
    }
    
    private func checkValue() {
        if let value = Double(text), (0...255).contains(value) {
            self .sliderValue = value
        } else {
            showAlert.toggle()
            sliderValue = 0
            text = "0"
        }
    }
}

struct TextFieldView: View {
    @Binding var TextFieldValue: String
    
    let action: () -> Void
    
    var body: some View {
        TextField("", text: $TextFieldValue) { _ in
            withAnimation {
                action()
            }
        }
        .frame(width: 45, alignment: .trailing)
        .multilineTextAlignment(.trailing)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.numberPad)
    }
}

struct ImageView: View {
    
    let red: Double
    let green: Double
    let blue: Double
    
    var body: some View {
        Color(red: red / 255, green: green / 255, blue: blue / 255)
            .clipShape(.rect(cornerRadius: 20))
            .frame(height: 150)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 5)
            )
    }
}
