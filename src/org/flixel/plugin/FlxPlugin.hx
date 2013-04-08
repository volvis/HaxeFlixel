package org.flixel.plugin;

import org.flixel.FlxBasic;
import haxe.EnumFlags;

/**
 * Base class for plugins
 * @author Pekka Heikkinen
 */
class FlxPlugin extends FlxBasic, implements IFlxPlugin
{
	/**
	 * Binary flags for functions that get called each pass.
	 */
	public var activeFunctionFlags:Int = 0;
	
	public function new()
	{
		super();
		
		activatePluginFunction(FlxPluginFunctions.update);
		activatePluginFunction(FlxPluginFunctions.draw);
	}
	
	/**
	 * Set specified function active and to be called each pass
	 * @param	FunctionType
	 */
	private function activatePluginFunction(FunctionType:FlxPluginFunctions):Void
	{
		var aFF:EnumFlags<EnumValue> = EnumFlags.ofInt(activeFunctionFlags);
		aFF.set(FunctionType);
		activeFunctionFlags = aFF.toInt();
	}
	
	/**
	 * Remove specified function kind
	 * @param	FunctionType
	 */
	private function deactivatePluginFunction(FunctionType:FlxPluginFunctions):Void
	{
		var aFF:EnumFlags<EnumValue> = EnumFlags.ofInt(activeFunctionFlags);
		aFF.unset(FunctionType);
		activeFunctionFlags = aFF.toInt();
	}
	
}

interface IFlxPlugin
{
	public var activeFunctionFlags:Int;
	public function update():Void;
	public function postUpdate():Void;
	public function draw():Void;
}

enum FlxPluginFunctions
{
	update;
	postUpdate;
	draw;
}