﻿package virtualcircuit.userinterface{
	
	import flash.display.MovieClip;
	import fl.events.SliderEvent;
	import fl.controls.Slider;
	import fl.controls.NumericStepper;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import virtualcircuit.logic.Circuit;
	
	public class Scroll extends MovieClip{
		var slider:Slider;
		var labelTxt:TextField;
		var labelTxtMin:TextField;
		var labelTxtMax:TextField;
		var numberStepper:NumericStepper;
		var objt:Object;
		var objArray:Array;
		public var isCheckBoxSelected:Boolean;
		
		public function Scroll(xPos:Number,yPos:Number,textString:String,min:Number,max:Number,step:Number){
			this.slider=new Slider();
			this.slider.setSize(130,0);
			this.slider.liveDragging=true;
			this.slider.maximum=max;
			this.slider.minimum=min;
			this.slider.snapInterval=step;
			this.slider.move(this.x-60,0);
			this.slider.addEventListener(SliderEvent.CHANGE,getVal);
			this.slider.addEventListener(SliderEvent.THUMB_RELEASE,updateVal);
			
			
			var format:TextFormat = new TextFormat();
			format.size = 15;
			format.bold=true;
			format.align="center";
			
			this.labelTxt=new TextField();
			this.labelTxt.setTextFormat(format);
			this.labelTxt.text=textString;
			this.labelTxt.x=-80;
			this.labelTxt.y=-20;
			this.labelTxt.width=140;
			this.labelTxt.height=35;
			this.labelTxt.selectable=false;
			
			this.labelTxtMin=new TextField();
			this.labelTxtMin.setTextFormat(format);
			this.labelTxtMin.text=min;
			this.labelTxtMin.x=-70;
			this.labelTxtMin.y=2;
			this.labelTxtMin.width=130;
			this.labelTxtMin.height=20;
			this.labelTxtMin.selectable=false;
			
			this.labelTxtMax=new TextField();
			this.labelTxtMax.setTextFormat(format);
			this.labelTxtMax.text=max;
			this.labelTxtMax.x=60;
			this.labelTxtMax.y=2;
			this.labelTxtMax.width=130;
			this.labelTxtMax.height=20;
			this.labelTxtMax.selectable=false;
			//this.labelTxt.text="Resistance Resi:1000 Ohm";
			this.numberStepper=new NumericStepper();
			this.numberStepper.x=-30;
			this.numberStepper.y=10;
			this.numberStepper.maximum=max;
			this.numberStepper.minimum=min;
			this.numberStepper.stepSize=step;
			this.numberStepper.addEventListener(Event.CHANGE,changeVal);
			
			this.objArray=new Array();
			this.isCheckBoxSelected=false;
			
			this.x=xPos;
			this.y=yPos;
			//this.addChild(this.labelTxt);
			this.addChild(this.labelTxtMin);
			this.addChild(this.labelTxtMax);
			this.addChild(this.labelTxt);
			//this.addChild(this.numberStepper);
			this.addChild(this.slider);
		}
		
		function getVal(e:SliderEvent):void{
			trace(this.name);
			this.numberStepper.value=e.target.value;
			if(this.name=="resistorScroll"){
			this.labelTxt.text="Resistance Resi:"+e.target.value+" Ohm";
		    }else if(this.name=="batteryScroll"){
				this.labelTxt.text="Battery Volt:"+e.target.value+" V";
			}else if(this.name=="capasitorScroll"){
				this.labelTxt.text="Capasitor Value:"+e.target.value+" Micro F";
			}
			else if(this.name=="rotationScroll"){
				this.labelTxt.text="Component Rotation";
				
				if(this.objt.parent.startJunction.juncConnectedBb!=true ||this.objt.parent.endJunction.juncConnectedBb!=true || (this.objt.parent.baseJunction!=null && this.objt.parent.baseJunction.juncConnectedBb!=true)){
				this.objt.parent.rotation=this.numberStepper.value;
				}
			}
		}
		
		function updateVal(e:SliderEvent):void{
			
					if(this.name=="rotationScroll"){
						
										this.objt.parent.rotation=this.numberStepper.value;
										//this.objt.rotation=this.numberStepper.value;
						}else{
					setResistance(this.numberStepper.value);
					
					}
			
		}
		
		function setResistance(val:Number):void{
			var resistance:Number;
						trace("val-"+val+"--"+this.objt);
			//if(!this.isCheckBoxSelected){
				if(this.objt!=null){
					if(this.objt.parent.type=="battery"){
						this.objt.setVoltage(val);
						this.objt.lastChanged=true;
						Circuit.setBatteryVoltage(this.objt.parent.ids,val);
						
					}
					else if(this.objt.parent.type=="capacitorNew"){
						this.objt.setCapValue(val);
						this.objt.lastChanged=true;
						//Circuit.setBatteryVoltage(this.objt.parent.ids,val);
						
					}
					else if(this.objt.parent.type=="bulb" && this.labelTxt.text=="POWER RATING"){
						resistance=this.objt.setPowerRating(val);
						Circuit.setBulbProperties(this.objt.parent.ids,resistance,this.objt.powerRating,this.objt.voltageRating);
					}
					else if(this.objt.parent.type=="bulb" && this.labelTxt.text=="VOLTAGE RATING"){
						resistance=this.objt.setVoltageRating(val);
						Circuit.setBulbProperties(this.objt.parent.ids,resistance,this.objt.powerRating,this.objt.voltageRating);
					}
					else{
						trace("val-"+val);
						this.objt.setResistance(val);
						Circuit.setBranchResistance(this.objt.parent.ids,val);
					}
					this.objt.parent.setVal(StageBuilder.isShowValues);
					Circuit.circuitAlgorithm();
				}
			//}
			/*else{
				if(this.objArray.length!=0){
					var i:Number;
									
					if(this.objt.parent.type=="battery"){
						for(i=0;i<this.objArray.length;i++){
							this.objArray[i].setVoltage(val);
							this.objArray[i].parent.setVal(StageBuilder.isShowValues);
							Circuit.setBatteryVoltage(this.objArray[i].parent.ids,val);
						}
					}
					else if(this.objt.parent.type=="bulb" && this.labelTxt.text=="POWER RATING"){
						for(i=0;i<this.objArray.length;i++){
							resistance=this.objArray[i].setPowerRating(val);
							this.objArray[i].parent.setVal(StageBuilder.isShowValues);
							Circuit.setBulbProperties(this.objArray[i].parent.ids,resistance,this.objt.powerRating,this.objt.voltageRating);
						}
					}
					else if(this.objt.parent.type=="bulb" && this.labelTxt.text=="VOLTAGE RATING"){
						for(i=0;i<this.objArray.length;i++){
							resistance=this.objArray[i].setVoltageRating(val);
							this.objArray[i].parent.setVal(StageBuilder.isShowValues);
							Circuit.setBulbProperties(this.objArray[i].parent.ids,resistance,this.objArray[i].powerRating,this.objArray[i].voltageRating);
						}
					}
					else{
						for(i=0;i<this.objArray.length;i++){
							this.objArray[i].setResistance(val);
							this.objArray[i].parent.setVal(StageBuilder.isShowValues);
							Circuit.setBranchResistance(this.objArray[i].parent.ids,val);
						}
					}
					Circuit.circuitAlgorithm();
				}
			}*/
		}
		
		function setVal(e:MouseEvent):void{
			e.target.addEventListener(KeyboardEvent.KEY_DOWN,checkEnter);
		}
		
		//updates the value of property when the value of number stepper is changed
		function changeVal(e:Event):void{
			if(e.target.value>=this.slider.minimum && e.target.value<=this.slider.maximum){
					this.slider.value=e.target.value;
					
					if(this.name=="rotationScroll"){
						this.objt.rotation=180;
						}else{
					setResistance(e.target.value);
					
					}
					this.slider.setFocus();
					this.slider.focusEnabled;
					//this.labelTxt.text="RESISTANCE:"+e.target.value;
			}			
		}
		
		public function addObject(obj:Object):void{
			this.objArray.push(obj);
		}
	}	

}