//
//  AudioSettingsViewController.swift
//  Pitch Perfect
//
//  Created by Michael Droz on 4/18/15.
//  Copyright (c) 2015 Benefakter Apps. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class AudioSettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var wrapperView = UIView(frame: CGRectMake(20, 200, 260, 20))
        self.view.backgroundColor = UIColor.clearColor()
        self.view.addSubview(wrapperView)
        
        var volumeView = MPVolumeView(frame: wrapperView.bounds)
        wrapperView.addSubview(volumeView)
        
        
    }
    
}