package gum.FlashPunk 
{
	import flash.geom.Rectangle;
	import gum.controls.Panel;
	import gum.UIInput;
	import gum.UIItem;
	import gum.UISkin;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import flash.display.BitmapData;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author AJC
	 */
	public class UIEntity extends Entity
	{
		public var gui:Panel = null;
		protected var qimage:QuickImage = null;
		public var skin:UISkin = null;
		private var input:UIInput = new UIInput();
		
		public function UIEntity(_x:int, _y:int, _width:int, _height:int, skin:UISkin = null) 
		{
			gui = new Panel(new Rectangle(_x, _y, _width, _height));
			gui.stage = FP.stage;
			qimage = new QuickImage(gui.buffer);
			graphic = qimage;
			qimage.scrollX = 0;
			qimage.scrollY = 0;
			
			if (skin == null) this.skin = new UISkin();
			else this.skin = skin;
			gui.skin = this.skin;
			
			super();
		}
		
		public function AddGuiItem(item:UIItem):void
		{
			gui.addChild(item);
		}
		
		public function FindGuiItem(id:int):UIItem { return gui.FindItem(id); }
		
		private var previousMouse:String = "none";
		
		override public function update():void 
		{
			input.elapsedTime = FP.elapsed;
			
			input.mouseDown = Input.mouseDown;
			input.mouseUp = Input.mouseUp;
			input.mousePressed = Input.mousePressed;
			input.mouseReleased = Input.mouseReleased;
			
			input.mouseMoved = false;
			if (input.mouseX != Input.mouseX) input.mouseMoved = true;
			if (input.mouseY != Input.mouseY) input.mouseMoved = true;
			
			input.mouseX = Input.mouseX;
			input.mouseY = Input.mouseY;
			
			input.cursor = "none";
			gui.Update(input);
			
			if (input.cursor == "none" && previousMouse != "none") Mouse.cursor = "arrow";
			if (input.cursor != "none" && input.cursor != previousMouse) Mouse.cursor = input.cursor;
			previousMouse = input.cursor;
			
			super.update();
		}
		
		override public function render():void 
		{
			gui.Render(null, 0, 0);
			super.render();
		}
		
	}

}