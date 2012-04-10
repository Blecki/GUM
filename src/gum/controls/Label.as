package gum.controls
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import gum.*;
	/**
	 * ...
	 * @author AJC
	 */
	public dynamic class Label extends UIItem
	{
		public var hover:Boolean = false;
		
		public function Label(
			rect:Rectangle, 
			properties:Object = null) 
		{
			super(rect, properties);
		}
		
		override public function Render(parentBuffer:BitmapData, xOffset:int, yOffset:int):void 
		{
			skin.DrawLabel(parentBuffer, xOffset, yOffset, this);
		}
		
	}

}