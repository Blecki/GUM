package gum 
{
	/**
	 * ...
	 * @author AJC
	 */
	public class UIInput 
	{
		public function UIInput() 
		{
			
		}
		
		public var elapsedTime:Number = 0;
		
		public var mouseMoved:Boolean = false;
		public var mouseDown:Boolean = false;
		public var mouseUp:Boolean = true;
		public var mousePressed:Boolean = false;
		public var mouseReleased:Boolean = false;
		public var mouseX:int = 0;
		public var mouseY:int = 0;
		
		public var cursor:String = "arrow";
	}

}