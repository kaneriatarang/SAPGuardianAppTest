//
//  MockNetworkManager.swift
//  SAPGuardianAppTests
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import Foundation
import Combine

class MockNetworkManager {
       
    static let shared = MockNetworkManager()
    
    func request<T: Codable> (_ fileName: String) -> Future<T, Error> {
        
        return Future<T, Error> { observer in
            
            let bundel = Bundle(for: type(of: self))
            
            if let path = bundel.path(forResource: fileName, ofType: "text") {
                if let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) {
                    let decoder = JSONDecoder()
                    if let cache = try? decoder.decode(T.self, from: data) {
                        observer(.success(cache))
                    }
                }
            }
        }
    }
    
}
