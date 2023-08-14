//
//  Input.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 11/08/23.
//

import SwiftUI

struct Input: View {
    @Binding var text: String
    var label: String
    var isDisabled: Bool?
    
    var body: some View {
        VStack {
            Text("\(label)")
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("", text: $text)
                .accessibilityLabel("\(label) Field")
                .accessibilityValue(Text(text))
                .disabled(isDisabled ?? false)
                .foregroundColor(.black)
                .padding(8)
                .background(isDisabled ?? false ? Color("disabled") : .white)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 3))
                .cornerRadius(8)
        }
    }
}

struct Input_Previews: PreviewProvider {
    static var previews: some View {
        Input(text: .constant(""), label: "Text Input", isDisabled: false)
            .padding()
    }
}
