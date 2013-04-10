package org.flixel.plugin.manager;

import PluginManager.IPlugin;
interface IPluginPostUpdate implements IPlugin
{
	public function postUpdate():Void;
}