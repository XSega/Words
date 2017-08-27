//
//  LocalDataManager.swift
//  Words
//
//  Created by Sergey Ilyushin on 26/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation
import CoreStore

protocol ILocalDataManager: class {
    
    func fetchMeaningIds(count: Int) -> [Int]?
    
    func updateUserWordsProgress(identifiers: [Int])
    func fetchUserWords() -> [UserWord]?
    func saveUserWords(_ words: [UserWord], completionHandler: ((Int) -> Void)?, errorHandler: ((Error) -> Void)?)
    
    func fetchMeanings(identifiers: [Int]) -> [Meaning]?
    func saveMeanings(_ meanings: [Meaning])
}

class LocalDataManager: ILocalDataManager {

    // MARK: Meaning ids
    
    func updateUserWordsProgress(identifiers: [Int]) {
        CoreStore.perform(
            asynchronous: { (transaction) -> Void in
                if let userWords = transaction.fetchAll(From<UserWordData>(),
                                     OrderBy(.ascending("progress")),
                                     Where("identifier IN %@", identifiers)) {
                    for userWord in userWords {
                        userWord.progress += 1
                    }
                }
            },
            completion: { _ in
            }
        )
    }
    
    func fetchMeaningIds(count: Int) -> [Int]? {
        guard let array = CoreStore.fetchAll(
            From<UserWordData>(),
            OrderBy(.ascending("progress")),
            Tweak { (fetchRequest) -> Void in
                fetchRequest.includesPendingChanges = false
                fetchRequest.fetchLimit = count

        }) else {
            print("Meaning with ids were not found")
            return nil
        }
        
        let meaningsIds = array.map({Int($0.identifier)})
        return meaningsIds
    }
    
    
    // MARK: User words
    
    class func removeAllUserWords() {
        CoreStore.perform(
            asynchronous: { (transaction) -> Void in
                transaction.deleteAll(
                    From<UserWordData>()
                )
        },
            completion: { _ in }
        )
    }
   
    class func logAllUserWords() {
        guard let array = CoreStore.fetchAll(
            From<UserWordData>(),
            OrderBy(.ascending("progress")),
            Tweak { (fetchRequest) -> Void in
                fetchRequest.includesPendingChanges = false
        }) else {
            print("Meaning with ids were not found")
            return
        }
        array.map({print("\($0.identifier)  \($0.progress)")})
    }
    
    func fetchUserWords(identifiers: [Int]) -> [UserWordData]? {
        guard let array = CoreStore.fetchAll(
            From<UserWordData>(),
            OrderBy(.ascending("progress")),
            Where("identifier IN %@", identifiers),
            Tweak { (fetchRequest) -> Void in
                fetchRequest.includesPendingChanges = false
        }) else {
            print("Meaning with ids were not found")
            return nil
        }
        
        return array
    }

    func fetchUserWords() -> [UserWord]? {
        guard let array = CoreStore.fetchAll(
            From<UserWordData>(),
            OrderBy(.ascending("progress")),
            Tweak { (fetchRequest) -> Void in
                fetchRequest.includesPendingChanges = false
        }) else {
            print("Meaning with ids were not found")
            return nil
        }
        
        var meanings = [UserWord]()
        for data in array {
            let meaning = UserWord(data)
            meanings.append(meaning)
        }
        return meanings
    }
    
    func saveUserWords(_ words: [UserWord], completionHandler: ((Int) -> Void)?, errorHandler: ((Error) -> Void)?) {
        CoreStore.perform(asynchronous: { (transaction) -> Void in
            for word in words {
                if let _ = transaction.fetchOne(From<UserWordData>(), Where("identifier == %@",word.identifier)) {
                    continue
                }
                
                let data = transaction.create(Into<UserWordData>())
                data.identifier =  Int32(word.identifier)
                data.progress =  Int32(word.progress)
            }
        }, completion: { (result) -> Void in
            switch result {
            case .success: completionHandler!(9)
            case .failure(let error): errorHandler!(error)
            }
        })
    }
    
    // MARK: Meanings
    
    func fetchMeanings(identifiers: [Int]) -> [Meaning]? {
        guard let array = CoreStore.fetchAll(
            From<MeaningData>(),
            Where("identifier IN %@", identifiers),
            OrderBy(.ascending("identifier")),
            Tweak { (fetchRequest) -> Void in
                fetchRequest.includesPendingChanges = false
        }) else {
            print("Meaning with ids were not found")
            return nil
        }
        
        var meanings = [Meaning]()
        for data in array {
            let meaning = Meaning(meaningData: data)
            meanings.append(meaning)
        }
        return meanings
    }
    
    func saveMeanings(_ meanings: [Meaning]) {
        CoreStore.perform(asynchronous: { (transaction) -> Void in
            for meaning in meanings {
                let data = transaction.create(Into<MeaningData>())
                data.identifier =  Int32(meaning.identifier)
                data.text = meaning.text
                data.translation = meaning.translation
                data.image = meaning.imageData
                data.sound = meaning.soundData
                
                if let alternatives = meaning.alternatives {
                    for alternative in alternatives {
                        let alternativeData = transaction.create(Into<AlternativeData>())
                        alternativeData.text = alternative.text
                        alternativeData.translate = alternative.translation
                        data.addToAlternatives(alternativeData)
                    }
                }
            }
        }, completion: { (result) -> Void in
            switch result {
            case .success: print("success!")
            case .failure(let error): print(error)
            }
        })
    }
    
    fileprivate func fetchMeaning(identifier: Int) -> Meaning? {
        guard let data = CoreStore.fetchOne(
            From<MeaningData>(),
            Where("identifier == \(identifier)"),
            OrderBy(.ascending("identifier")),
            Tweak { (fetchRequest) -> Void in
                fetchRequest.includesPendingChanges = false
        }) else {
            print("Meaning with id - \(identifier) was not found")
            return nil
        }

        let meaning = Meaning(meaningData: data)
        return meaning
    }
    
    func saveMeaning(_ meaning: Meaning) {
        CoreStore.perform(asynchronous: { (transaction) -> Void in
            let data = transaction.create(Into<MeaningData>())
            data.identifier =  Int32(meaning.identifier)
            data.text = meaning.text
            data.translation = meaning.translation
            data.image = meaning.imageData
            data.sound = meaning.soundData
            
            if let alternatives = meaning.alternatives {
                for alternative in alternatives {
                    let alternativeData = transaction.create(Into<AlternativeData>())
                    alternativeData.text = alternative.text
                    alternativeData.translate = alternative.translation
                    data.addToAlternatives(alternativeData)
                }
            }
        }, completion: { (result) -> Void in
            switch result {
            case .success: print("success!")
            case .failure(let error): print(error)
            }
        })
    }
}
