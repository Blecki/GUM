package gum 
{
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import gum.controls.*;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author AJC
	 */
	public class UISkin 
	{
		[Embed(source = '04B_03__.TTF', embedAsCFF = "false", fontFamily = 'pixel')] private static var _FONT_DEFAULT:Class;
		
		public var backgroundColor:uint = 0xFFF3F3F3;
		public var textColor:uint = 0xFF000000;
		public var borderColor:uint = 0xFFCCCCCC;
		public var hoverBackgroundColor:uint = 0xFFFFFFFF;
		public var checkMarkColor:uint = 0xFF444444;
		
		public function UISkin() 
		{
			buttonTextFormat = new TextFormat('pixel', 24, 0xFF000000);
		}
		
		private var buttonTextFormat:TextFormat = null;
		private var offsetMatrix:Matrix = new Matrix();
		
		public var sliderHandleSize:int = 8;
		
		public function DrawRectangle(buffer:BitmapData, rect:Rectangle, color:uint):void 
		{
			buffer.fillRect(rect, color);
		}
		
		public function DrawBorder(buffer:BitmapData, rect:Rectangle, xOffset:int, yOffset:int, color:uint):void 
		{
			buffer.fillRect(new Rectangle(rect.x + xOffset, rect.y + yOffset, rect.width, 1), color);
			buffer.fillRect(new Rectangle(rect.x + xOffset, rect.bottom - 1 + yOffset, rect.width, 1), color);
			buffer.fillRect(new Rectangle(rect.x + xOffset, rect.y + 1 + yOffset, 1, rect.height - 2), color);
			buffer.fillRect(new Rectangle(rect.right - 1 + xOffset, rect.y + 1 + yOffset, 1, rect.height - 2), color);
		}
		
		public function DrawElementBackground(buffer:BitmapData, rect:Rectangle, xOffset:int, yOffset:int):void
		{
			buffer.fillRect(new Rectangle(rect.x + xOffset, rect.y + yOffset, rect.width, rect.height), backgroundColor);
		}
		
		private function StyleButton(item:UIItem, label:String):void
		{
			if (item.styleTag == null)
			{
				var field:TextField = new TextField();
				field.width = item.rect.width;
				field.embedFonts = true;
				field.background = false;
				field.defaultTextFormat = buttonTextFormat;
				item.styleTag = field;
				field.textColor = textColor;
			}
			
			if (item.styleTag != null && item.styleTag is TextField)
			{
				(item.styleTag as TextField).text = label;
			}
		}
		
		public function DrawButton(buffer:BitmapData, xOffset:int, yOffset:int, button:Button):void
		{
			if (button.border == null || button.border == true)
			{
				var nRect:Rectangle = new Rectangle(button.rect.x + xOffset, button.rect.y + yOffset, button.rect.width, button.rect.height);
				buffer.fillRect(nRect, button.hover ? hoverBackgroundColor : backgroundColor);
				DrawBorder(buffer, nRect, 0, 0, borderColor );
			}
			
			offsetMatrix.identity();
			offsetMatrix.translate(button.rect.x + xOffset,	button.rect.y + yOffset);
			
			if (button.hover && button.hoverBackground != null && button.hoverBackground is IBitmapDrawable)
				buffer.draw(button.hoverBackground, offsetMatrix);
			else if (button.background != null && button.background is IBitmapDrawable)
				buffer.draw(button.background, offsetMatrix);
			
			if (button.label != null) 
			{
				StyleButton(button, button.label);
				var field:TextField = button.styleTag as TextField;
				offsetMatrix.translate((button.rect.width - field.textWidth) / 2, (button.rect.height - field.textHeight) / 2);
				buffer.draw(field, offsetMatrix);
			}
		}
		
		public function DrawInputText(buffer:BitmapData, xOffset:int, yOffset:int, input:InputText):void
		{
			DrawElementBackground(buffer, input.rect, xOffset, yOffset);
			DrawBorder(buffer, input.rect, xOffset, yOffset, borderColor);
			input.inputField.embedFonts = true;
			input.inputField.defaultTextFormat = buttonTextFormat;
			input.inputField.setTextFormat(buttonTextFormat);
			input.inputField.displayAsPassword = input.password == true;
			input.inputField.textColor = textColor;
			offsetMatrix.identity();
			offsetMatrix.translate(input.rect.x + xOffset + 4, 
				input.rect.y + yOffset + (input.multiline == true ? 0 : ((input.rect.height - input.inputField.textHeight) / 2)));
			buffer.draw(input.inputField, offsetMatrix);
		}
		
		public function DrawLabel(buffer:BitmapData, xOffset:int, yOffset:int, label:Label):void
		{
			if (label.text != null) 
			{
				StyleButton(label, label.text);
				var field:TextField = label.styleTag as TextField;
				offsetMatrix.identity();
				offsetMatrix.translate(label.rect.x + xOffset + 4, 
					label.rect.y + yOffset + (label.rect.height - field.textHeight) / 2);
				buffer.draw(field, offsetMatrix);
			}
		}
		
		public function DrawSlider(buffer:BitmapData, xOffset:int, yOffset:int, slider:Slider):void
		{
			DrawElementBackground(buffer, slider.rect, xOffset, yOffset);
			DrawBorder(buffer, slider.rect, xOffset, yOffset, borderColor);
			
			if (slider.orientation == UIItem.HORIZONTAL)
			{
				buffer.fillRect(new Rectangle(
					slider.rect.x + xOffset + slider.handlePosition() - (sliderHandleSize / 2),
					slider.rect.y + yOffset, sliderHandleSize, slider.rect.height), borderColor);
			}
			else
			{
				buffer.fillRect(new Rectangle(
					slider.rect.x + xOffset, 
					slider.rect.y + yOffset + slider.handlePosition() - (sliderHandleSize / 2), 
					slider.rect.width, sliderHandleSize), borderColor);
				
			}
		}
		
		public function DrawProgressBar(buffer:BitmapData, xOffset:int, yOffset:int, bar:ProgressBar):void
		{
			DrawElementBackground(buffer, bar.rect, xOffset, yOffset);
			DrawBorder(buffer, bar.rect, xOffset, yOffset, borderColor);
			buffer.fillRect(new Rectangle(bar.rect.x + xOffset, bar.rect.y + yOffset, bar.rect.width * bar.percentage, bar.rect.height),
				borderColor);
		}
		
		public function DrawCheckBox(buffer:BitmapData, xOffset:int, yOffset:int, box:CheckBox):void
		{
			var nRect:Rectangle = new Rectangle(box.rect.x + xOffset, box.rect.y + yOffset, box.rect.height, box.rect.height);
			buffer.fillRect(nRect, box.hover ? hoverBackgroundColor : backgroundColor);
			if (box.checked) buffer.fillRect(new Rectangle(nRect.x + 6, nRect.y + 6, nRect.width - 12, nRect.height - 12), checkMarkColor);
			DrawBorder(buffer, nRect, 0, 0, borderColor );
			
			if (box.label != null) StyleButton(box, box.label);
			
			if (box.styleTag != null && box.styleTag is TextField)
			{
				var field:TextField = box.styleTag as TextField;
				offsetMatrix.identity();
				offsetMatrix.translate(box.rect.x + xOffset + box.rect.height + 4, 
					box.rect.y + yOffset + (box.rect.height - field.textHeight) / 2);
				buffer.draw(field, offsetMatrix);
			}
		}
	}

}