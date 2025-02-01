//
//  ContentView.swift
//  SkeroCalc Swift v1.1
//
//  Created by Kybl Enterprise 2025.
//

import SwiftUI

// color extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// plug enum
enum Plug: String, CaseIterable, Identifiable {
    case weby = "Weby"
    case samik = "Samik"
    case dominik = "Dominik"
    case peta = "Peta"
    case smack = "Smack"
    
    var id: String { self.rawValue }
    
    var tax: Double {
        switch self {
        case .weby: return 0.9
        case .samik: return 0.5
        case .dominik: return 1.3
        case .peta: return 1.0
        case .smack: return 0.0
        }
    }
}

// main view
struct ContentView: View {
    @State private var amount = ""
    @State private var selectedPlug: Plug = .weby
    @State private var realAmount = ""
    @State private var aboutClicks = 0
    @State private var showKyblMessage = false
    @State private var showUnlockMessage = false
    @State private var smackUnlocked = false
    @State private var smackActivated = false
    
    private let appGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(hex: "#16DE3B"),
            Color(hex: "#0AE7EE")
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        ZStack {
            appGradient
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("SkeroCalc")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                // amount input
                VStack(alignment: .leading, spacing: 4) {
                    Text("Enter Amount")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                    
                    TextField("", text: $amount)
                        .textFieldStyle(PlainTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .frame(width: 200)
                        .padding(8)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                        )
                }
                
                // plug selection
                VStack(alignment: .leading, spacing: 4) {
                    Text("Select Plug")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                    
                    Picker("", selection: $selectedPlug) {
                        ForEach(Plug.allCases.filter { $0 != .smack || smackUnlocked }) { plug in
                            Text(plug.rawValue).tag(plug)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 200)
                    .labelsHidden()
                    .padding(6)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(8)
                    .onChange(of: selectedPlug) { _ in
                        smackActivated = false
                    }
                }
                
                // calculate button
                Button(action: calculate) {
                    Text(buttonTitle)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 200)
                        .padding()
                        .background(buttonColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                }
                .buttonStyle(PlainButtonStyle())
                
                // result display
                VStack(alignment: .leading) {
                    Text("Real Amount")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white.opacity(0.9))
                            .frame(width: 200, height: 40)
                        
                        Text(realAmount)
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .medium))
                    }
                }
                
                // about button
                Button("About") {
                    handleAboutClick()
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
                .padding(.top)
                .alert("Kybl Enterprise 2025", isPresented: $showKyblMessage) {
                    Button("OK") {
                        if smackUnlocked && !showUnlockMessage {
                            showUnlockMessage = true
                        }
                    }
                }
                .alert("Smack Unlocked!", isPresented: $showUnlockMessage) {
                    Button("OK") { }
                } message: {
                    Text("plug smack is now available")
                }
            }
            .padding()
        }
        .frame(width: 400, height: 500)
    }
    
    // button appearence
    private var buttonTitle: String {
        smackActivated ? "NEŘEŠ" : "Calculate"
    }
    
    private var buttonColor: Color {
        smackActivated ? .red : .blue
    }
    
    // calculation logic
    private func calculate() {
        guard !amount.isEmpty else { return }
        
        if selectedPlug == .smack {
            realAmount = "∞"
            smackActivated = true
        } else {
            let value = (Double(amount) ?? 0) * selectedPlug.tax
            realAmount = String(format: "%.2f g", value)
            smackActivated = false
        }
    }
    
    // about handler
    private func handleAboutClick() {
        aboutClicks += 1
        showKyblMessage = true
        
        if aboutClicks >= 5 && !smackUnlocked {
            smackUnlocked = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
