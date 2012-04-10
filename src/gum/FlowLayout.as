package gum
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author AJC
	 */
	public class FlowLayout 
	{
		private var rect:Rectangle;
		private var padding:Number;
		
		public function FlowLayout(rect:Rectangle, padding:Number = 0) 
		{
			this.rect = rect;
			this.padding = padding;
		}
		
		public function Item(width:Number, height:Number):Rectangle
		{
			var result:Rectangle = new Rectangle(rect.x, rect.y, width, height);
			rect.x += width + padding;
			return result;
		}
		
	}

}