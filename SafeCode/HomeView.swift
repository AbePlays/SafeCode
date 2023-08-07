//
//  HomeView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 05/08/23.
//

import SwiftUI

struct HomeView: View {
    @State private var password = ""
    @State private var passwordStrength = "Very Weak"
    @State private var passwordLength = 0.0
    @State private var allowUppercase = false
    @State private var allowLowercase = false
    @State private var allowNumber = false
    @State private var allowSymbol = false
    @State private var showAlert = false
    @State private var showSheet = false
    @State private var errorMessage = ""
    
    func resetState() {
        password = ""
        passwordStrength = "Very Weak"
        passwordLength = 0.0
        allowUppercase = false
        allowLowercase = false
        allowNumber = false
        allowSymbol = false
    }
    
    func handleGeneratePressed() {
        let (success, generatedPassword, message) = generateRandomPassword(
            length: Int(passwordLength), allowUppercase, allowLowercase, allowNumber, allowSymbol
        )
        
        if success {
            password = generatedPassword
            let generatedPasswordStrength = evaluatePasswordStrength(generatedPassword)
            passwordStrength = generatedPasswordStrength
        } else {
            showAlert = true
            errorMessage = message
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("\(password.count > 0 ? password : "Your Password")")
                            .foregroundColor(password.count == 0 ? .gray : .primary)
                        Spacer()
                        Button(action: {
                            print("Copy")
                        }) {
                            Image(systemName: "doc.on.doc")
                                .accessibilityLabel(Text("Copy to Clipboard"))
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
                    
                    Slider(value: $passwordLength, in: 0...20, step: 1)
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
                
                HStack (spacing: 20) {
                    Button {
                        handleGeneratePressed()
                    } label: {
                        Text("Generate")
                            .frame(maxWidth: .infinity)
                    }
                    .alert(errorMessage, isPresented: $showAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    
                    Button {
                        showSheet.toggle()
                    } label: {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(password.count == 0)
                    .sheet(isPresented: $showSheet) {
                        SaveEntityView(password: password, onSave: {
                            resetState()
                            showSheet = false
                        })
                    }
                }
            }
            .navigationTitle("Password Generator")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
