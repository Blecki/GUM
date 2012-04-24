package gum
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public dynamic class UIItem
	{
		
		//Temporary recycleable point objects.
		protected static var _tPoint1:Point = new Point();
		protected static var _tPoint2:Point = new Point();
		public static function mtPoint1(x:Number, y:Number):Point { _tPoint1.x = x; _tPoint1.y = y; return _tPoint1; }
		public static function mtPoint2(x:Number, y:Number):Point { _tPoint2.x = x; _tPoint2.y = y; return _tPoint2; }
		protected static var _pZero:Point = new Point(0, 0);
		
		//Temporary recycleable rect object
		protected static var _tRect:Rectangle = new Rectangle();
		public static function mtRect(x:Number, y:Number, w:Number, h:Number):Rectangle 
		{ 
			_tRect.x = x;
			_tRect.y = y;
			_tRect.width = w;
			_tRect.height = h;
			return _tRect;
		}
		
		public static const HORIZONTAL:int = 0;
		public static const VERTICAL:int = 1;
		
		public var children:Array = [];
		public var rect:Rectangle;
		private var parent:UIItem = null;
		public var styleTag:Object = null;
		public var skin:UISkin = null;
		public var id:int = 0;
		public var stage:Stage = null;
		
		public function get root():UIItem
		{
			if (parent == null) return this;
			return parent.root;
		}
		
		public function UIItem(rect:Rectangle, properties:Object = null)
		{
			this.rect = rect;		
			
			if (properties != null)
			{
				for (var id:String in properties)
				{
					this[id] = properties[id];
				}
			}
		}
		
		public function Update(input:UIInput):void
		{
			if (this.OnUpdate != null) this.OnUpdate(this, input);
		}
		
		public function addChild(child:UIItem):void
		{
			children.push(child);
			child.parent = this;
			child.skin = skin;
			child.stage = stage;
			child.OnAdded();
		}
		
		public function removeChild(child:UIItem):void
		{
			var index:int = children.indexOf(child);
			if (index != -1)
				children.splice(index, 1);
		}
		
		public function FindItem(id:int):UIItem
		{
			if (this.id == id) return this;
			for each (var child:UIItem in children)
			{
				var r:UIItem = child.FindItem(id);
				if (r != null) return r;
			}
			return null;
		}
		
		public function destroy():void
		{
			if (parent != null)
				parent.removeChild(this);
			parent = null;
		}
		
		public function Render(parentBuffer:BitmapData, xOffset:int, yOffset:int):void 
		{
			for each (var child:UIItem in children)
				child.Render(parentBuffer, xOffset + rect.x, yOffset + rect.y);
		}
		
		public function OnAdded():void {}
		
	}

}