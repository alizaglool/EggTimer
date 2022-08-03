//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    var timer = Timer()
    var player : AVAudioPlayer?

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var barProgressView: UIProgressView!
    
    let eggTimes = ["Soft": 3,"Medium": 4, "Hard": 7]
    var totalTime = 0
    var secondPassed = 0
    @IBAction func btnEggPress(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        barProgressView.progress = 0.0
        titleLable.text = hardness
        secondPassed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func UpdateTimer() {
        if secondPassed < totalTime {
            secondPassed += 1
            barProgressView.progress = Float(secondPassed) / Float(totalTime)
//            print(Float(secondPassed) / Float(totalTime))
        }else {
            timer.invalidate()
            titleLable.text = "Done"
            playSound()
        }
    }
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
}
