//
//  ContentView.swift
//  SkeroCalc macOS v0.1.1
//
//  Created by Kybl Enterprise 2025.
//

import SwiftUI

struct ContentView: View {
    @State private var amount: String = ""
    @State private var realAmount: String = ""
    @State private var selectedPlug: Plug = .weby
    @State private var aboutClickCount: Int = 0
    @State private var isSmackUnlocked: Bool = false
    @State private var calculateButtonText: String = "Calculate"
    
    enum Plug: String, CaseIterable {
        case weby = "weby"
        case samik = "samik"
        case dominik = "dominik"
        case peta = "peta"
        case smack = "smack"
        
        var tax: Double {
            switch self {
            case .weby: return 0.9
            case .samik: return 0.75
            case .dominik: return 1.3
            case .peta: return 1.0
            case .smack: return .infinity
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // title
            Text("SkeroCalc")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            // plug picker
            Text("PLUG")
                .font(.headline)
            Picker("plug:", selection: $selectedPlug) {
                ForEach(Plug.allCases.filter { $0 != .smack || isSmackUnlocked }, id: \.self) { plug in
                    Text(plug.rawValue).tag(plug)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(width: 200)
            .onChange(of: selectedPlug) { newPlug in
                if newPlug != .smack {
                    calculateButtonText = "CALCULATE"
                }
            }
            
            // amount Input
            TextField("Enter Amount", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 200)
                .padding()
            
            // calculate button
            Button(action: calculateRealAmount) {
                Text(calculateButtonText)
                    .font(.headline)
                    .padding()
                    .frame(width: 200)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            // real amount box
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 200, height: 50)
                
                Text("REAL AMOUNT: \(realAmount)")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .padding()
            
            // about button
            Button(action: aboutButtonClicked) {
                Text("About")
                    .font(.headline)
                    .padding()
                    .frame(width: 200)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .popover(isPresented: .constant(aboutClickCount >= 1)) {
                Text("Kybl Enterprise 2025")
                    .padding()
            }
        }
        .padding()
        .frame(width: 400, height: 500)
    }
    
    private func calculateRealAmount() {
        guard let amountValue = Double(amount) else {
            realAmount = "Invalid input"
            return
        }
        
        if selectedPlug == .smack {
            calculateButtonText = "NEŘEŠ"
            realAmount = "∞"
        } else {
            let result = amountValue * selectedPlug.tax
            realAmount = String(format: "%.2f g", result)
        }
    }
    
    private func aboutButtonClicked() {
        aboutClickCount += 1
        if aboutClickCount == 5 {
            isSmackUnlocked = true
            realAmount = "Smack unlocked!"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
