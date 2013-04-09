package org.flixel.plugin;

import org.flixel.FlxObject;

/**
 * ...
 * @author Pekka Heikkinen
 */
class PluginManager
{
	
	private var preUpdatePlugins:Array<IPluginUpdate>;
	private var postUpdatePlugins:Array<IPluginPostUpdate>;
	private var drawPlugins:Array<IPluginDraw>;
	
	public function new() 
	{
		preUpdatePlugins = new Array<IPluginUpdate>();
		postUpdatePlugins = new Array<IPluginPostUpdate>();
		drawPlugins = new Array<IPluginDraw>();
	}
	
	public function add(Plugin:FlxObject):FlxObject
	{
		if (Std.is(Plugin, IPlugin))
		{
			if (Std.is(Plugin, IPluginUpdate))
			{
				preUpdatePlugins.push(cast(Plugin, IPluginUpdate));
			}
			
			if (Std.is(Plugin, IPluginPostUpdate))
			{
				postUpdatePlugins.push(cast(Plugin, IPluginPostUpdate));
			}
			
			if (Std.is(Plugin, IPluginDraw))
			{
				drawPlugins.push(cast(Plugin, IPluginDraw));
			}
		}
		else
		{
			var wrapper:PluginWrapper = new PluginWrapper(Plugin);
			preUpdatePlugins.push(wrapper);
			drawPlugins.push(wrapper);
		}
		
		return Plugin;
	}
	
	public function preUpdate():Void
	{
		for (Plugin in preUpdatePlugins)
		{
			if (Plugin.exists && Plugin.alive)
			{				
				Plugin.update();
			}
		}
	}
	
	public function postUpdate():Void
	{
		for (Plugin in postUpdatePlugins)
		{
			if (Plugin.exists && Plugin.alive)
			{	
				Plugin.postUpdate();
			}
		}
	}
	
	public function postDraw():Void
	{
		for (Plugin in drawPlugins)
		{
			if (Plugin.exists && Plugin.alive)
			{	
				Plugin.draw();
			}
		}
	}
	
}

/**
 * Wrapper class for legacy plugins
 */
class PluginWrapper implements IPluginUpdate, implements IPluginDraw
{
	private var plugin:FlxObject;
	
	public var exists:Bool = true;
	public var alive:Bool = true;
	
	public function new(PluginObject:FlxObject)
	{
		plugin = PluginObject;
	}
	
	public function update():Void
	{
		if (plugin.exists && plugin.alive)
		{
			plugin.update();
		}
	}
	
	public function draw():Void
	{
		if (plugin.exists && plugin.alive)
		{
			plugin.draw();
		}
	}
}


interface IPluginUpdate implements IPlugin
{
	public function update():Void;
}

interface IPluginPostUpdate implements IPlugin
{
	public function postUpdate():Void;
}

interface IPluginDraw implements IPlugin
{
	public function draw():Void;
}

interface IPlugin
{
	var exists:Bool;
	var alive:Bool;
}