//
//  HomeView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 05/08/23.
//

import SwiftUI

struct CreatePasswordView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var password = ""
    @State private var passwordLength = 4.0
    @State private var allowUppercase = true
    @State private var allowLowercase = false
    @State private var allowNumber = false
    @State private var allowSymbol = false
    @State private var showAlert = false
    @State private var showSheet = false
    @State private var errorMessage = ""
    @State private var copied = false
    
    func checkExactlyOneTrue() -> Bool {
        let selectedBooleans = [allowUppercase, allowLowercase, allowNumber, allowSymbol]
        let truthyCount = selectedBooleans.filter { $0 }.count
        
        return truthyCount == 1
    }
    
    
    func generatePassword() -> String {
        let (success, generatedPassword, error) = generateRandomPassword(
            length: Int(passwordLength), allowUppercase, allowLowercase, allowNumber, allowSymbol
        )
        
        if success {
            return generatedPassword
        } else {
            showAlert = true
            errorMessage = error
            return ""
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack (spacing: 5) {
                    Text("Create")
                        .fontWeight(.semibold)
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("a solid password by")
                        .fontWeight(.semibold)
                        .font(.title)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("choosing properties")
                        .fontWeight(.semibold)
                        .font(.title)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack (spacing: 20) {
                    VStack {
                        Text("Characters")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.semibold)
                        
                        HStack (spacing: 100) {
                            Text("\(Int(passwordLength))")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fontWeight(.semibold)
                                .font(.title2)
                                .foregroundColor(.gray)
                                .frame(width: 40)
                            
                            Slider(value: $passwordLength, in: 4...20, step: 1)
                                .accentColor(.primary)
                                .onChange(of: passwordLength) { _ in
                                    password = generatePassword()
                                }
                        }
                    }
                    
                    VariantToggle(toggle: $allowUppercase, exactlyOneTrue: checkExactlyOneTrue(), title: "Allow Uppercase") {
                        _ in password = generatePassword()
                    }
                    
                    VariantToggle(toggle: $allowLowercase, exactlyOneTrue: checkExactlyOneTrue(), title: "Allow Lowercase") {
                        _ in password = generatePassword()
                    }
                    
                    VariantToggle(toggle: $allowNumber, exactlyOneTrue: checkExactlyOneTrue(), title: "Allow Numbers") {
                        _ in password = generatePassword()
                    }
                    
                    VariantToggle(toggle: $allowSymbol, exactlyOneTrue: checkExactlyOneTrue(), title: "Allow Symbols") {
                        _ in password = generatePassword()
                    }
                    
                }
                .padding([.top], 20)
            }
            .padding()
            
            VStack {
                HStack {
                    Text(password)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            password = generatePassword()
                        } label: {
                            Label("Generate", systemImage: "arrow.2.circlepath")
                                .labelStyle(.iconOnly)
                        }
                        .frame(width: 40, height: 40)
                        .background(.black)
                        .cornerRadius(.infinity)
                        .foregroundColor(.white)
                        
                        Button {
                            UIPasteboard.general.string = password
                            copied = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    copied = false
                                }
                            }
                        } label: {
                            Label("Copy", systemImage: copied ? "checkmark" : "doc.on.doc")
                                .labelStyle(.iconOnly)
                        }
                        .frame(width: 40, height: 40)
                        .background(.white)
                        .cornerRadius(.infinity)
                        .foregroundColor(.black)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding()
            .background(.primary)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                password = generatePassword()
            }
            .sheet(isPresented: $showSheet) {
                SaveCredentialView(password: password)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Go Back", systemImage: "chevron.left")
                            .foregroundColor(.primary)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet = true
                    } label: {
                        Label("Save", systemImage: "square.and.arrow.down")
                    }
                    .disabled(password.isEmpty)
                    .foregroundColor(password.isEmpty ? .gray : .black)
                }
            }
        }
    }
}

struct CreatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreatePasswordView()
        }
    }
}
