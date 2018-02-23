package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Potapenkov
	 */
	public dynamic class ButtonsLayout extends MovieClip
	{
		public function ButtonsLayout():void {
			expl = new Zombie1Explosion() ;
			
			var c1:World1bg= new World1bg();
			addChild(c1);
			
			
			var b1:PauseButton= new PauseButton();
			b1.x = 7;
			b1.y = 372;
			addChild(b1);
			var b2:HomeButton = new HomeButton();
			b2.x = 55;
			b2.y = 372;
			addChild(b2);
			var b3:LeftArrowButton= new LeftArrowButton();
			b3.x = 162;
			b3.y = 372;
			addChild(b3);
			var b4:Level= new Level();
			b4.x = 230-13;
			b4.y = 372;
			addChild(b4);
			var b41:Numbers= new Numbers();
			b41.x = 338;
			b41.y = 372;
			addChild(b41);
			var b42:Numbers= new Numbers(8);
			b42.x = 369;
			b42.y = 372;
			addChild(b42);
			
			var b5:RightArrowButton= new RightArrowButton();
			b5.x = 427;
			b5.y = 372;
			b5.disable();
			addChild(b5);
			var b6:RefreshButton= new RefreshButton();
			b6.x = 586;
			b6.y = 372;
			addChild(b6);
			var b7:ShocksButton= new ShocksButton();
			b7.x = 520;
			b7.y = 5;
			addChild(b7);
			b7.addEventListener(MouseEvent.CLICK, burnZ);
			
			
			
		
			
			
			a1 = new Zombie2(world,250*coef, 80*coef);
			addChild(a1);
			var a2:Tire2 = new Tire2(world, 400*coef, 80*coef);
			addChild(a2);
			
			
			var a3:Zombie3= new Zombie3(world, 520*coef, 80*coef);
			addChild(a3);
			var a4:Tire1= new Tire1(world, 230*coef,550*coef);
			addChild(a4);
			a4.addEventListener(MouseEvent.CLICK, removeIt);
		//	a4.animStart();
			var a5:Bub3 = new Bub3(400*coef, 280*coef, 0);
			a5.init(this, world);
			var a6:Tnt4 = new Tnt4(650*coef, 280*coef, 0);
			a6.init(this, world);
		}
	}
	
}