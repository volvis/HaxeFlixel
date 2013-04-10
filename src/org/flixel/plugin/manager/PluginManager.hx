package org.flixel.plugin.manager;

import org.flixel.FlxObject;
import org.flixel.FlxU;

/**
 * ...
 * @author Pekka Heikkinen
 */

typedef PluginUpdateDef = {
	var alive:Bool;
	var exists:Bool;
	function update():Void;
}

typedef PluginPostUpdateDef = {
	var alive:Bool;
	var exists:Bool;
	function postUpdate():Void;
}

typedef PluginPreDrawDef = {
	var alive:Bool;
	var exists:Bool;
	function draw():Void;
}

interface IPlugin
{
	var exists:Bool;
	var alive:Bool;
}
 
class PluginManager
{
	
	private var preUpdatePlugins:Array<PluginUpdateDef>;
	private var postUpdatePlugins:Array<PluginPostUpdateDef>;
	private var drawPlugins:Array<PluginPreDrawDef>;
	
	public function new() 
	{
		preUpdatePlugins  = new Array<PluginUpdateDef>();
		postUpdatePlugins = new Array<PluginPostUpdateDef>();
		drawPlugins       = new Array<PluginPreDrawDef>();
	}
	
	/**
	 * Adds a plugin to the list.
	 * If the plugin implements any of the plugin interfaces (IPluginUpdate,
	 * IPluginPostUpdate, IPluginDraw), only those specified functions
	 * will be called each pass.
	 * 
	 * @param	Plugin
	 * @return	The same plugin
	 */
	public function add(Plugin:FlxObject):FlxObject
	{
		if (Std.is(Plugin, IPlugin))
		{
			if (Std.is(Plugin, IPluginUpdate) && FlxU.ArrayIndexOf(preUpdatePlugins, Plugin) == -1)
			{
				preUpdatePlugins.push(Plugin);
			}
			
			if (Std.is(Plugin, IPluginPostUpdate) && FlxU.ArrayIndexOf(postUpdatePlugins, Plugin) == -1)
			{
				postUpdatePlugins.push(Plugin);
			}
			
			if (Std.is(Plugin, IPluginDraw) && FlxU.ArrayIndexOf(drawPlugins, Plugin) == -1)
			{
				drawPlugins.push(Plugin);
			}
		}
		else
		{
			if (FlxU.ArrayIndexOf(preUpdatePlugins, Plugin) == -1)
			{
				preUpdatePlugins.push(Plugin);
				drawPlugins.push(Plugin);
			}
		}
		
		return Plugin;
	}
	
	/**
	 * Removes plugin from the list
	 * @param	Plugin
	 * @return	The same plugin
	 */
	public function remove(?Plugin:FlxObject, ?PluginClass:Class<FlxObject>):FlxObject
	{
		if (Plugin == null && PluginClass != null)
		{
			Plugin = get(PluginClass);
		}
		if (Plugin != null)
		{
			preUpdatePlugins.remove(Plugin);
			drawPlugins.remove(Plugin);
			
			// postUpdate() call may become deprecated at some point so we need to check for it
			if (Std.is(Plugin, IPluginPostUpdate))
			{			
				postUpdatePlugins.remove(Plugin);
			}
			
			return Plugin;
		}
		return null;
	}
	
	/**
	 * Gets a plugin by class
	 * @param	PluginClass
	 * @return	FlxObject or null
	 */
	public function get(PluginClass:Class<FlxObject>):FlxObject
	{
		for (Plugin in preUpdatePlugins)
		{
			if (PluginClass == Type.getClass(cast(Plugin, FlxObject)))
			{
				return cast(Plugin, FlxObject);
			}
		}
		for (Plugin in postUpdatePlugins)
		{
			if (PluginClass == Type.getClass(cast(Plugin, FlxObject)))
			{
				return cast(Plugin, FlxObject);
			}
		}
		for (Plugin in drawPlugins)
		{
			if (PluginClass == Type.getClass(cast(Plugin, FlxObject)))
			{
				return cast(Plugin, FlxObject);
			}
		}
		return null;
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


