package org.flixel.plugin;

import org.flixel.FlxObject;
import org.flixel.plugin.PluginManager;
import org.flixel.plugin.PluginManager.IPluginUpdate;
import org.flixel.plugin.PluginManager.IPluginPostUpdate;
import org.flixel.plugin.PluginManager.IPluginDraw;

/**
 * ...
 * @author Pekka Heikkinen
 */
class TestPlugin extends FlxObject, implements IPluginPostUpdate, implements IPluginDraw
{

	public function new() 
	{
		super();
	}
	
	override public function update():Void
	{
		trace('this never gets called');
	}
	
	override public function postUpdate():Void
	{
		trace('postUpdate');
	}
	
	override public function draw():Void
	{
		trace('draw');
	}
	
}