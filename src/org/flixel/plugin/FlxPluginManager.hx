package org.flixel.plugin;
import org.flixel.FlxBasic;
import haxe.EnumFlags;
import org.flixel.plugin.FlxPlugin.FlxPluginFunctions;
import org.flixel.FlxU;

/**
 * ...
 * @author Pekka Heikkinen
 */
class FlxPluginManager extends FlxBasic
{
	
	private var preUpdatePlugins:Array<FlxPlugin>;
	private var postUpdatePlugins:Array<FlxPlugin>;
	private var drawPlugins:Array<FlxPlugin>;
	
	public function new() 
	{
		super();
		preUpdatePlugins = new Array<FlxPlugin>();
		postUpdatePlugins = new Array<FlxPlugin>();
		drawPlugins = new Array<FlxPlugin>();
	}
	
	/**
	 * Calls the specified function for each plugin
	 * @param	UpdateFunction
	 */
	public function updatePlugins(UpdateFunction:FlxPluginFunctions):Void
	{
		switch(UpdateFunction)
		{
			case FlxPluginFunctions.update:
				for (Plugin in preUpdatePlugins) {
					if (Plugin.exists && Plugin.active)
					{
						Plugin.update();
					}
				}
			case FlxPluginFunctions.postUpdate:
				for (Plugin in postUpdatePlugins) {
					if (Plugin.exists && Plugin.active)
					{
						Plugin.postUpdate();
					}
				}
			case FlxPluginFunctions.draw:
				for (Plugin in drawPlugins) {
					if (Plugin.exists && Plugin.active)
					{
						Plugin.draw();
					}
				}
		}
	}
	
	/**
	 * Add plugin to list
	 * @param	Plugin
	 * @return
	 */
	public function addPlugin(Plugin:FlxPlugin):FlxPlugin
	{
		var aFF:EnumFlags<EnumValue> = EnumFlags.ofInt(Plugin.activeFunctionFlags);
		
		if (aFF.has(FlxPluginFunctions.update))
		{
			if (FlxU.ArrayIndexOf(preUpdatePlugins, Plugin) == -1)
			{
				preUpdatePlugins.push(Plugin);
			}
		}
		else
		{
			preUpdatePlugins.remove(Plugin);
		}
		
		if (aFF.has(FlxPluginFunctions.postUpdate))
		{
			if (FlxU.ArrayIndexOf(postUpdatePlugins, Plugin) == -1)
			{
				postUpdatePlugins.push(Plugin);
			}
		}
		else
		{
			postUpdatePlugins.remove(Plugin);
		}
		
		if (aFF.has(FlxPluginFunctions.draw))
		{
			if (FlxU.ArrayIndexOf(drawPlugins, Plugin) == -1)
			{
				drawPlugins.push(Plugin);
			}
		}
		else
		{
			drawPlugins.remove(Plugin);
		}
		
		return Plugin;
	}
	
	/**
	 * Remove plugin from list
	 * @param	Plugin
	 * @return
	 */
	public function removePlugin(Plugin:FlxPlugin):FlxPlugin
	{
		preUpdatePlugins.remove(Plugin);
		postUpdatePlugins.remove(Plugin);
		drawPlugins.remove(Plugin);
		return Plugin;
	}
	
	/**
	 * Get plugin by class
	 * @param	ClassType
	 * @return
	 */
	public function getPlugin(ClassType:Class<FlxBasic>):FlxBasic
	{
		for (Plugin in preUpdatePlugins)
		{
			if (Std.is(Plugin, ClassType))
			{
				return Plugin;
			}
		}
		
		for (Plugin in postUpdatePlugins)
		{
			if (Std.is(Plugin, ClassType))
			{
				return Plugin;
			}
		}
		
		for (Plugin in drawPlugins)
		{
			if (Std.is(Plugin, ClassType))
			{
				return Plugin;
			}
		}
		
		return null;
	}
	
}