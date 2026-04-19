package extension.videoview;

#if android
import lime.system.JNI;
#end
import sys.FileSystem;
import sys.io.File;
import openfl.utils.Assets;
import haxe.io.Path;

/**
 * @author Saw (M.A. Jigsaw)
 * Modified by Joalor64
 */
class VideoView
{
	public static var onCompletion:Void->Void = null;
	public static var onPrepared:Void->Void = null;

	public static function playVideo(path:String = null):Void
	{
		var finalPath:String = resolvePath(path);

		#if android
		var _callbackFunc = JNI.createStaticMethod("extensions/videoview/VideoViewExtension", "setCallback", "(Lorg/haxe/lime/HaxeObject;)V");
		var _playVideo = JNI.createStaticMethod("extensions/videoview/VideoViewExtension", "playVideo", "(Ljava/lang/String;)V");

		_callbackFunc(new CallBack());
		_playVideo(finalPath);
		#end
	}

	private static function resolvePath(path:String):String
	{
		if (StringTools.startsWith(path, "http"))
			return path;

		#if android
		var libraryPath = path;
		var destination = Path.join([Sys.getCwd(), Path.withoutDirectory(path)]);

		if (!FileSystem.exists(destination))
		{
			var bytes = Assets.getBytes(libraryPath);
			if (bytes != null)
			{
				File.saveBytes(destination, bytes);
			}
		}
		return destination;
		#else
		return path;
		#end
	}
}

class CallBack
{
	public function new() {}

	public function onCompletion()
	{
		if (VideoView.onCompletion != null)
		{
			VideoView.onCompletion();
		}
	}

	public function onPrepared()
	{
		if (VideoView.onPrepared != null)
		{
			VideoView.onPrepared();
		}
	}
}
