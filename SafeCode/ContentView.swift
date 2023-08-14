//
//  ContentView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 25/07/23.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var credentials: FetchedResults<Credential>
    
    @State private var isUnlocked = true
    @State private var searchText = ""
    
    var searchResults: [Credential] {
        if searchText.isEmpty {
            return Array(credentials)
        } else {
            return credentials.filter { credential in
                return credential.service?.contains(searchText) ?? false
            }
        }
    }
    
    var strongCount: Int {
        return searchResults.filter { $0.strength >= 4 }.count
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your passwords."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
    
    var body: some View {
        NavigationStack {
            if isUnlocked {
                VStack(spacing: 30) {
                    Text("Safe Code")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(searchResults.count)")
                                .font(.title)
                                .bold()
                            
                            Text("Passwords")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                            .frame(width: 2, height: 50)
                            .overlay(.white)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(strongCount)")
                                .font(.title)
                                .bold()
                            
                            Text("Strong")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                            .frame(width: 2, height: 50)
                            .overlay(.white)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(searchResults.count - strongCount)")
                                .font(.title)
                                .bold()
                            
                            Text("Mediocre")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.black)
                
                VStack(spacing: 20) {
                    HStack(alignment: .top) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .offset(y: 3)
                        
                        TextField("", text: $searchText)
                        
                        if searchText.isEmpty {
                            Text("Enter your text")
                                .foregroundColor(.gray) // Set placeholder color
                                .offset(x: -200)
                        }
                        
                        
                    }
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("primary").opacity(0.8), lineWidth: 2))
                    
                    if searchResults.isEmpty {
                        Spacer()
                        Text("No credentials saved")
                            .fontWeight(.medium)
                    } else {
                        CredentialListView(credentials: searchResults)
                    }
                    
                    Spacer()
                }
                .onAppear(perform: authenticate)
                .padding(.horizontal)
                .padding(.vertical, 6)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            CreatePasswordView()
                        } label: {
                            Image(systemName: "plus")
                                .accessibilityLabel("Create a Credential")
                                .foregroundColor(.white)
                        }
                    }
                }
            } else {
                VStack {
                    Text("Use your biometrics to use the app.")
                    
                    Button {
                        authenticate()
                    } label: {
                        Text("Continue")
                            .bold()
                            .foregroundColor(Color("secondary"))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(Color("primary"))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
