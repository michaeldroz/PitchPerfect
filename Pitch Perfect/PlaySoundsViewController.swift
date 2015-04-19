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
    
    var unitReverb = AVAudioUnitReverb()
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    //@IBOutlet weak var myVolumeViewParentView: UIView!
    
    @IBOutlet weak var stopButton: UIButton!
    
 //  @IBOutlet weak var myVolumeViewParentView: UIView!
    
    @IBOutlet weak var volumeControlView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //myVolumeViewParentView.backgroundColor = UIColor(white: 1, alpha: 0.5)
  //     var wrapperView = UIView(frame: CGRectMake(30, 200, 260, 20))
    //    var volumeView = MPVolumeView(frame: wrapperView.bounds)
  // myVolumeViewParentView = MPVolumeView(frame: wrapperView.bounds)
     //   myVolumeViewParentView.addSubview(volumeView)
    
        
        
        stopButton.enabled = false
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePath, error: nil)
        audioPlayer.enableRate = true
        
         audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePath, error: nil)
        
        var wrapperView = UIView(frame: CGRectMake(20, 500, 260, 20))
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(wrapperView)
        
        var volumeView = MPVolumeView(frame: wrapperView.bounds)
        wrapperView.addSubview(volumeView)
        
        audioPlayer.play()
        audioPlayer.stop()
        audioEngine.stop()
        
        
        
     //   self.view.addSubview(volumeControlView)
   
        
  //var wrapperView = UIView(frame: CGRectMake(70, 600, 260, 20))
    //self.view.backgroundColor = UIColor.clearColor()
  // volumeControlView.backgroundColor = UIColor.clearColor()
    //   self.view.addSubview(wrapperView)
     // volumeControlView.addSubview(wrapperView)
        
  //  var volumeView = MPVolumeView(frame: wrapperView.bounds)
    
        
      // wrapperView.addSubview(volumeView)
      
 
        
            }
    
    @IBAction func playDistortionAudio(sender: AnyObject) {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        stopButton.enabled = true
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changeDistortionEffect = AVAudioUnitDistortion()
        changeDistortionEffect.loadFactoryPreset(AVAudioUnitDistortionPreset.MultiDecimated4)
        changeDistortionEffect.wetDryMix = 60
        
        audioEngine.attachNode(changeDistortionEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeDistortionEffect, format: nil)
        audioEngine.connect(changeDistortionEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
        
    }
    
    @IBAction func playReverbAudio(sender: AnyObject) {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        stopButton.enabled = true
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changeReverbEffect = AVAudioUnitReverb()
        changeReverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        changeReverbEffect.wetDryMix = 60
        
        audioEngine.attachNode(changeReverbEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeReverbEffect, format: nil)
        audioEngine.connect(changeReverbEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()

    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        stopButton.enabled = true
        
        var wrapperView = UIView(frame: CGRectMake(20, 500, 260, 20))
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(wrapperView)
        
        var volumeView = MPVolumeView(frame: wrapperView.bounds)
        wrapperView.addSubview(volumeView)
        
        
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
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
        audioEngine.stop()
        stopButton.enabled = false
    }
    
    
        }
    


