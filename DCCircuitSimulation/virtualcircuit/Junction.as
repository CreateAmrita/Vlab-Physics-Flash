﻿/*
Developed under a Research grant from NMEICT, MHRD
by
Amrita CREATE (Center for Research in Advanced Technologies for Education),
VALUE (Virtual Amrita Laboratories Universalizing Education)
Amrita University, India 2009 - 2013
http://www.amrita.edu/create
*/

package virtualcircuit.components{

	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.geom.ColorTransform;
	import virtualcircuit.logic.collision.*;

	import virtualcircuit.logic.Circuit;
	import virtualcircuit.userinterface.StageBuilder;

	public class Junction extends DynamicMovie {
		// Constants:
		// Public Properties:
		public var opp:Boolean;
		public var ids:String;
		public var jType:String;
		public var hit:Boolean;
		public var neighbours:Array;
		public var jnc:Junction;
		public var pinType:String;
		public var isHitWithRedPin:Boolean;
		public var isHitWithBlackPin:Boolean;
		public var selectedJunc:Junction;
		var gf:GlowFilter;
		var prevX:Number;
		var prevY:Number;
		public var lastX:Number;
		public var lastY:Number;
		public var  isCheckForHit:Boolean;
		var collisionList:CollisionList;
		var collidedBranch:Junction;
		//public var crossedBound:Boolean;
		// Private Properties:

		// Initialization:

		//public function Junction(nam:String) {
		public function Junction() {
			this.jType="junction";
			this.isHitWithRedPin=false;
			this.isHitWithBlackPin=false;
			this.buttonMode=true;
			this.jnc=null;
			this.isCheckForHit=false;
			this.opp=false;
			this.hit=false;
			this.prevX=0;
			this.prevY=0;		
			this.neighbours=new Array();
			
			var h2=new MovieClip();
			h2.graphics.beginFill(0xFFFFFF);
			h2.graphics.lineStyle(1);

			this.graphics.beginFill(0xFF0000);
			this.graphics.lineStyle(1);

			h2.alpha=.3;
			this.alpha=.3;

			h2.x=50;
			h2.y=50;

			this.x=0;
			this.y=0;

			h2.graphics.drawEllipse(-10,-10,40,40);
			this.graphics.drawEllipse(-10,-10,20,20);
			
			this.addEventListener(MouseEvent.MOUSE_MOVE,highlightJunction);
			this.addEventListener(MouseEvent.MOUSE_OUT,removeHighlightJunction);
			this.addEventListener(MouseEvent.MOUSE_DOWN,drag);
			
			this.collisionList=new CollisionList(this);
			this.addEventListener(MouseEvent.MOUSE_DOWN,addItems);
			this.addEventListener(MouseEvent.MOUSE_UP,removeItems);
		}
		
		function drag(e:MouseEvent):void {
			this.setSelection(true);
		}
		function sdrag(e:Event):void {
			e.target.parent.stopDrag();
		}
		function changeColour(color:Number):void {
			var colorInfo:ColorTransform=this.transform.colorTransform;

			// Set a random color for the ColorTransform object.
			colorInfo.color=color;

			//Apply the random color for the rectangle
			this.transform.colorTransform=colorInfo;
		}
		
		function highlightJunction(e:MouseEvent):void{
			
			this.alpha=0.5;
		
		}
		
		function removeHighlightJunction(e:MouseEvent):void{
			
			//this.filters=null;
			
			this.alpha=.15;
		
		}
		
		function addItems(e:MouseEvent):void{
			for(var i:int=0;i<Circuit.branches.length;i++){
				if(Circuit.branches[i].insideArea){
					if(Circuit.branches[i]!=e.target.parent){
						if(!isSnapOnOpp(e.target,Circuit.branches[i].startJunction)){
							if (! checkAlreadyExists(e.target.neighbours,Circuit.branches[i].startJunction)) {
								collisionList.addItem(Circuit.branches[i].startJunction);
							}
						}
						if(!isSnapOnOpp(e.target,Circuit.branches[i].endJunction)){
							if (!checkAlreadyExists(e.target.neighbours,Circuit.branches[i].endJunction)) {
								collisionList.addItem(Circuit.branches[i].endJunction);
							}						
						}
					}
				}				
			}
			e.target.addEventListener(Event.ENTER_FRAME,checkForCollision);			
			e.target.parent.parent.setChildIndex(e.target.parent,e.target.parent.parent.numChildren-1);
		}
		function removeItems(e:MouseEvent):void{			
			collisionList.dispose();
			collisionList.swapTarget(e.target);
			e.target.removeEventListener(Event.ENTER_FRAME,checkForCollision);
		}
		function checkForCollision(e:Event){
			var collisions:Array = collisionList.checkCollisions();
			if(collisions.length){
				collidedJn=collisions[0].object1;
			}
			else{
				collidedJn=null;
			}
			if(collidedJn!=null){
				e.target.removeEventListener(Event.ENTER_FRAME,checkForCollision);
				e.target.changeColour(0x000000);
				collidedJn.changeColour(0x000000);
									
				var pdt:Point=new Point(collidedJn.x,collidedJn.y);
				var newPt:Point=new Point();

				newPt=collidedJn.parent.localToGlobal(pdt);
				var transPt:Point=e.target.parent.globalToLocal(newPt);
				e.target.x=transPt.x;
				e.target.y=transPt.y;

				collidedJn.parent.parent.setChildIndex(collidedJn.parent,e.target.parent.parent.numChildren-1);

				var pt:Point=new Point(e.target.x,e.target.y);
				var i:int;

				updateCircuit(e.target,collidedJn,collidedJn.ids,e.target.ids);
														
				if (!checkAlreadyExists(e.target.neighbours,collidedJn)) {
					e.target.neighbours.push(collidedJn);
				}
				if (!checkAlreadyExists(collidedJn.neighbours,e.target)) {
					collidedJn.neighbours.push(e.target);
				}
				
				for (i=0; i<e.target.neighbours.length; i++) {
					if(e.target.neighbours[i]!=collidedJn){
						if (!checkAlreadyExists(e.target.neighbours[i].neighbours,collidedJn)) {
							e.target.neighbours[i].neighbours.push(collidedJn);
						}
					}
				}
				for (i=0; i<collidedJn.neighbours.length; i++) {
					if(collidedJn.neighbours[i]!=e.target){
						if (! checkAlreadyExists(collidedJn.neighbours[i].neighbours,e.target)) {
							collidedJn.neighbours[i].neighbours.push(e.target);
						}
					}
				}	
				
				for(i=0;i<collidedJn.neighbours.length;i++){
					if(collidedJn.neighbours[i]!=e.target){
						if(!checkAlreadyExists(e.target.neighbours,collidedJn.neighbours[i])) {
							e.target.neighbours.push(collidedJn.neighbours[i]);
						}
					}
				}					
				for(i=0;i<e.target.neighbours.length;i++){
					if(e.target.neighbours[i]!=collidedJn){
						if (!checkAlreadyExists(collidedJn.neighbours,e.target.neighbours[i])) {
							collidedJn.neighbours.push(e.target.neighbours[i]);
						}
					}
				}
						
				e.target.stopDrag();
			}
		}
		// Public Methods:
		public function setPos() {
			this.x=prevX;
			this.y=prevY;
		}
		public function setPrev(posX:Number,posY:Number) {
			this.prevX=posX;
			this.prevY=posY;
		}
		
		public function setHitWithRedPin(flag:Boolean){
			this.isHitWithRedPin=flag;
			for(var i:int=0;i<this.neighbours.length;i++){
				this.neighbours[i].isHitWithRedPin=flag;
			}
		}
		public function setHitWithBlackPin(flag:Boolean){
			this.isHitWithBlackPin=flag;
			for(var i:int=0;i<this.neighbours.length;i++){
				this.neighbours[i].isHitWithBlackPin=flag;
			}
		}
		
		public function removeFromNeighbours():void{
			for(i=0;i<this.neighbours.length;i++){
				for(var k:int=0;k<Circuit.subCircuits.length;k++){
					if(Circuit.subCircuits[k].ids==this.neighbours[i].parent.subCircuitIndex){
						Circuit.subCircuits[k].offBatteries();
					}
				}
				for(j=0;j<this.neighbours[i].neighbours.length;j++){
					if(this.neighbours[i].neighbours[j]==this){
						this.neighbours[i].neighbours.splice(j,1);
						break;
					}
				}
			}
		}
		
		public function splitJunctions():void{
			var j:int;
			for(i=0;i<this.neighbours.length;i++){
				this.neighbours[i].ids=this.neighbours[i].name;
				this.neighbours[i].changeColour(0xFF0000);
				if(this.neighbours[i].parent.type=="wire"){
					if(this.neighbours[i]==this.neighbours[i].parent.startJunction){
						this.splitDraw(this.neighbours[i],this.neighbours[i].parent.endJunction);
					}
					else{
						this.splitDraw(this.neighbours[i],this.neighbours[i].parent.startJunction);
					}
				}
				if(Circuit.subCircuits!=null){
					if(Circuit.subCircuits.length!=0){	
						for(j=0;j<Circuit.subCircuits.length;j++){
							if(Circuit.subCircuits[j].ids==this.neighbours[i].parent.subCircuitIndex){
								Circuit.subCircuits[j].offBatteries();
							}
						}
					}
				}
				this.neighbours[i].neighbours=new Array();
			}
			this.ids=this.name;
			if(Circuit.subCircuits!=null){
				for(j=0;j<Circuit.subCircuits.length;j++){
					if(Circuit.subCircuits[j].ids==this.parent.subCircuitIndex){
						Circuit.subCircuits[j].offBatteries();
					}					
				}
			}
			this.setSelection(false);
			this.changeColour(0xFF0000);
			this.filters=null;
			this.neighbours=new Array();	
			
		}
		
		function splitDraw(jn1:Junction,jn2:Junction){
			if((jn1.y-jn2.y)>=0){
				jn1.y=jn2.y+(jn1.y-jn2.y)*0.5;		
			}
			else if((jn2.y-jn1.y)>0){
				jn1.y=jn2.y-(jn2.y-jn1.y)*0.5;						
			}
			jn1.x=jn2.x+(jn1.x-jn2.x)*0.5;	
			jn1.parent.innerComponentRef.drawLine(jn2.x,jn2.y,jn1.x,jn1.y);
		}
		
		// Protected Methods:
		function updateCircuit(hitter:Junction,hit:Junction,newName:String,oldName:String):void {
			
			var searchData:XMLList=Circuit.circuit.branch;

			var searchResults:XMLList = searchData.(hasOwnProperty('@startJunction') && @startJunction.toLowerCase() == oldName);//traces correclty
			
			for each (var item:XML in searchResults) {
				var temp:String=item.@index.toString();
				Circuit.circuit.branch.(@index==temp).@startJunction=newName;
			}

			var searchResults2:XMLList = searchData.(hasOwnProperty('@endJunction') && @endJunction.toLowerCase() == oldName);//traces correclty

			for each (var item2:XML in searchResults2) {
				var tmp:String=item2.@index.toString();
				Circuit.circuit.branch.(@index==tmp).@endJunction=newName;
			}
			hitter.ids=hit.ids;		
			Circuit.circuitAlgorithm();
		}

		public function setSelection(stat:Boolean):void{
			
			if(stat==true){
				if(StageBuilder.selectedObj!=null){
					StageBuilder.selectedObj.filters=null;
					StageBuilder.selectedObj=null;
				}
				if(StageBuilder.selectedJn!=null)
				StageBuilder.selectedJn.filters=null;
				this.gf=new GlowFilter(0Xff9932,1,11,11,6,BitmapFilterQuality.LOW,false,false);//0X660033//0XFFFF99
				this.filters=[this.gf];
				StageBuilder.selectedJn=this;
			}
			else
				this.filters=null;
		}

		function processSearchXML(xmlData:XML, searchTerm:String):XMLList {
			var searchData:XMLList=xmlData.branch;
			var searchResults:XMLList = searchData.(hasOwnProperty('@startJunction') && @startJunction.toLowerCase() == searchTerm);//traces correclty
			if (! searchResults.length()) {
			} else {

			}

			return searchResults;
		}

		function localToLocal(fr:MovieClip, to:MovieClip,pt:Point):Point {
			return to.globalToLocal(fr.localToGlobal(pt));
		}

		function checkAlreadyExists(neighboursArray:Array,targetObj:Junction):Boolean {
			var flag:Boolean=false;

			for (var i:int=0; i<neighboursArray.length; i++) {
				if (neighboursArray[i]==targetObj) {
					flag=true; 
					break;
				}
			}
			return flag;
		}
		
		function isSnapOnOpp(junction:Junction,dropJunction:Junction):Boolean{
			var opp:Junction;
			if(junction.parent.startJunction.ids==junction.ids){
				opp=junction.parent.endJunction;
			}
			else{
				opp=junction.parent.startJunction;
			}
			if(opp.ids==dropJunction.ids){
				return true;
			}
			for(var i=0;i<opp.neighbours.length;i++){
				var nextOpp:Junction;
				if(opp.neighbours[i].parent.startJunction.ids==opp.neighbours[i].ids){
					nextOpp=opp.neighbours[i].parent.endJunction;
				}
				else{
					nextOpp=opp.neighbours[i].parent.startJunction;
				}
				if(nextOpp.ids==dropJunction.ids || opp.neighbours[i].ids==dropJunction.ids){
					return true;
				}
			}
			return false;
		}
	}
}