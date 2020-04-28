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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeProgressView: UIProgressView!
    
    var player: AVAudioPlayer!
    let eggTimes = ["Soft": 5, "Medium": 8, "Hard": 12]
    var timer: Timer?
    var timeLeft = 0
    var totalTime = 0
    
    override func viewDidLoad() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        if timer != nil {
            timer!.invalidate()
        }

        totalTime = eggTimes[sender.currentTitle!]! * 60
        timeLeft = totalTime
        titleLabel.text = sender.currentTitle
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: sender.currentTitle, repeats: true)
    }
    
    @objc func countdown(timer: Timer) {
        print("\(timeLeft) second\(timeLeft == 1 ? "" : "s") remaining...")
        timeProgressView.progress = 1 - Float(timeLeft) / Float(totalTime)
        timeLeft -= 1
        
        if timeLeft < 0 {
            player.play()
            
            let eggsTerm = timer.userInfo as! String
            titleLabel.text = "Your \(eggsTerm) eggs are ready!\nEnjoy!"
            
            self.timer!.invalidate()
            self.timer = nil
        }
    }
}
