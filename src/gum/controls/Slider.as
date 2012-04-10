package gum.controls
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import gum.*;
	
	/**
	 * ...
	 * @author AJC
	 */
	public dynamic class Slider extends UIItem
	{
		
		public var minimum:int = 0;
		public var maximum:int = 10;
		public var step:int = 1;
		private var _position:int = 0;
		public var orientation:int = HORIZONTAL;
		private var mouseStart:int = 0;
		private var startPosition:int = 0;
		private var draggingHandle:Boolean = false;
		
		public function Slider(rect:Rectangle, properties:Object) 
		{
			super(rect, properties);
			
			position = minimum;
		}
		
		public function get position():int { return _position; }
		public function set position(p:int):void { _position = p; if (this.OnSlide != null) this.OnSlide(this); }
		
		private function get size():int
		{
			if (orientation == HORIZONTAL) return rect.width - skin.sliderHandleSize;
			if (orientation == VERTICAL) return rect.height - skin.sliderHandleSize;
			return 0;
		}
		
		private function get spaces():int
		{
			return (maximum - minimum) / step;
		}
		
		private function get spaceSize():Number
		{
			return size / spaces;
		}
		
		public function handlePosition():int
		{
			return ( ((position - minimum) / step) * spaceSize) + (skin.sliderHandleSize / 2);
		}
		
		override public function Update(input:UIInput):void 
		{
			if (rect.contains(input.mouseX, input.mouseY)) input.cursor = "button";
			
			if (input.mousePressed)
			{
				if (rect.contains(input.mouseX, input.mouseY))
				{
					var mouseOffset:int = 0;
					
					if (orientation == HORIZONTAL)
					{
						mouseOffset = input.mouseX - rect.x - (skin.sliderHandleSize / 2);
						mouseStart = input.mouseX;
					}
					else
					{
						mouseOffset = input.mouseY - rect.y - (skin.sliderHandleSize / 2);
						mouseStart = input.mouseY;
					}
					
					var hitPlace:Number = mouseOffset + (spaceSize / 2);
					var hitSpace:Number = hitPlace / spaceSize;
					position = minimum + (hitSpace * step);	

					draggingHandle = true;
					startPosition = position;
				}
			}
			if (input.mouseDown && draggingHandle)
			{
				var mouseDelta:int = 0;
				if (orientation == HORIZONTAL) mouseDelta = input.mouseX - mouseStart;
				if (orientation == VERTICAL) mouseDelta = input.mouseY - mouseStart;
				
				var stepsPassed:Number = mouseDelta / spaceSize;
				position = startPosition + (stepsPassed * step);
				
				if (position < minimum) position = minimum;
				if (position > maximum) position = maximum;
			}
			if (input.mouseUp)
			{
				draggingHandle = false;
			}
		}
		
		override public function Render(parentBuffer:BitmapData, xOffset:int, yOffset:int):void 
		{
			skin.DrawSlider(parentBuffer, xOffset, yOffset, this);
		}
		
	}

}