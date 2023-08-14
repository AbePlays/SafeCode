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
