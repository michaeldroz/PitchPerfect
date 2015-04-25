    //
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Michael Droz on 4/11/15.
//  Copyright (c) 2015 Benefakter Apps. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingMessage: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        recordingMessage.text = "Tap to Record"
    
        
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
        
        pauseButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        
        if recordingMessage.text != "Tap to Continue Recording"
        {
            recordButton.enabled = false
            recordButton.hidden = false
            pauseButton.enabled = true
            pauseButton.hidden = false
            recordingMessage.text = "Now Recording"
            recordingMessage.hidden = false
            println("in recordAudio")
            stopButton.hidden = false
            stopButton.enabled = true
            
            let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            
            let currentDateTime = NSDate()
            let formatter = NSDateFormatter()
            formatter.dateFormat = "ddMMyyyy-HHmmss"
            let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
            let pathArray = [dirPath, recordingName]
            let filePath = NSURL.fileURLWithPathComponents(pathArray)
            println(filePath)
            
            var session = AVAudioSession.sharedInstance()
            session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
            
            audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            
        }
        //Restart Recording
        else {
            
            audioRecorder.record()
            pauseButton.enabled = true
            stopButton.hidden = false
            recordingMessage.hidden = false
            recordingMessage.text = "Now Recording"
            stopButton.enabled = true

        }
        
        
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            recordedAudio = RecordedAudio( filePath: recorder.url, title: recorder.url.lastPathComponent)
              
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else {
            println("recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
        }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data 
        }
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
        //recordingMessage.hidden = true
        stopButton.enabled = false
        recordingMessage.text = "Tap to Record"
       // recordButton.enabled = true
    }
    
    @IBAction func pauseAudio(sender: AnyObject) {
        
        audioRecorder.pause()
        recordButton.enabled = true
        recordingMessage.text = "Tap to Continue Recording"
        recordingMessage.hidden = false
        recordButton.hidden = false
        pauseButton.enabled = false
        println("in pausedAudio")
    }
    
    }

