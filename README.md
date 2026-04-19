# `extension-videoview`
Basic native video support for Android in HaxeFlixel using Java VideoView.

## Credits
* <a href = "https://github.com/MAJigsaw77">Mihai Alexandru (M.A. Jigsaw)</a> - Creator of **`extension-videoview`**
* <a href = "https://github.com/Joalor64">Joalor64</a> - Fixes and Adjustments

## Example of How to Use It
```haxe
#if android
import extension.videoview.VideoView;
#end
import flixel.FlxBasic;

class VideoPlayer extends FlxBasic
{
	public var finishCallback:Void->Void = null;

	public function new(name:String)
	{
		super();

		#if android
		VideoView.playVideo('assets/videos/video.mp4'); // the video can be in any format (e.g., .webm, .mkv, .etc)
		VideoView.onCompletion = function()
		{
			if (finishCallback != null)
			{
				finishCallback();
			}
		}
		#end
	}
}
```

By the way, this extension can also run videos from the web browser.