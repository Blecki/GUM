package gum.controls
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import gum.*;
	
	/**
	 * ...
	 * @author AJC
	 */
	public dynamic class ProgressBar extends UIItem
	{
		public var percentage:Number = 0;
		
		public function ProgressBar(rect:Rectangle, properties:Object) 
		{
			super(rect, properties);
		}
		
		override public function Render(parentBuffer:BitmapData, xOffset:int, yOffset:int):void 
		{
			skin.DrawProgressBar(parentBuffer, xOffset, yOffset, this);
		}
		
	}

}