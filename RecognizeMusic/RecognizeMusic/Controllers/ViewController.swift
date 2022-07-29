//
//  ViewController.swift
//  RecognizeMusic
//
//  Created by CDI on 7/29/22.
//

import UIKit
import ShazamKit

class ViewController: UIViewController, SHSessionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recognizeSong()
    }
    
    private func recognizeSong() {
        // session
        let session = SHSession()
        
        // delegate
        session.delegate = self
        
        do {
            // get track
            guard let url = Bundle.main.url(forResource: "godsplan", withExtension: "mp3") else {
                print("Failed to get song url")
                return
            }
            // create audio file
            let file = try AVAudioFile(forReading: url)
            
            // audio -> buffer
            guard let buffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: AVAudioFrameCount(file.length / 20)) else {
                print("Failed to create buffer")
                return
            }
            try file.read(into: buffer)
            
            // signature generator
            let generator = SHSignatureGenerator()
            try generator.append(buffer, at: nil)
            
            // create signature
            let signature = generator.signature()
            
            // try to match
            session.match(signature)
        } catch {
            print("error: \(error.localizedDescription)")
        }
        
        
    }
    
    func session(_ session: SHSession, didFind match: SHMatch) {
        // get results
        let 
    }
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        if let error = error {
            print("error didNotFindMatchFor: \(error)")
        }
    }
    


}

