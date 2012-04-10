package gum.controls
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import gum.*;
	
	/**
	 * A UIItem that blits it's children to it's own internal buffer, then blits this buffer to it's parent.
	 */
	public dynamic class ScrollingText extends UIItem
	{
		public var buffer:BitmapData = null;
		public var childAreaHeight:int = 0;
		public var slider:Slider = null;
		public var inputText:InputText = null;
		
		public function ScrollingText(rect:Rectangle, properties:Object = null) 
		{
			super(rect, properties);

		}
		
		override public function OnAdded():void 
		{
			
			buffer = new BitmapData(rect.width - 16, rect.height, true, 0xFFFFFFFF);
			//var scrollArea:int = childAreaHeight - rect.height;
			//if (scrollArea < 0) scrollArea = 0;
			slider = new Slider(Layout.edge(Layout.RIGHT, new Rectangle(0, 0, rect.width, rect.height), 16), 
			{
				orientation : UIItem.VERTICAL,
				minimum: 0,
				maximum: 1
			});
			addChild(slider);
			
			inputText = new InputText(new Rectangle(0, 0, rect.width - 16, rect.height),
			{
				multiline : true,
				readonly : true,
				text : this.text,
				wordwrap: true
			});
			
			addChild(inputText);
		}
		
		public function AppendText(text:String):void
		{
			inputText.inputField.appendText(text);
			updateSlider();
			slider.position = slider.maximum;
		}
		
		private function updateSlider():void
		{
			//childAreaHeight = inputText.inputField.textHeight;
			//var scrollArea:int = childAreaHeight - rect.height;
			//if (scrollArea < 0) scrollArea = 0;
			slider.maximum = inputText.inputField.maxScrollV;
			if (slider.position > slider.maximum)
				slider.position = slider.maximum;
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
			
			updateSlider();
		}
		
		override public function Render(parentBuffer:BitmapData, xOffset:int, yOffset:int):void 
		{
			skin.DrawElementBackground(buffer, new Rectangle(0, 0, buffer.width, buffer.height), 0, 0);
			inputText.inputField.scrollV = slider.position;
			inputText.Render(buffer, 0, 0);;
			skin.DrawBorder(buffer, new Rectangle(0, 0, buffer.width, buffer.height), 0, 0, skin.borderColor);
			if (parentBuffer != null)
				parentBuffer.copyPixels(buffer, new Rectangle(0, 0, buffer.width, buffer.height), new Point(rect.x, rect.y));
			slider.Render(parentBuffer, xOffset + rect.x, yOffset + rect.y);
		}
		
	}

}