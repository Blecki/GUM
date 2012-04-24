package gum.FlashPunk 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import gum.UIItem;
	import net.flashpunk.Graphic;
	/**
	 * ...
	 * @author AJC
	 */
	public dynamic class GraphicControl extends UIItem
	{
		var graphic:Graphic = null;
		
		public function GraphicControl(rect:Rectangle, graphic:Graphic) 
		{
			this.graphic = graphic;
			super(rect);
		}
		
		override public function Render(parentBuffer:BitmapData, xOffset:int, yOffset:int):void 
		{
			graphic.render(parentBuffer, mtPoint1(rect.x + xOffset, rect.y + yOffset), _pZero);
		}
		
	}

}