//
//  APIDataManager.swift
//  Words
//
//  Created by Sergey Ilyushin on 26/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation

protocol IAPIDataManager: class {
    func requestMeanings(identifiers: [Int], completionHandler: (([Meaning]) -> Void)?, errorHandler: ((Error) -> Void)?)
}

class APIDataManager: IAPIDataManager {

    // MARK:- Public vars
    var api: IAPI!
    
    init(api: IAPI) {
        self.api = api
    }
    
    func requestMeanings(identifiers: [Int], completionHandler: (([Meaning]) -> Void)?, errorHandler: ((Error) -> Void)?) {
        let succesHandler = {[unowned self](skyengMeanings: [APIMeaning]) in
            self.meaningFromAPI(apiMeanings: skyengMeanings, completionHandler: { (meanings) in
                completionHandler!(meanings)
            })
        }
        
        let errorHandler = {(error: Error) in
            print(error.localizedDescription)
            errorHandler!(error)
        }
        api.requestMeanings(identifiers: identifiers, completionHandler: succesHandler, errorHandler: errorHandler)
    }
    
    // MARK:- Load meaning from skyengMeaning
    
    fileprivate func meaningFromAPI(apiMeanings: [APIMeaning], completionHandler: @escaping([Meaning]) -> Void) {
        DispatchQueue.global().async {
            var meanings = [Meaning]()
            for apiMeaning in apiMeanings {
                if let imageUrl = apiMeaning.imageUrl, let url = URL(string: imageUrl), let imageData = try? Data(contentsOf: url),
                    let soundUrl = apiMeaning.soundUrl, let surl = URL(string: soundUrl), let soundData = try? Data(contentsOf: surl){
                    guard let text = apiMeaning.text, let id = apiMeaning.identifier, let translation = apiMeaning.translation else {
                        continue
                    }
                    let meaning = Meaning(identifier: id, text: text, translation: translation)
                    meaning.imageData = imageData
                    meaning.soundData = soundData
                    if let alternatives = apiMeaning.alternatives {
                        meaning.alternatives = self.alternativeTranslationFromSkyeng(skyengAlternatives: alternatives)
                    }
                    meanings.append(meaning)
                }
            }
            completionHandler(meanings)
        }
    }
    
    fileprivate func alternativeTranslationFromSkyeng(skyengAlternatives: [APIAlternative]) -> [Alternative] {
        var alternatives = [Alternative]()
        
        for skyengAlternative in skyengAlternatives {
            if let text = skyengAlternative.text, let translation = skyengAlternative.translation {
                let alternative = Alternative(text: text, translation: translation)
                alternatives.append(alternative)
            }
        }
        return alternatives
    }
}
