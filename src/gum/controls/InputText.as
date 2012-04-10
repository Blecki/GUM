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
	public dynamic class InputText extends UIItem
	{
		public var hover:Boolean = false;
		public var inputField:TextField = null;
		
		public function InputText(
			rect:Rectangle, 
			properties:Object = null) 
		{
			super(rect, properties);
		}
		
		override public function OnAdded():void 
		{
			inputField = new TextField();
			inputField.type = (this.readonly == true) ? "dynamic" : "input";
			inputField.width = rect.width;
			if (this.multiline == true) inputField.multiline = true;
			if (this.text != null) inputField.text = this.text;
			if (this.wordwrap == true) inputField.wordWrap = true;
			
		}
		
		public function GetText():String { return inputField.text; }
		
		override public function Update(input:UIInput):void 
		{
			if (rect.contains(input.mouseX, input.mouseY))
			{
				input.cursor = "ibeam";
				if (input.mousePressed)
					stage.focus = inputField;
			}
		}
		
		override public function Render(parentBuffer:BitmapData, xOffset:int, yOffset:int):void 
		{
			skin.DrawInputText(parentBuffer, xOffset, yOffset, this);
		}
		
	}

}