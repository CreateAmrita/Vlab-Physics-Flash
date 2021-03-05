﻿package virtualcircuit.components {
	
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality;
	
	public class RealWire extends MovieClip{
		
		// Constants:
		// Public Properties:
		// Private Properties:
			var gf:GlowFilter;
					
			// Initialization:
			function RealWire(){
				
			}
		// Public Methods:
		public function drawLine(xstart:Number,ystart:Number,xend:Number,yend:Number){
			
			this.graphics.clear();
			
			this.gf=new GlowFilter(0X660033,1,5,10,3,BitmapFilterQuality.LOW,true,false);//0X660033
			this.filters=[this.gf];
			this.graphics.lineStyle(5,0XDD0000,1,true,"normal","CapsStyle.ROUND","JointStyle.ROUND",3);
			this.graphics.moveTo(xstart,ystart);
			this.graphics.lineTo(xend,yend);
			
		}
		
		// Protected Methods:
	}
	
}