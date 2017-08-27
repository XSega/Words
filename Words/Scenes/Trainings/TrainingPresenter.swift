//
//  TrainingPresenter.swift
//  Words
//
//  Created by Sergey Ilyushin on 8/24/17.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import UIKit
import AVFoundation

class TrainingPresenter {
    
    // MARK:- Private
    
    fileprivate var player: AVAudioPlayer?
    
    // MARK: Sounds
    
    func playCorrectSound() {
        playSound(name: "correctSound")
    }
    
    func playWrongSound() {
        playSound(name: "wrongSound")
    }
    
    func playSound(name: String) {
        if let asset = NSDataAsset(name: name){
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"aiff")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func playSound(data: Data) {
        do {
            player = try AVAudioPlayer(data:data, fileTypeHint:"mp3")
            player?.play()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
