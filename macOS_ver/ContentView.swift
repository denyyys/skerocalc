//
//  ContentView.swift
//  SkeroCalc Swift v2.1
//
//  Created by Kybl Enterprise 2025.
//

import SwiftUI
import AppKit

// --- Optimization: Pre-calculate Colors ---
extension Color {
    static let skeroGreen = Color(hex: "#16DE3B")
    static let skeroCyan = Color(hex: "#0AE7EE")
    static let skeroBlue = Color(hex: "#005BEA")
    static let skeroLightCyan = Color(hex: "#00C6FB")
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
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

// --- Optimization: Static Theme Resources ---
struct Theme {
    static let appGradient = LinearGradient(
        gradient: Gradient(colors: [.skeroGreen, .skeroCyan]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let buttonAccentGradient = LinearGradient(
        gradient: Gradient(colors: [.skeroBlue, .skeroLightCyan]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let titleGradient = LinearGradient(
        colors: [.white, .cyan],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// --- Optimization: Shared Formatter ---
struct Formatters {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}

// --- Logic Enum ---
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
    
    static let longestPlugName: String = {
        return allCases.map { $0.rawValue }.max { a, b in a.count < b.count } ?? "Weby"
    }()
}

// --- Native Liquid Glass Style ---
struct NativeGlassStyle: ViewModifier {
    let material: Material
    
    init(material: Material = .regularMaterial) {
        self.material = material
    }
    
    func body(content: Content) -> some View {
        content
            .background(material, in: RoundedRectangle(cornerRadius: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .strokeBorder(.white.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

// --- CRITICAL FIX: Non-Intrusive Window Accessor ---
// This version uses Notifications instead of hijacking the delegate.
struct WindowAccessor: NSViewRepresentable {
    @Binding var window: NSWindow?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            // Only update if the window reference has actually changed
            if self.window !== view.window {
                self.window = view.window
            }
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
    
    // Coordinator listens for closing via NotificationCenter
    // preventing conflicts with SwiftUI's internal window management.
    class Coordinator: NSObject {
        var parent: WindowAccessor
        var observer: NSObjectProtocol?
        
        init(_ parent: WindowAccessor) {
            self.parent = parent
            super.init()
            
            // Listen for window closing passively
            self.observer = NotificationCenter.default.addObserver(
                forName: NSWindow.willCloseNotification,
                object: nil,
                queue: .main
            ) { [weak self] notification in
                guard let self = self else { return }
                // Ensure we are terminating only when OUR window closes
                if let closedWindow = notification.object as? NSWindow,
                   closedWindow == self.parent.window {
                    NSApp.terminate(nil)
                }
            }
        }
        
        deinit {
            if let observer = observer {
                NotificationCenter.default.removeObserver(observer)
            }
        }
    }
}

// --- Reusable Input Component ---
struct InputBox<Content: View>: View {
    let label: String
    let content: Content
    
    init(label: String, @ViewBuilder content: () -> Content) {
        self.label = label
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
                .shadow(radius: 2)
                .frame(width: 220)
            
            content
                .frame(width: 220, alignment: .center)
                .padding(.horizontal, 10)
                .padding(.vertical, 12)
                .modifier(NativeGlassStyle(material: .regularMaterial))
                .colorScheme(.dark)
        }
    }
}

// --- Subview: Input Section ---
struct InputSection: View {
    @Binding var amount: String
    @Binding var selectedPlug: Plug
    @Binding var smackUnlocked: Bool
    @Binding var smackActivated: Bool
    @FocusState.Binding var isInputFocused: Bool
    
    private let maxPlugNameWidth: CGFloat = 100
    
    var body: some View {
        VStack(spacing: 25) {
            InputBox(label: "Enter Amount") {
                TextField("0.00", text: $amount)
                    .focused($isInputFocused)
                    .onSubmit {
                        isInputFocused = false
                    }
                    .multilineTextAlignment(.center)
                    .font(.system(size: 22, weight: .semibold))
                    .textFieldStyle(.plain)
            }
            
            InputBox(label: "Select Plug") {
                Menu {
                    ForEach(Plug.allCases.filter { $0 != .smack || smackUnlocked }) { plug in
                        Button(action: {
                            selectedPlug = plug
                            smackActivated = false
                        }) {
                            HStack {
                                Text(plug.rawValue)
                                    .font(.system(size: 16))
                                
                                if plug == selectedPlug {
                                    Spacer()
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color.skeroGreen)
                                }
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedPlug.rawValue)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: maxPlugNameWidth)
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white.opacity(0.7))
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .menuStyle(.borderlessButton)
            }
        }
    }
}

// --- Subview: Result Section ---
struct ResultSection: View {
    let realAmount: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Real Amount")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
                .shadow(radius: 2)
                .frame(width: 220)
            
            ZStack {
                Text(realAmount)
                    .foregroundStyle(realAmount == "∞" ? .red : .primary)
                    .font(.system(size: 26, weight: .bold))
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                    .frame(width: 200, height: 36)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 10)
                    .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 24))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .strokeBorder(.white.opacity(0.3), lineWidth: 1.5)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
            }
            .colorScheme(.light)
        }
    }
}

// --- Splash View Component ---
private struct SplashView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 150, height: 150)
                .blur(radius: 40)
            
            VStack(spacing: 20) {
                VStack(spacing: 5) {
                    Text("SkeroCalc")
                        .font(.system(size: 42, weight: .heavy))
                        .foregroundStyle(Theme.titleGradient)
                        .shadow(color: .cyan.opacity(0.3), radius: 10, x: 0, y: 0)
                    
                    Text("SWIFT EDITION")
                        .font(.system(size: 10, weight: .bold))
                        .tracking(4)
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Spacer().frame(height: 10)

                Text("Kybl Enterprise 2025")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white.opacity(0.4))
            }
        }
        .padding(40)
        .modifier(NativeGlassStyle(material: .ultraThinMaterial))
        .frame(width: 450, height: 250)
    }
}

// --- Main ContentView ---
struct ContentView: View {
    @State private var isLoading = true
    @State private var window: NSWindow?
    
    @State private var amount = ""
    @State private var selectedPlug: Plug = .weby
    @State private var realAmount = ""
    @State private var smackUnlocked = false
    @State private var smackActivated = false
    
    @State private var aboutClicks = 0
    @State private var showKyblMessage = false
    @State private var showUnlockMessage = false
    
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        ZStack {
            WindowAccessor(window: $window)
                .frame(width: 0, height: 0)
            
            Theme.appGradient
                .ignoresSafeArea()
            
            if isLoading {
                SplashView()
            } else {
                VStack(spacing: 25) {
                    Text("SkeroCalc")
                        .font(.system(size: 34, weight: .heavy))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(.top, 30)
                    
                    InputSection(
                        amount: $amount,
                        selectedPlug: $selectedPlug,
                        smackUnlocked: $smackUnlocked,
                        smackActivated: $smackActivated,
                        isInputFocused: $isInputFocused
                    )
                    
                    Button(action: calculate) {
                        Text(smackActivated ? "NEŘEŠ" : "Calculate")
                            .font(.system(size: 18, weight: .bold))
                            .frame(width: 220)
                            .padding(.vertical, 14)
                            .background {
                                if smackActivated {
                                    Color.red.opacity(0.8)
                                } else {
                                    Theme.buttonAccentGradient
                                }
                            }
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .strokeBorder(.white.opacity(0.3), lineWidth: 1)
                            )
                            .foregroundStyle(.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                    }
                    .buttonStyle(.plain)
                    
                    ResultSection(realAmount: realAmount)
                    
                    Button("About") {
                        handleAboutClick()
                    }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white.opacity(0.8))
                    .padding(.top, 10)
                    .alert("Kybl Enterprise 2025 (v2.10)", isPresented: $showKyblMessage) {
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
                .padding(30)
                .transition(.opacity.animation(.easeOut(duration: 0.5)))
            }
        }
        .frame(width: isLoading ? 500 : 400, height: isLoading ? 250 : 600)
        .onChange(of: isLoading) { oldValue, newValue in
            updateWindowStyle(isSplash: newValue)
        }
        .onChange(of: window) { oldValue, newValue in
            updateWindowStyle(isSplash: isLoading)
        }
        .onAppear {
            Task {
                try await Task.sleep(nanoseconds: 5_000_000_000)
                withAnimation(.easeInOut(duration: 0.5)) {
                    isLoading = false
                }
            }
        }
    }
    
    private func updateWindowStyle(isSplash: Bool) {
        guard let window = window else { return }
        
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.styleMask.insert(.fullSizeContentView)
        window.isMovableByWindowBackground = true
        window.backgroundColor = .clear
        
        if isSplash {
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true
        } else {
            window.standardWindowButton(.closeButton)?.isHidden = false
            window.standardWindowButton(.miniaturizeButton)?.isHidden = false
            window.standardWindowButton(.zoomButton)?.isHidden = false
        }
        
        DispatchQueue.main.async {
            window.center()
        }
    }
    
    private func calculate() {
        guard !amount.isEmpty else { return }
        isInputFocused = false
        
        if selectedPlug == .smack {
            realAmount = "∞"
            smackActivated = true
        } else {
            let value = (Double(amount) ?? 0) * selectedPlug.tax
            let formattedValue = Formatters.currency.string(from: NSNumber(value: value)) ?? String(format: "%.2f", value)
            realAmount = "\(formattedValue) g"
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
