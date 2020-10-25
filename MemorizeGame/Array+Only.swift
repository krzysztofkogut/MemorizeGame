//
//  Array+Only.swift
//  MemorizeGame
//
//  Created by Kris on 25/10/2020.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
