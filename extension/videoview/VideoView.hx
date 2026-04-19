package extension.videoview;

#if android
import lime.system.JNI;
#end
import sys.FileSystem;
import sys.io.File;
import openfl.utils.Assets;
import haxe.io.Path;

/**
 * A simple video player extension for Android.
 * @author Saw (M.A. Jigsaw)
 * Modified by Joalor64
 */
class VideoView
{
	/**
	 * Callback function for when the video playback is completed.
	 */
	public static var onCompletion:Void->Void = null;

	/**
	 * Callback function for when the video is ready to play.
	 */
	public static var onPrepared:Void->Void = null;

	/**
	 * Plays a video from a specified path. The path can be a local file path or a URL.
	 * @param path The path to the video file, if it exists.
	 */
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

	/**
	 * Resolves the video path.
	 * @param path The original path to the video file.
	 * @return String The resolved path to the video file, which can be used for playback.
	 */
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

/**
 * A callback class to handle video playback events.
 */
class CallBack
{
	public function new() {}

	/**
	 * Called when the video playback is completed.
	 */
	public function onCompletion():Void
	{
		if (VideoView.onCompletion != null)
		{
			VideoView.onCompletion();
		}
	}

	/**
	 * Called when the video is ready to play.
	 */
	public function onPrepared():Void
	{
		if (VideoView.onPrepared != null)
		{
			VideoView.onPrepared();
		}
	}
}
