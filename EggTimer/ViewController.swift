//
//  ViewController.swift
//  EggTimer
//
//  Created by Ömer Faruk Okumuş on 4.01.2023.
//

import UIKit

class ViewController: UIViewController {

    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 5]
    var secondsRemaining = 0
    var timer: Timer? = nil
    var titleTimer: Timer? = nil
    var progressChunk: Float = 0
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let title = sender.currentTitle else {return}
        
        let time = eggTimes[title]
        
        resetProgressBar()
        setTimer(time)
        setProgressChunk(time)
    }
    
    private func resetProgressBar() {
        progressBar.progress = 0
    }
    
    private func setTimer(_ time: Int?) {
        guard let time = time else {return}
        titleLabel.text = "How do you like your egg?"
        print("Starting new timer")
        secondsRemaining = time
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc private func updateTimer() {
        if secondsRemaining > 0 {
            print("\(secondsRemaining) seconds.")
            secondsRemaining -= 1
            progressBar.progress += progressChunk
        }
        else {
            titleLabel.text = "Done!"
            progressBar.progress += progressChunk
            setTitleTimer()
            timer?.invalidate()
        }
    }
    
    private func setProgressChunk(_ time: Int?) {
        guard let time = time else {return}
        progressChunk = 1.0 / (Float(time) + 1)
    }
    
    private func setTitleTimer() {
        titleTimer?.invalidate()
        titleTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(resetTitleLabel), userInfo: nil, repeats: false)
    }
    
    @objc private func resetTitleLabel() {
        titleLabel.text = "How do you like your eggs?"
    }
        
}

