//
//  Direction.swift
//  Direction
//
//  Created by Andrew Halls on 13/11/17.
//  Copyright © 2017 Andrew Halls. All rights reserved.
//

import Foundation

// Based on thi spoist
//https://theswiftdev.com/2017/10/12/swift-enum-all-values/??

import Foundation

public protocol EnumCollection: Hashable {
    static func cases() -> AnySequence<Self>
    static var allValues: [Self] { get }
}

public extension EnumCollection {
    
    public static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    public static var allValues: [Self] {
        return Array(self.cases())
    }
    public var caseName: String {
        return "\(self)"
    }
}

enum Direction : Int, EnumCollection {
    case north = 0
    case south = 180
    case east = 90
    case west = 270
    
    var description: String {
        return "\(self.caseName.capitalized)(\(self.rawValue))"
    }
    
}
print(Direction.south.description)


