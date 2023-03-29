//
//  ViewController.swift
//  EggTimer
//
//  Created by Ömer Faruk Okumuş on 4.01.2023.
//

import UIKit

class ViewController: UIViewController {

    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 5]
    var progressChunk: Float = 0
    
    var timer: CountdownTimer? = nil
    var titleTimer: CountdownTimer? = nil
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let title = sender.currentTitle else {return}
        
        let time = eggTimes[title]
        
        resetViews()
        cancelTimers()
        setProgressChunk(time)
        setTimer(time)
    }
    
    private func resetViews(){
        resetProgressBar()
        resetTitleLabel()
    }
    
    private func cancelTimers() {
        timer?.invalidate()
        titleTimer?.invalidate()
    }
    
    private func resetProgressBar() {
        progressBar.progress = 0
    }
    
    private func setTimer(_ time: Int?) {
        guard let time = time else {return}
        titleLabel.text = "How do you like your egg?"
        print("Starting new timer")
        
        timer = CountdownTimer(totalSeconds: time, onTick: onTick, onFinish: onFinish)
        timer?.start()
    }
    
    private func onTick() {
        DispatchQueue.main.async {
            self.progressBar.progress += self.progressChunk
        }
    }
    
    private func onFinish() {
        DispatchQueue.main.async {
            self.titleLabel.text = "Done!"
            self.progressBar.progress += self.progressChunk
        }
         setTitleTimer()
    }
    
    private func setProgressChunk(_ time: Int?) {
        guard let time = time else {return}
        progressChunk = 1.0 / Float(time)
    }
    
    private func setTitleTimer() {
        titleTimer?.invalidate()
        titleTimer = CountdownTimer(totalSeconds: 2, onTick: nil,
                                    onFinish: resetTitleLabel)
        titleTimer?.start()
        //titleTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(resetTitleLabel), userInfo: nil, repeats: false)
    }
    
    @objc private func resetTitleLabel() {
        titleLabel.text = "How do you like your eggs?"
    }
        
}

