package gum.FlashPunk
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.*;

	/**
	 * Performance-optimized non-animated image.
	 */
	public class QuickImage extends Graphic
	{
		public var originX:Number = 0;
		public var originY:Number = 0;
		
		public function QuickImage(source:BitmapData) 
		{
			_source = source;
			if (!_source) throw new Error("Invalid source image.");
		}
		
		override public function render(target:BitmapData, point:Point, camera:Point):void
		{
			// determine drawing location
			_point.x = point.x + x - originX - camera.x * scrollX;
			_point.y = point.y + y - originY - camera.y * scrollY;
			
			// render without transformation
			target.copyPixels(_source, new Rectangle(0,0,_source.width, _source.height), _point, null, null, false);
		}
		
		/**
		 * Centers the Image's originX/Y to its center.
		 */
		public function centerOrigin():void
		{
			originX = _source.width / 2;
			originY = _source.height / 2;
		}
		
		/**
		 * Width of the image.
		 */
		public function get width():uint { return _source.width; }
		
		/**
		 * Height of the image.
		 */
		public function get height():uint { return _source.height; }
		
		/** @protected Source BitmapData image. */
		protected function get source():BitmapData { return _source; }
		
		// Source and buffer information.
		/** @private */ protected var _source:BitmapData;
		
	}
}
