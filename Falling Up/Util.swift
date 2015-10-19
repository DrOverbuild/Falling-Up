import AVFoundation

let gravity = CGFloat(0.98)

var backgroundMusicPlayer: AVAudioPlayer!

func playBackgroundMusic(filename: String) {
	let url = NSBundle.mainBundle().URLForResource(
		filename, withExtension: nil)
	if (url == nil) {
		print("Could not find file: \(filename)")
		return
	}
	
	backgroundMusicPlayer = try? AVAudioPlayer(contentsOfURL: url!)
	
	if backgroundMusicPlayer == nil {
		print("Could not create audio player")
		return
	}
 
	backgroundMusicPlayer.numberOfLoops = -1
	backgroundMusicPlayer.volume = 0.5
	backgroundMusicPlayer.prepareToPlay()
	backgroundMusicPlayer.play()
}