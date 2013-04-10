package org.flixel.plugin;

import org.flixel.FlxObject;
import org.flixel.plugin.manager.PluginManager;
import org.flixel.plugin.manager.IPluginUpdate;
import org.flixel.plugin.manager.IPluginPostUpdate;
import org.flixel.plugin.manager.IPluginDraw;

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