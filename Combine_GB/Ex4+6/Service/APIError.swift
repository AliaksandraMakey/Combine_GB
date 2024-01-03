//
//  APIError.swift
//  Combine_TestAPI
//
//  Created by Александра Макей on 03.01.2024.
//

import Foundation

enum APIError: Error {
    case tooShort(String)
    case userIdNotFound
}
