//
//  PaymentsResponse.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/22/21.
//

import Foundation

struct PaymentsResponse: Codable {
    var paymentsResult: [Payment]?
    var error: APIError?

    enum CodingKeys: String, CodingKey {
        case paymentsResult = "response"
        case error = "error"
    }
}
