package gum.controls
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import gum.*;
	
	/**
	 * A UIItem that blits it's children to it's own internal buffer, then blits this buffer to it's parent.
	 */
	public dynamic class Panel extends UIItem
	{
		public var buffer:BitmapData = null;
		
		public function Panel(rect:Rectangle, properties:Object = null) 
		{
			buffer = new BitmapData(rect.width, rect.height, true, 0xFFFFFFFF);
			
			super(rect, properties);
		}
		
		override public function Update(input:UIInput):void
		{
			super.Update(input);
			
			var saveX:int = input.mouseX;
			var saveY:int = input.mouseY;
			
			input.mouseX -= rect.x;
			input.mouseY -= rect.y;
			
			for each (var child:UIItem in children.slice())
				child.Update(input);
				
			input.mouseX = saveX;
			input.mouseY = saveY;
		}
		
		override public function Render(parentBuffer:BitmapData, xOffset:int, yOffset:int):void 
		{
			skin.DrawElementBackground(buffer, new Rectangle(0, 0, buffer.width, buffer.height), 0, 0);
			
			for (var i:int = 0; i < children.length; ++i)
				children[i].Render(buffer, 0, 0);
				
			if (parentBuffer != null)
				parentBuffer.copyPixels(buffer, new Rectangle(0, 0, buffer.width, buffer.height), new Point(rect.x, rect.y));
				
			
		}
		
	}

}