//
//  LoginResponse.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/22/21.
//

import Foundation

struct LoginResponse: Codable {
    var loginResult: LoginResult?
    var error: APIError?

    enum CodingKeys: String, CodingKey {
        case loginResult = "response"
        case error = "error"
    }
}

extension LoginResponse: CustomStringConvertible {
    var description: String {
        return "loginResult: \(String(describing: loginResult)), error: \(String(describing: error))"
    }
}
