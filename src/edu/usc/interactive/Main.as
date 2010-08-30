package edu.usc.interactive
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	
	/**
	 * ...
	 * @author David Elliott
	 */
	public class Main extends Sprite 
	{
		[Embed(source = '../../../data/blip.mp3')] public var BlipSnd:Class;
		public var blpSnd:Sound = new BlipSnd() as Sound;
		
		[Embed(source = '../../../data/explode.mp3')] public var ExplodeSnd:Class;
		public var expldSnd:Sound = new ExplodeSnd() as Sound;
		
		[Embed(source='../../../data/laser.mp3')] public var LaserSnd:Class;
		public var lasrSnd:Sound = new LaserSnd() as Sound;
		
		[Embed(source='../../../data/powerup.mp3')] public var PowerUpSnd:Class;
		public var pwrSnd:Sound = new PowerUpSnd() as Sound;
		
		
		[Embed(source = '../../../data/star.png')] public var Star:Class;
		public var myStar:Bitmap = new Star();
		
		private var innerRect:Sprite = new Sprite();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			// entry point
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addEventListener(Event.ENTER_FRAME, loop);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);

            innerRect.graphics.lineStyle(1, 0x00FF00, 1);
            innerRect.graphics.beginFill(0x00FF00);
            innerRect.graphics.drawRect(0, 0, 200, 200);
            innerRect.graphics.endFill();
            innerRect.addEventListener(MouseEvent.MOUSE_DOWN, innerRectMouseDownHandler, false, 0, true);
			innerRect.addEventListener(MouseEvent.MOUSE_UP, innerRectMouseUpHandler, false, 0, true);
            addChild(innerRect);
			
			myStar.x = (innerRect.x + innerRect.width/2) - (myStar.width/2);
			myStar.y = (innerRect.y + innerRect.height/2) - (myStar.height/2);
			addChild(myStar);
		}
		
		private function loop(e:Event = null):void
		{
			
			
		}
		
        private function mouseDownHandler(event:MouseEvent):void 
		{
			pwrSnd.play();
        }
		
        private function innerRectMouseDownHandler(e:MouseEvent):void 
		{
			e.stopPropagation();
			lasrSnd.play();
			innerRect.addEventListener(MouseEvent.MOUSE_MOVE, innerRectMouseMoveHandler, false, 0, true);
        }
		
		private function innerRectMouseUpHandler(e:Event):void
		{
			expldSnd.play();
			innerRect.removeEventListener(MouseEvent.MOUSE_MOVE, innerRectMouseMoveHandler);
			innerRect.graphics.beginFill(0x00FF00);
            innerRect.graphics.drawRect(0, 0, 200, 200);
            innerRect.graphics.endFill();
		}
		
		private function innerRectMouseMoveHandler(e:Event):void
		{
			innerRect.addEventListener(MouseEvent.MOUSE_MOVE, innerRectMouseMoveHandler, false, 0, true);
            innerRect.graphics.beginFill((Math.random() * 0xFFFFFF));
            innerRect.graphics.drawRect(0, 0, 200, 200);
            innerRect.graphics.endFill();
		}
		
	}
	
}