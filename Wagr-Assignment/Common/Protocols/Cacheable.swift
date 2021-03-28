//
//  Cacheable.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-27.
//

import Foundation

protocol Cacheable {
    associatedtype T
    
    static func fetchAllFromCache() -> [T]?
}
