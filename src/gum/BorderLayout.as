package gum
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author AJC
	 */
	public class BorderLayout 
	{
		private var rect:Rectangle;
		private var padding:Number = 0;
		
		public function BorderLayout(rect:Rectangle, padding:Number = 0) 
		{
			this.rect = rect;
			this.padding = padding;
			rect.x += padding;
			rect.y += padding;
			rect.width -= 2 * padding;
			rect.height -= 2 * padding;
		}
		
		public function Center():Rectangle
		{
			return rect;
		}
		
		public function Top(height:Number):Rectangle
		{
			var result:Rectangle = new Rectangle(rect.x, rect.y, rect.width, height);
			rect.y += height + padding;
			rect.height -= height + padding;
			return result;
		}
		
		public function Bottom(height:Number):Rectangle
		{
			var result:Rectangle = new Rectangle(rect.x, rect.y + rect.height - height, rect.width, height);
			rect.height -= height + padding;
			return result;
		}
		
		public function Left(width:Number):Rectangle
		{
			var result:Rectangle = new Rectangle(rect.x, rect.y, width, rect.height);
			rect.x += width + padding;
			rect.width -= width + padding
			return result;
		}
		
		public function Right(width:Number):Rectangle
		{
			var result:Rectangle = new Rectangle(rect.x + rect.width - width, rect.y, width, rect.height);
			rect.width -= width + padding;
			return result;
		}
		
	}

}