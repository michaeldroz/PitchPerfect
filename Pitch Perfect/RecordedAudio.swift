//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Michael Droz on 4/11/15.
//  Copyright (c) 2015 Benefakter Apps. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePath: NSURL!
    var title: String!
    
    init(filePath: NSURL, title: String) {
        
        self.filePath = filePath
        self.title = title
    }
    
}