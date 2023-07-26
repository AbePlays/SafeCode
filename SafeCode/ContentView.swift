//
//  ContentView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 25/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var password = ""
    @State private var passwordStrength = "Very Weak"
    @State private var passwordLength = 0.0
    @State private var isEditing = false
    @State private var allowUppercase = false
    @State private var allowLowercase = false
    @State private var allowNumber = false
    @State private var allowSymbol = false
    @State private var showAlert = false
    @State private var alertType = "password-length"
    
    let ERROR_MESSAGE = [
        "password-length": "Password length cannot be zero.",
        "allow-single-character": "At least one character type (uppercase, lowercase, number, symbol) must be allowed."
    ]
    
    func evaluatePasswordStrength(_ password: String) -> String {
        let passwordLength = password.count
        var score = 0
        
        // Evaluate password length
        score += max(0, passwordLength - 8) * 2
        
        // Evaluate character types
        let characterTypes: [CharacterSet] = [.uppercaseLetters, .lowercaseLetters, .decimalDigits, .symbols]
        for type in characterTypes {
            if password.rangeOfCharacter(from: type) != nil {
                score += 5
            }
        }
        
        // Evaluate variety of characters
        let uniqueCharacters = Set(password)
        score += min(10, uniqueCharacters.count)
        
        // Penalize common patterns
        let commonPatterns = ["123456", "password", "qwerty", "123456789"]
        if commonPatterns.contains(password.lowercased()) {
            score -= 20
        }
        
        // Map score to password strength levels
        switch score {
        case 0...10:
            return "Very Weak"
        case 11...20:
            return "Weak"
        case 21...30:
            return "Moderate"
        case 31...40:
            return "Strong"
        default:
            return "Very Strong"
        }
    }
    
    func generateRandomPassword(length: Int, _ allowUppercase: Bool, _ allowLowercase: Bool, _ allowNumber: Bool, _ allowSymbol: Bool) -> String {
        let uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
        let numbers = "0123456789"
        let symbols = "!@#$%^&*()-_=+[]{}|;:'\",.<>?/"
        
        var allowedCharacters = ""
        
        if allowUppercase {
            allowedCharacters += uppercaseLetters
        }
        if allowLowercase {
            allowedCharacters += lowercaseLetters
        }
        if allowNumber {
            allowedCharacters += numbers
        }
        if allowSymbol {
            allowedCharacters += symbols
        }
        
        if allowedCharacters.isEmpty || length == 0 {
            showAlert = true
            if length == 0 {
                alertType = "password-length"
            } else {
                alertType = "allow-single-character"
            }
        } else {
            let password = String((0..<length).compactMap { _ in allowedCharacters.randomElement() })
            return password
        }
        
        return ""
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("\(password.count > 0 ? password : "Your Password")")
                        Spacer()
                        Button(action: {
                            print("Copy")
                        }) {
                            Image(systemName: "doc.on.doc")
                                .foregroundColor(password.count == 0 ? .gray : .blue)
                        }
                        .disabled(password.count == 0)
                    }
                    
                    HStack {
                        Text("Strength").fontWeight(.semibold)
                        Spacer()
                        Text(passwordStrength)
                    }
                    
                }
                
                VStack {
                    HStack {
                        Text("Character Length")
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(Int(passwordLength))")
                    }
                    
                    Slider(
                        value: $passwordLength,
                        in: 0...20,
                        step: 1,
                        onEditingChanged: { editing in
                            isEditing = editing
                        }
                    )
                }
                
                Section {
                    Toggle(isOn: $allowUppercase) {
                        Text("Include Uppercase Letters")
                    }
                    .toggleStyle(.switch)
                    
                    Toggle(isOn: $allowLowercase) {
                        Text("Include Lowercase Letters")
                    }
                    .toggleStyle(.switch)
                    
                    Toggle(isOn: $allowNumber) {
                        Text("Include Numbers")
                    }
                    .toggleStyle(.switch)
                    
                    Toggle(isOn: $allowSymbol) {
                        Text("Include Symbols")
                    }
                    .toggleStyle(.switch)
                }
                
                Button("Generate") {
                    var generatedPassword = generateRandomPassword(length: Int(passwordLength), allowUppercase, allowLowercase, allowNumber, allowSymbol)
                    
                    password = generatedPassword
                    
                    var generatedPasswordStrength = evaluatePasswordStrength(generatedPassword)
                    
                    passwordStrength = generatedPasswordStrength
                }
                .alert(ERROR_MESSAGE[alertType]!, isPresented: $showAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    .frame(maxWidth: .infinity)
                
            }
            .navigationTitle("Password Generator")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
