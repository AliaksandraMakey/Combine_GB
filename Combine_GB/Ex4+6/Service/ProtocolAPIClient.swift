//
//  APIClient.swift
//  Combine_TestAPI
//
//  Created by Александра Макей on 03.01.2024.
//

import Foundation
import Combine

protocol APIClient {
    func fetchUser(userId: Int) -> AnyPublisher<User, Error>
}
