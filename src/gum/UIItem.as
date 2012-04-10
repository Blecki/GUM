package gum
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author AJC
	 */
	public dynamic class UIItem
	{
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