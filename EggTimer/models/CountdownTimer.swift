//
//  CountdownTimer.swift
//  EggTimer
//
//  Created by Ömer Faruk Okumuş on 29.03.2023.
//

import Foundation

class CountdownTimer {
    private var timer: Timer? = nil
    private var secondsRemaining = 0
    private let totalSeconds: Int
    private let onTick: (() -> Void)?
    private let onFinish: (() -> Void)?
    
    init(totalSeconds: Int, onTick: (() -> Void)? = nil, onFinish: (() -> Void)? = nil) {
        self.totalSeconds = totalSeconds
        self.secondsRemaining = self.totalSeconds
        self.onTick = onTick
        self.onFinish = onFinish
    }
    
    func start() {
        print("\(secondsRemaining) seconds.")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            print("\(secondsRemaining) seconds.")
            onTick?()
        }
        if secondsRemaining == 0 {
            onFinish?()
            invalidate()
        }
    }
    
    func getSecondsRemaining() -> Int {
        return secondsRemaining
    }
    
    func invalidate() {
        timer?.invalidate()
    }
    
    func cancel() {
        invalidate()
    }
    
    func abort() {
        invalidate()
    }
    
}
