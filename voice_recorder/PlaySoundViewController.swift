//
//  PlaySoundViewController.swift
//  voice_recorder
//
//  Created by Babar Bashir on 11/6/15.
//  Copyright © 2015 appstar. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    
    
    
    @IBAction func playSlowSounds(sender: AnyObject) {
        //TODO Playsounds slow
        
        //AVAudioPlayer audioPlayer = AVAudioPlayer(data: NSData)
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.play()
        
    }
    
    
    
    //fast play button
    
    @IBAction func playFastSounds(sender: AnyObject) {
       
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.play()
        
        
    }
    
    
    //stop playing all audio
    
    
    @IBAction func stopPlayingAudio(sender: AnyObject) {
        
        audioPlayer.stop()
        
    }
    
    
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        
        
        playAudioWithVariablePitch(1000)
        
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        var audioPlayerNode = AVAudioPlayerNode()
        
        audioEngine.attachNode(audioPlayerNode)
        
        
        var changePitchEffect = AVAudioUnitTimePitch()
        
        changePitchEffect.pitch = pitch
        
        audioEngine.attachNode(changePitchEffect)
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do{
            try audioEngine.start()
            audioPlayerNode.play()
            
        } catch  {
            
        }
        
        
        
        
        
    }
    
    
    
    //play darthvader
    
    
    @IBAction func playDarthvaderAudio(sender: AnyObject) {
        
        playAudioWithVariablePitch(-1000)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*
        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            let filePathUrl = NSURL.fileURLWithPath(filePath)
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl)
                audioPlayer.enableRate = true
            } catch {
                
                print ("error loading sound")
                
            }
            
        }  //get the filepath if

*/
        
        audioEngine = AVAudioEngine()
       
        
        do {
            try audioFile=AVAudioFile(forReading: receivedAudio.filePathUrl)
            try audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
            audioPlayer.enableRate = true
        } catch {
            
            print ("error loading sound")
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
