//
//  ContentView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 25/07/23.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var credentials: FetchedResults<Credential>
    
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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Safe Code")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .bold()
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(credentials.count)")
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
                        Text("\(credentials.count)")
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
                        Text("\(credentials.count)")
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
                    TextField("Search", text: $searchText)
                }
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 2))
                
                if searchResults.isEmpty {
                    Spacer()
                    Text("No credentials saved")
                        .fontWeight(.medium)
                } else {
                    CredentialListView(credentials: searchResults)
                }
                
                Spacer()
            }
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
