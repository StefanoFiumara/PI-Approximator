package pi_approx
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Stefano Fiumara
	 */
	public class Main extends Sprite 
	{
		
		private var circle_x:uint = 250;
		private var circle_y:uint = 300;
		private var radius:uint = 200;
		
		private var aprox_label:TextField;
		
		private var currentPoint:Point;
		
		private var dotsInCircle:int;
		private var totalDots:int;
		
		private var approximation:Number;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			drawDiagram();
			
			createAproxLabel();
			
			var title_label:TextField = new TextField();
			title_label.selectable = false;
			title_label.scaleX = 4;
			title_label.scaleY = 4;
			title_label.text = "Approximating PI";
			title_label.x = 300;
			addChild(title_label);
			
			currentPoint = new Point();
			dotsInCircle = 0;
			totalDots = 0;
			approximation = 0;
			addEventListener(Event.ENTER_FRAME, approximatePI);
		}
		
		/**
		 * Each frame, this function randomly selects a point in the square and checks whether or not it is in the circle.
		 * Then it updates our approximation for PI.
		 */
		private function approximatePI(e:Event):void {
			giveRandomPoint();
			
			if (isInCircle()) {
				dotsInCircle++;
			}
			
			totalDots++;
			
			approximation = 4 * dotsInCircle / totalDots;
			drawPoint();
			updateText();
		}
		
		/**
		 * Draws the current point on the screen
		 */
		private function drawPoint():void {
			graphics.beginFill(0xFF0000, 1);
			graphics.drawRect(currentPoint.x, currentPoint.y, 1, 1);
			graphics.endFill();
		}
		
		/**
		 * Updates the label based on the current approximation.
		 */
		private function updateText():void {
			aprox_label.text = "PI = " + approximation + "\nDots In Circle = " + dotsInCircle + "\nTotal Dots = " + totalDots;
		}
		
		/**
		 * Draws the initial image.
		 */
		private function drawDiagram():void {
			graphics.lineStyle(1);
			graphics.beginFill(0x0000CC, 0.6);
			graphics.drawCircle(circle_x, circle_y, radius);
			graphics.endFill();
			graphics.lineStyle(1);
			graphics.drawRect(circle_x - radius, circle_y - radius, 2 * radius, 2 * radius);
			graphics.lineStyle(0, 0, 0);
		}
		
		/**
		 * Helper function that checks if the current point is in the circle.
		 */
		private function isInCircle():Boolean {
			var dx:int = Math.abs(currentPoint.x - circle_x);
			var dy:int = Math.abs(currentPoint.y - circle_y);
			
			return (dx * dx) + (dy * dy) < radius * radius;
		}
		
		/**
		 * Gives a random point in the given square.
		 */
		private function giveRandomPoint():void {
			currentPoint.x = randomRange(circle_x - radius, 2 * radius + (circle_x - radius));
			currentPoint.y = randomRange(circle_y - radius, 2 * radius + (circle_y - radius));
		}
		
		/**
		 * Helper function for obtaining a random range since AS3's Math.random() only returns a value between 0.0 and 1.0
		 * For our purposes, this function is used to return a random x and y value inside the square on the screen
		 */
		private function randomRange( min:int, max:int ):int {
			return Math.floor(Math.random() * (1 + max - min)) + min;
		}
		
		/**
		 * Creates and positions the aproximation textfield
		 */
		private function createAproxLabel():void {
			aprox_label = new TextField();
			
			aprox_label.x = 500;
			aprox_label.y = 300;
			aprox_label.width = 1000;
			addChild(aprox_label);
		}
		
		
	}
	
}