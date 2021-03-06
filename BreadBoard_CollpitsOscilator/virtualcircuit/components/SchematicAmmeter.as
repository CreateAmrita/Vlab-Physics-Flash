﻿package virtualcircuit.components{
	
	import flash.display.MovieClip;
	
	public class SchematicAmmeter extends MovieClip{
		
		var whiteRect:Rect;
		
		public function SchematicAmmeter(){
			this.whiteRect=new Rect();
			this.whiteRect.width=this.width;
			this.whiteRect.height=this.height;
			this.whiteRect.x=this.x;
			this.whiteRect.y=this.y;
			this.whiteRect.alpha=0;
			this.addChild(this.whiteRect);			
			this.mouseChildren=false;
			this.setChildIndex(this.whiteRect,this.numChildren-2);
		}
	}
}