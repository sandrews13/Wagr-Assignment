//
//  NetworkError.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-26.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case dataError
    case decodingError
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
            case .urlError:
                return NSLocalizedString("Error converting the urlString to an URL", comment: "Check the URL and try again")
            case .dataError:
                return NSLocalizedString("Error: No data was returned from the endpoint", comment: "Check the endpoint and try again")
            case .decodingError:
                return NSLocalizedString("Error decoding the json returned from the server", comment: "Check your data models and try agin")
        }
    }
}
