import openfl.events.IOErrorEvent;
import openfl.events.Event;
import openfl.net.FileReference;
import openfl.net.FileFilter;

using StringTools;

class WorldSaves
{
	public static final FF_STRING_WORLD:FileFilter = new FileFilter("String World File (.txt)", "*.txt");

	public static function saveStringWorld()
	{
		final world = World.generateWorldString();

		writeFileReference(FF_STRING_WORLD.extension.replace('*', 'Onrev_world'), world, function(str)
		{
			trace(str);
		});

		trace('Saved String World');
	}

	public static function loadStringWorld()
	{
		browseFileReference([FF_STRING_WORLD], function(reference)
		{
			final world = reference.data.toString();

			PlayState.instance.blocks.clear();
			World.parseWorldString(world);
			PlayState.reloadPlayer();

			trace('Loaded StringWorld File: ${reference.name}');
		});
	}

	/**
		Yoinked from FNF FileUtil with modifs made
	**/
	/**
	 * Browse for a file to read and execute a callback once we have a file reference.
	 * Works great on HTML5 or desktop.
	 *
	 * @param	callback The function to call when the file is loaded.
	 */
	public static function browseFileReference(filters:Array<FileFilter>, callback:(FileReference) -> Void):Void
	{
		var file = new FileReference();
		file.addEventListener(Event.SELECT, function(e)
		{
			var selectedFileRef:FileReference = e.target;
			trace('Selected file: ' + selectedFileRef.name);

			selectedFileRef.addEventListener(Event.COMPLETE, function(e)
			{
				var loadedFileRef:FileReference = e.target;
				trace('Loaded file: ' + loadedFileRef.name);

				callback(loadedFileRef);
			});

			selectedFileRef.load();
		});

		file.browse(filters);
	}

	/**
	 * Prompts the user to save a file to their computer.
	 */
	public static function writeFileReference(path:String, data:String, callback:String->Void)
	{
		var file = new FileReference();

		file.addEventListener(Event.COMPLETE, function(e:Event)
		{
			trace('Successfully wrote file: "$path"');
			callback("success");
		});

		file.addEventListener(Event.CANCEL, function(e:Event)
		{
			trace('Cancelled writing file: "$path"');
			callback("info");
		});

		file.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent)
		{
			trace('IO error writing file: "$path"');
			callback("error");
		});

		file.save(data, path);
	}
}
