//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Michael Droz on 4/11/15.
//  Copyright (c) 2015 Benefakter Apps. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer 

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    //@IBOutlet weak var myVolumeViewParentView: UIView!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var myVolumeViewParentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // myVolumeViewParentView.backgroundColor = UIColor(white: 1, alpha: 0.5)
//        var wrapperView = UIView(frame: CGRectMake(30, 200, 260, 20))
//        var volumeView = MPVolumeView(frame: wrapperView.bounds)
//        myVolumeViewParentView = MPVolumeView(frame: wrapperView.bounds)
//        myVolumeViewParentView.addSubview(volumeView)
    
        
        
        stopButton.enabled = false
        //get handle on audio file
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            var filePathUrl = NSURL.fileURLWithPath(filePath)
//            
//        }else {
//            println("error retrieving file path")
//        }
        
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePath, error: nil)
        audioPlayer.enableRate = true
        
         audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePath, error: nil)
        
            }
    
    
    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        stopButton.enabled = true
        
        var wrapperView = UIView(frame: CGRectMake(30, 200, 260, 20))
        self.view.backgroundColor = UIColor.clearColor()
        self.view.addSubview(wrapperView)
        
        var volumeView = MPVolumeView(frame: wrapperView.bounds)
        wrapperView.addSubview(volumeView)
        
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        stopButton.enabled = true
    }
    
    @IBAction func playChipMonk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        stopButton.enabled = true
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
        
    }
    

    @IBAction func stopPlayingAudio(sender: UIButton) {
        
        audioPlayer.stop()
        stopButton.enabled = false
    }
    
    
        }
    


