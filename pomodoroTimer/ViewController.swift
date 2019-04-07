//
//  ViewController.swift
//  pomodoroTimer
//
//  Created by Zoish Pithawala on 11/16/17.
//  Copyright © 2017 Zoish Pithawala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var time: UILabel!
    
    var seconds = 1500
    var timer = Timer()
    var isTimerRunning=false
    var onBreak = false
    var onWork = true
    var round = 0
    
    @IBAction func startButton(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
        }
        
    }
    

    
    @IBAction func stopButton(_ sender: UIButton) {
        timer.invalidate()
    }
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        
        isTimerRunning=true
    }
    
    func updateTimer() {

        if seconds < 1 && onBreak == false {
            round += 1
            timer.invalidate()
            onBreak = true
            if round == 4 {
                timer.invalidate()
                onBreak = true
                round = 0
                let alert = UIAlertController(title: "Take a longer break!", message: "Start your 15 minute break!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Start", comment: "Default action"), style: .`default`){
                    
                    UIAlertAction in
                    self.isTimerRunning=false
                    self.seconds=900
                    self.runTimer()
                })
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
            let alert = UIAlertController(title: "Time for a break!", message: "Start your 5 minute break!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Start", comment: "Default action"), style: .`default`){
            
            UIAlertAction in
                self.isTimerRunning=false
                self.seconds=120
                self.runTimer()
            })
            self.present(alert, animated: true, completion: nil)
            }
            
            
            
        }
        else if seconds < 1  && onBreak == true {
            timer.invalidate()
            onBreak = false
            let alert = UIAlertController(title: "Time for a work!", message: "Start another 25 minute work session!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Start", comment: "Default action"), style: .`default`) {
                
                UIAlertAction in
                self.isTimerRunning=false
                self.seconds=1500
                self.runTimer()
            })
            self.present(alert, animated: true, completion: nil)
        }
        else {
            seconds -= 1
            time.text = timeString(time: TimeInterval(seconds))
        }
    }
 
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

