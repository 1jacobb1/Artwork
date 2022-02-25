//
//  Array+Extensions.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

extension Array {
    /**
     Make arrays safe.
     source: https://stevenpcurtis.medium.com/make-your-swift-arrays-safe-8a4d7127e4b0
     Sample syntax:
     ```
     let numbers = [1,2,3,4]
     let invalidNumber = numbers[safe: 10] // returns nil
     let validNumber = numbers[safe: 0] // returns 1
     ```
     */
    subscript (safe index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index] as Element
    }
}
