//
//  HTTPService.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct RequestError: Error {
    var message: String
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
}

struct HTTPHeader {
    var field: String
    var value: String
    
    init(field: HTTPHeaderField, value: String) {
        self.field = field.rawValue
        self.value = value
    }
    
    init(field: String, value: String) {
        self.field = field
        self.value = value
    }
}


extension URLRequest {
    mutating func add(header: HTTPHeader) {
        self.addValue(header.value, forHTTPHeaderField: header.field)
    }
}
