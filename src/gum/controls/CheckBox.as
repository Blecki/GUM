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
	public dynamic class CheckBox extends UIItem
	{
		public var hover:Boolean = false;
		public var checked:Boolean = false;
		
		public function CheckBox(
			rect:Rectangle, 
			properties:Object = null) 
		{
			super(rect, properties);
			
			if (this.radioSet != null) this.radioSet.buttons.push(this);
		}
		
		override public function Update(input:UIInput):void 
		{
			hover = rect.containsPoint(new Point(input.mouseX, input.mouseY));
			if (hover) input.cursor = "button";
			if (hover && input.mousePressed) 
			{
				if (this.radioSet != null)
				{
					if (checked == false)
					{
						for each (var checkBox:CheckBox in this.radioSet.buttons)
							checkBox.checked = false;
						checked = true;
					}
				}
				else
					checked = !checked;
			}
			
			super.Update(input);
		}
		
		override public function Render(parentBuffer:BitmapData, xOffset:int, yOffset:int):void 
		{
			skin.DrawCheckBox(parentBuffer, xOffset, yOffset, this);
		}
		
	}

}