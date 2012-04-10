package gum.Pixelizer
{
	import flash.display.Stage;
	import flash.geom.Point;
	import gum.*;
	import gum.controls.Panel;
	import pixelizer.components.render.PxBlitRenderComponent;
	import pixelizer.PxEntity;
	import pixelizer.PxInput;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	
	public class UIEntity extends PxEntity {

		public var gui:Panel = null;
		private var skin:UISkin = new UISkin();
		private var input:UIInput = new UIInput();
		private var renderComponent:PxBlitRenderComponent = null;
		
		public function UIEntity(_x:int, _y:int, _width:int, _height:int, stage:Stage) 
		{
			super(0, 0);
			
			gui = new Panel(new Rectangle(_x, _y, _width, _height));
			renderComponent = new PxBlitRenderComponent(gui.buffer, new Point(0,0));
			addComponent(renderComponent);
			gui.skin = skin;
			gui.stage = stage;
		}
		
		public function AddGuiItem(item:UIItem):void
		{
			gui.addChild(item);
		}
		
		public function FindGuiItem(id:int):UIItem { return gui.FindItem(id); }
		
		override public function update( pDT : Number ) : void 
		{
			input.mouseDown = PxInput.mouseDown;
			input.mouseUp = PxInput.mouseUp;
			input.mousePressed = PxInput.mousePressed;
			input.mouseReleased = PxInput.mouseReleased;
			
			input.mouseMoved = false;
			if (input.mouseX != PxInput.mouseX) input.mouseMoved = true;
			if (input.mouseY != PxInput.mouseY) input.mouseMoved = true;
			
			input.mouseX = PxInput.mouseX;
			input.mouseY = PxInput.mouseY;
			
			input.elapsedTime = pDT;
			
			input.cursor = "arrow";
			gui.Update(input);
			gui.Render(null, 0, 0);
			Mouse.cursor = input.cursor;
			
			
			
			super.update(pDT);
		}
		
	
	}

}