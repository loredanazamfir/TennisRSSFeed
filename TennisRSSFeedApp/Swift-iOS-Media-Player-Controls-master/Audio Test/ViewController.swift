//
//  ViewController.swift
//  Audio Test
//
//  Created by Justin Doan on 4/25/15.
//  Copyright (c) 2015 Justin Doan. All rights reserved.

import UIKit
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    let mp = MPMusicPlayerController.systemMusicPlayer()
    
    var timer = Timer()
    
    var mediapicker1: MPMediaPickerController!
    
    @IBOutlet var imageAlbum: UIImageView!
    @IBOutlet weak var labelTitle: UILabel! //Above slider
    @IBOutlet weak var labelElapsed: UILabel! //Left of slider
    @IBOutlet weak var labelDuration: UILabel! //Below Slider
    @IBOutlet weak var labelRemaining: UILabel! // Right of slider
    @IBOutlet var sliderTime: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //calls timer and related functions when view is first loaded to avoiding waiting for playback change notificaitons
        mp.prepareToPlay()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.timerFired(_:)), userInfo: nil, repeats: true)
        self.timer.tolerance = 0.1
        
        // Add a notification observer for MPMusicPlayerControllerNowPlayingItemDidChangeNotification that fires a method when the track changes (to update track info label)
        mp.beginGeneratingPlaybackNotifications()
        
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.updateNowPlayingInfo), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        
        //Declare media picker for later display
        let mediaPicker: MPMediaPickerController = MPMediaPickerController.self(mediaTypes:MPMediaType.music)
        mediaPicker.allowsPickingMultipleItems = true
        mediapicker1 = mediaPicker
        mediaPicker.delegate = self
        
        
    }
    
    //Function to pull track info and update labels
    func timerFired(_:AnyObject) {
    
        //Ensure the track exists before pulling the info
        if let currentTrack = MPMusicPlayerController.systemMusicPlayer().nowPlayingItem {
        
            //pull artist and title for current track and show in labelTitle
            let trackName = currentTrack.title!
            
            let trackArtist = currentTrack.artist!
            
            labelTitle.text = "\(trackArtist) - \(trackName)"
            
            //set image to Album Artwork
            let albumImage = currentTrack.artwork?.image(at: imageAlbum.bounds.size)
            
            imageAlbum.image = albumImage
            
            //Pull length of current track in seconds
            //let trackDuration = currentTrack.valueForProperty(MPMediaItemPropertyPlaybackDuration) as! Int
            let trackDuration = currentTrack.playbackDuration
            
            //Convert length in seconds to length in minutes as an Int. Ex. 245 second song is 4.08333 minutes (4:05), this results in 4
            let trackDurationMinutes = Int(trackDuration / 60)
            
            //Find the remainder from the previous equation. 245 / 60 is 4 with a remainder of 5. This results in 5
            let trackDurationSeconds = Int(trackDuration.truncatingRemainder(dividingBy: 60))
            
            //Create the lable for the length of the song. BUT a 4 minute long song with a 5 second remainder would show as "4:5" so..
            if trackDurationSeconds < 10 {
                
                //add a 0 if the number of seconds is less than 10
                labelDuration.text = "Length: \(trackDurationMinutes):0\(trackDurationSeconds)"
                
            } else {
                
                //if more than 10, display as is
                labelDuration.text = "Length: \(trackDurationMinutes):\(trackDurationSeconds)"
            }
            
            //Find elapsed time by pulling currentPlaybackTime
            let trackElapsed = mp.currentPlaybackTime
            
            // avoid crash
            if trackElapsed.isNaN
            {
                return
            }
            
            //Repeat same steps to display the elapsed time as we did with the duration
            let trackElapsedMinutes = Int(trackElapsed / 60)
            
            let trackElapsedSeconds = Int(trackElapsed.truncatingRemainder(dividingBy: 60))
            
            if trackElapsedSeconds < 10 {
                
                labelElapsed.text = "Elapsed: \(trackElapsedMinutes):0\(trackElapsedSeconds)"
                
            } else {
                
                labelElapsed.text = "Elapsed: \(trackElapsedMinutes):\(trackElapsedSeconds)"
                
            }
            
            //Find remaining time by subtraction the elapsed time from the duration
            let trackRemaining = Int(trackDuration) - Int(trackElapsed)
            
            //Repeat same steps to display remaining time
            let trackRemainingMinutes = trackRemaining / 60
            
            let trackRemainingSeconds = trackRemaining % 60
            
            if trackRemainingSeconds < 10 {
                labelRemaining.text = "Remaining: \(trackRemainingMinutes):0\(trackRemainingSeconds)"
            } else {
                labelRemaining.text = "Remaining: \(trackRemainingMinutes):\(trackRemainingSeconds)"
            }
            
            //set maximum value of the slider
            sliderTime.maximumValue = Float(trackDuration)
            
            //changes slider to as song progresses
            sliderTime.value = Float(trackElapsed)
            
        }
        
    }
    
    // Create function to change labels to current track info based on previous notification observer
    func updateNowPlayingInfo(){
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.timerFired(_:)), userInfo: nil, repeats: true)
        self.timer.tolerance = 0.1
        
    }
    
    //Function to make adjusting the slider move through the song.
    @IBAction func sliderTimeChanged(_ sender: AnyObject) {
        mp.currentPlaybackTime = TimeInterval(sliderTime.value)
    }
    
    //Button functions -- I'm pretty sure these are self explanatory enough
    @IBAction func buttonPlay(_ sender: AnyObject) {
        mp.play()
    }
    
    @IBAction func buttonPause(_ sender: AnyObject) {
        mp.pause()
    }
    
    @IBAction func buttonPrevious(_ sender: AnyObject) {
        mp.skipToPreviousItem()
    }
    
    @IBAction func buttonBeginning(_ sender: AnyObject) {
        mp.skipToBeginning()
    }
    
    @IBAction func buttonNext(_ sender: AnyObject) {
        mp.skipToNextItem()
    }
    
    
    //Display the user's internal iPod library
    @IBAction func buttonPick(_ sender: AnyObject) {
        self.present(mediapicker1, animated: true, completion: nil)
    }
    
    //
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        self.dismiss(animated: true, completion: nil)
        let selectedSongs = mediaItemCollection
        
        mp.setQueue(with: selectedSongs)
        mp.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

