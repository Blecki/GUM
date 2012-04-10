package 
{
	import flash.geom.Rectangle;
	import gum.*;
	import gum.controls.*;
	import gum.Pixelizer.UIEntity;
	import pixelizer.PxEngine;
	import pixelizer.PxScene;
	
	/**
	 * ...
	 * @author AJC
	 */
	public class PixMain extends PxEngine 
	{
		private var uiEntity:UIEntity = null;
		
		[Embed(source = "assets/P.png")] public static const GFX_P:Class;
		[Embed(source = "assets/PHover.png")] public static const GFX_P_HOVER:Class;
		
		
		public function PixMain():void 
		{
			super(640,480, 1, 30, null, false);
			
			var mainScene:PxScene = new PxScene();
			pushScene(mainScene);
			
			uiEntity = new UIEntity(0, 0, 640, 480, this.stage);
			
			//A button that counts how many times it is clicked.
			var clickCount:int = 0;
			uiEntity.AddGuiItem(new Button(new Rectangle(32, 32, 256, 32), 
			{
				OnClick: function(button:Button):void 
					{
						clickCount += 1;
						button.label = clickCount.toString() + " Clicks";
					},
				label: "0 Clicks" 
			} ));
			
			//Radio button set
			var radioSet:RadioSet = new RadioSet();
			uiEntity.AddGuiItem(new CheckBox(new Rectangle(32, 80, 256, 32), { label : "one", radioSet: radioSet, checked: true } ));
			uiEntity.AddGuiItem(new CheckBox(new Rectangle(32, 120, 256, 32), { label : "two", radioSet: radioSet } ));
			uiEntity.AddGuiItem(new CheckBox(new Rectangle(32, 160, 256, 32), { label : "three", radioSet: radioSet } ));
			
			//Text boxes
			uiEntity.AddGuiItem(new InputText(new Rectangle(32, 208, 256, 32)));
			uiEntity.AddGuiItem(new InputText(new Rectangle(32, 248, 256, 32), { password: true }));

			//Sliders
			uiEntity.AddGuiItem(new Label(new Rectangle(336, 32, 128, 32), { id: 1, text : "Label." } ));
			uiEntity.AddGuiItem(new Slider(new Rectangle(304, 32, 16, 256), 
			{ 
				orientation: UIItem.VERTICAL,
				minimum: 0, 
				maximum:255,
				OnSlide: function(slider:Slider):void { uiEntity.gui.FindItem(1).text = slider.position.toString(); }
			} ));
			uiEntity.AddGuiItem(new Slider(new Rectangle(32, 296, 256, 16), { orientation: UIItem.HORIZONTAL,
				minimum: 0, maximum:255 } ));
				
			uiEntity.AddGuiItem(new Button(new Rectangle(336, 80, 32, 64), { 
				background: (new GFX_P()).bitmapData,
				hoverBackground: (new GFX_P_HOVER()).bitmapData,
				border: false
			} ));
			
			uiEntity.AddGuiItem(new ProgressBar(new Rectangle(32, 328, 256, 16), 
				{ 
					OnUpdate: function(bar:ProgressBar, input:UIInput):void
					{
						bar.percentage += input.elapsedTime / 5;
						if (bar.percentage >= 1) bar.percentage = 0;
					}
				} ));
			
			mainScene.addEntity(uiEntity);
		}
		
	}
	
}