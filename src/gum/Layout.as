package gum
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author AJC
	 */
	public class Layout 
	{
		public static const TOP:int = 0;
		public static const RIGHT:int = 1;
		public static const BOTTOM:int = 2;
		public static const LEFT:int = 3;
		
		public function Layout() 
		{
			
		}
		
		public static function edge(side:int, rect:Rectangle, size:Number):Rectangle
		{
			if (side == TOP) return new Rectangle(rect.x, rect.y, rect.width, size);
			if (side == BOTTOM) return new Rectangle(rect.x, rect.y + rect.height - size, rect.width, size);
			if (side == LEFT) return new Rectangle(rect.x, rect.y, size, rect.height);
			if (side == RIGHT) return new Rectangle(rect.x + rect.width - size, rect.y, size, rect.height);
			return rect;			
		}
		
		public static function center(what:Rectangle, _in:Rectangle):Rectangle
		{
			return new Rectangle(_in.x + (_in.width - what.width) / 2, _in.y + (_in.height - what.height) / 2, what.width, what.height);
		}
		
		public static function Cell(_in:Rectangle, columns:int, rows:int, x:int, y:int):Rectangle
		{
			var width:Number = _in.width / columns;
			var height:Number = _in.height / rows;
			return new Rectangle(x * width, y * height, width, height);
		}
	}

}