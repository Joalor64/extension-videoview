# `extension-videoview`
![](https://img.shields.io/github/repo-size/Joalor64/extension-videoview) ![](https://badgen.net/github/open-issues/Joalor64/extension-videoview) ![](https://badgen.net/badge/license/MIT/green)

Basic native video support for Android in HaxeFlixel using Java VideoView.

## Installation
To install `extension-videoview`, follow these steps:
1. Install the latest stable version with this command:
	```
	haxelib install extension-videoview
	```

	You can also install through Git for the latest updates.
	```
	haxelib git extension-videoview https://github.com/Joalor64/extension-videoview
	```

2. Add this code to your `Project.xml`:
	```xml
	<haxelib name="extension-videoview" if="android" />
	```

## Usage Example
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
		VideoView.playVideo('assets/videos/$name.mp4'); // the video can be in any format (e.g., .webm, .mkv, .etc)
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

## Credits
* <a href = "https://github.com/MAJigsaw77">Mihai Alexandru (M.A. Jigsaw)</a> - Creator of **`extension-videoview`**
* <a href = "https://github.com/Joalor64">Joalor64</a> - Fixes and Adjustments