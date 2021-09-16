//
//  NetworkManager.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import Foundation
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    func request<T: Codable> (_ urlRequest: URLRequest) -> Future<T, Error> {
        
        return Future<T, Error> { observer in
            
            // Network Rechablity Check
            if !ReachabilityManager.shared.isReachable {
                observer(.failure(RequestError.connectionError))
            }
            
            print(urlRequest.stringRequest())
            
            URLSession.shared.dataTaskPublisher(for: urlRequest)
                .tryMap { output in
                    guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                        throw RequestError.invalidResponse
                    }
                    print(output.data.prettyPrintedJSONString ?? "")
                    return output.data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        switch error {
                        case let decodingError as DecodingError:
                            observer(.failure(decodingError))
                        case let apiError as RequestError:
                            observer(.failure(apiError))
                        default:
                            observer(.failure(RequestError.unknownError))
                        }
                    }
                }, receiveValue: { observer(.success($0)) })
                .store(in: &self.cancellables)
        }
    }
    
}

enum RequestError: Error {
    case unknownError
    case connectionError
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
}
