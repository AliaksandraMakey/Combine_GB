//
//  APIClient.swift
//  Combine_TestAPI
//
//  Created by Александра Макей on 03.01.2024.
//

import Foundation
import Combine

class APIClientService: APIClient {
    func fetchUser(userId: Int) -> AnyPublisher<User, Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(userId)") else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }

        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: User.self, decoder: JSONDecoder())
            .tryMap { user -> User in
                guard user.name.count > 2 else {
                    throw APIError.tooShort(user.name)
                }
                return user
            }
            .mapError { error in
                return error as? APIError ?? .userIdNotFound
            }
            .flatMap { user -> AnyPublisher<User, Error> in
           
                return Just(user)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
