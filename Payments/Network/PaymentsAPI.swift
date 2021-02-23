//
//  PaymentsAPI.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/22/21.
//

import Moya

enum PaymentsAPI {
    case login(login: String, password: String)
    case payments
    
    @UserDefault(key: "token") static var token: String?
}

extension PaymentsAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://82.202.204.94/api")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .payments:
            return "payments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .payments:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let user, let password):
          let parameters: [String: Any] = ["login": user,
                                           "password": password]
          return .requestParameters(parameters: parameters, encoding: URLEncoding.default)

        case .payments:
            let parameters: [String: Any] = ["token": PaymentsAPI.token ?? ""]
          return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["app-key": "12345", "v": "1"]
    }
}
