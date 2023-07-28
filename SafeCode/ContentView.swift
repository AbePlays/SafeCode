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
    @State private var errorMessage = ""
    
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
                    let (success, generatedPassword, message) = generateRandomPassword(length: Int(passwordLength), allowUppercase, allowLowercase, allowNumber, allowSymbol)
                    
                    if success {
                        password = generatedPassword
                        let generatedPasswordStrength = evaluatePasswordStrength(generatedPassword)
                        passwordStrength = generatedPasswordStrength
                    } else {
                        showAlert = true
                        errorMessage = message
                    }
                }
                .alert(errorMessage, isPresented: $showAlert) {
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
