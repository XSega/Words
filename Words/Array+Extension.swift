//
//  Array+Extension.swift
//  Words
//
//  Created by Sergey Ilyushin on 26/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation


extension Array {
    
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        print(index)
        return self[index]
    }
    
    func randomItems(count: Int) -> [Element] {
        var items = [Element]()
        for _ in 0 ... count {
            let index = Int(arc4random_uniform(UInt32(self.count)))
            items.append(self[index])
        }
        return items
    }
}

extension Collection {
    /// Return a copy of `self` with its elements shuffled
    func shuffled() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffle()
        return list
    }
}

extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffle() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }
}
