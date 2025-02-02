//
//  ContentView.swift
//  SkeroCalc iOS v1.2
//
//  Created by Kybl Enterprise.
//

import SwiftUI

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

enum Plug: String, CaseIterable, Identifiable {
    case weby = "Weby"
    case samik = "Samik"
    case dominik = "Dominik"
    case peta = "Peta"
    case vietnamci = "Vietnamci"
    case smack = "Smack"
    
    var id: String { self.rawValue }
    
    var tax: Double {
        switch self {
        case .weby: return 0.9
        case .samik: return 0.5
        case .dominik: return 1.3
        case .peta: return 1.0
        case .vietnamci: return 1.0
        case .smack: return 0.0
        }
    }
}

struct ContentView: View {
    @State private var amount = ""
    @State private var selectedPlug: Plug = .weby
    @State private var realAmount = ""
    @State private var aboutClicks = 0
    @State private var showKyblMessage = false
    @State private var showUnlockMessage = false
    @State private var smackUnlocked = false
    @State private var smackActivated = false
    @State private var showVietnamciWarning = false
    @State private var isKeyboardVisible = false
    
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
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("SkeroCalc")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 20)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Enter Amount")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        TextField("", text: $amount)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Select Plug")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        Picker("Select Plug", selection: $selectedPlug) {
                            ForEach(Plug.allCases.filter { $0 != .smack || smackUnlocked }) { plug in
                                Text(plug.rawValue).tag(plug)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 100)
                        .labelsHidden()
                        .padding(.horizontal)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .onChange(of: selectedPlug) { newValue in
                            if newValue == .vietnamci {
                                showVietnamciWarning = true
                            }
                            smackActivated = false
                        }
                    }
                    .padding(.horizontal)
                    
                    Button(action: calculate) {
                        Text(buttonTitle)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(buttonColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("Real Amount")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.9))
                                .frame(height: 50)
                            
                            Text(realAmount)
                                .foregroundColor(Color(hex: "#545454"))
                                .font(.title2)
                                .fontWeight(.medium)
                        }
                    }
                    .padding(.horizontal)
                    
                    Button("About") {
                        handleAboutClick()
                    }
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(Color(hex: "#0AE7EE"))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(
                        Capsule()
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                    )
                    .padding(.vertical)
                }
                .padding()
            }
            
            if isKeyboardVisible {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: hideKeyboard) {
                            Image(systemName: "keyboard.chevron.compact.down")
                                .font(.title)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.blue)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 50)
                    }
                }
            }
        }
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
        .alert("Warning!", isPresented: $showVietnamciWarning) {
            Button("OK") { }
        } message: {
            Text("budou to mordy skera tak ara")
        }
        .onAppear {
            setupKeyboardObservers()
        }
    }
    
    private var buttonTitle: String {
        smackActivated ? "NEŘEŠ" : "Calculate"
    }
    
    private var buttonColor: Color {
        smackActivated ? .red : .blue
    }
    
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
    
    private func handleAboutClick() {
        aboutClicks += 1
        showKyblMessage = true
        
        if aboutClicks >= 5 && !smackUnlocked {
            smackUnlocked = true
        }
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
            isKeyboardVisible = true
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            isKeyboardVisible = false
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
