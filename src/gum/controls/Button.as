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
	public dynamic class Button extends UIItem
	{
		public var hover:Boolean = false;
		
		public function Button(
			rect:Rectangle, 
			properties:Object = null) 
		{
			super(rect, properties);
		}
		
		override public function Update(input:UIInput):void 
		{
			hover = rect.containsPoint(new Point(input.mouseX, input.mouseY));
			if (hover) input.cursor = "button";
			if (hover && input.mousePressed && this.OnClick != null) this.OnClick(this);
			super.Update(input);
		}
		
		override public function Render(parentBuffer:BitmapData, xOffset:int, yOffset:int):void 
		{
			skin.DrawButton(parentBuffer, xOffset, yOffset, this);
		}
		
	}

}