//
//  ViewController.swift
//  voice_recorder
//
//  Created by Babar Bashir on 10/30/15.
//  Copyright (c) 2015 appstar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    
    let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),
        AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),
        AVNumberOfChannelsKey : NSNumber(int: 1),
        AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))]
    
    
    
    @IBOutlet weak var recordingInProgress: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewDidAppear(animated: Bool) {
        //hide the label and stop button here
        
        stopButton.hidden = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(sender: AnyObject) {
        recordingInProgress.hidden = false
        
        recordButton.enabled = false
        
        stopButton.hidden = false
        
        //Record audio here
        let dirPath=NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        //let currentDateTime = NSDate()
        //let formatter = NSDateFormatter()
        
        //formatter.dateFormat="ddMMyyyy-HHmmss"
        
        let recordingName = "my_audio.m4a" //formatter.stringFromDate(currentDateTime) + ".m4a"
        
        
        
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        //print(filePath)
        
        //setup audio session
        let session = AVAudioSession.sharedInstance()
        do {
        try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            print("error is setting session")
            
        }
        //Initiate and prepare the recorder
        
        do{
            //print ("Recording to start====")
        
        try audioRecorder = AVAudioRecorder(URL: filePath!, settings: recordSettings)
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            
            //print ("Recording to end=====")
        
        } catch{
              print ("error in initiating & preparing audio recording")
        }
        
        
        
        
        
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
        recordedAudio = RecordedAudio()
        recordedAudio.filePathUrl = recorder.url
        recordedAudio.title = recorder.url.lastPathComponent
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            
            print("Recording was not successful!!")
            
            recordButton.enabled = false
            stopButton.hidden = true
            
        }
    }
    
    
    
    //prepare segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="stopRecording"){
            let playSoundVC:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            
            
            let data = sender as! RecordedAudio
            playSoundVC.receivedAudio = data
            
            
            
        }
        
    }
    
    @IBAction func stopRecordingAudio(sender: AnyObject) {
        
        recordingInProgress.hidden = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        
        do{
        try audioSession.setActive(false)
        }catch {
            
        }
        
        
    }
    
    
}

