//
//  VariantToggle.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 09/08/23.
//

import SwiftUI

struct VariantToggle: View {
    @Binding var toggle: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var exactlyOneTrue: Bool
    var title: String
    var onChange: ((Bool) -> ())?
    
    var body: some View {
        VStack {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(toggle ? "Yes" : "No")
                    .fontWeight(.medium)
                    .font(.title2)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Toggle(title, isOn: $toggle)
                    .disabled(toggle && exactlyOneTrue)
                    .labelsHidden()
                    .onChange(of: toggle) { newValue in
                        onChange?(newValue)
                    }
                    .foregroundColor(.red)
                    .toggleStyle(SwitchToggleStyle(tint: colorScheme == .dark ? .gray : .black))
            }
        }
    }
}

struct VariantToggle_Previews: PreviewProvider {
    static var previews: some View {
        VariantToggle(toggle: .constant(false), exactlyOneTrue: true, title: "Allow Symbols")
    }
}
