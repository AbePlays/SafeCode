//
//  utils.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 28/07/23.
//

import Foundation

func generateRandomPassword(length: Int, _ allowUppercase: Bool, _ allowLowercase: Bool, _ allowNumber: Bool, _ allowSymbol: Bool) -> (success: Bool, password: String, errorMessage: String) {
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
        let errorMessage: String
        if length == 0 {
            errorMessage = "Password length must be greater than 0."
        } else {
            errorMessage = "At least one character type (uppercase, lowercase, number, symbol) must be allowed."
        }
        return (false, "", errorMessage)
    } else {
        let password = String((0..<length).compactMap { _ in allowedCharacters.randomElement() })
        return (true, password, "")
    }
}

func evaluatePasswordStrength(_ password: String) -> Int {
    let lengthRequirement = 8
    let numericRegex = ".*[0-9]+.*"
    let lowercaseRegex = ".*[a-z]+.*"
    let uppercaseRegex = ".*[A-Z]+.*"
    let specialCharacterRegex = ".*[^a-zA-Z0-9]+.*"
    
    var strength = 1
    
    if password.count >= lengthRequirement {
        strength = 2
        if password.range(of: numericRegex, options: .regularExpression) != nil {
            strength = 3
        }
        if password.range(of: lowercaseRegex, options: .regularExpression) != nil &&
            password.range(of: uppercaseRegex, options: .regularExpression) != nil {
            strength = 4
        }
        if password.range(of: specialCharacterRegex, options: .regularExpression) != nil {
            strength = 5
        }
    }
    
    return strength
}
