/*
Developed under a Research grant from NMEICT, MHRD 
by 
Amrita CREATE (Center for Research in Advanced Technologies for Education), 
VALUE (Virtual Amrita Laboratories Universalizing Education)
Amrita University, India 2009 - 2013
http://www.amrita.edu/create
*/
package kundtsTube.view{
	import kundtsTube.*;
	import kundtsTube.model.*;
	import kundtsTube.view.*;
	import kundtsTube.controller.*;
	import flash.display.MovieClip;
	import fl.lang.Locale;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import fl.controls.ComboBox;
	import flash.events.MouseEvent;
	import fl.controls.Slider;
	import fl.events.SliderEvent;
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.Label;
	import flash.geom.ColorTransform;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;



	public class KundtsTubeView {
		var model:KundtsTubeModel;
		var controller:KundtsTubeController;
		var objStage:Object;
		var fullmovie:MovieClip;
		var lan:String;
		var positionX;
		var positionY;
		var loadFont;
		var FontName;
		var format:TextFormat=new TextFormat();

		var materialCombobox:ComboBox;
		var PistonSlider:Slider;
		var RodSlider:Slider;
		var scaleSlider:Slider;

		var Start_btn:Button;
		var reset_btn:Button;
		var crossSectionChk:CheckBox=new CheckBox();
		var showResultChk:CheckBox=new CheckBox();
		var thermalConductvty:TextField = new TextField();
		var result1txt:TextField;
		var result2txt:TextField;
		var result1_1txt:TextField;
		var result2_1txt:TextField;
		var materialComboboxLabels:Array;
		var mbMc_view:KundtsTubeMovieclip = new KundtsTubeMovieclip();
		var heapmc:heap;
		var heap_vibratemc:heap_vibration;
		var soundFile:Sound = new Sound();
		var someChannel:SoundChannel = new SoundChannel();
		var someTransform:SoundTransform = new SoundTransform();
		var mc:MovieClip=new MovieClip();
		var speedX:Number=2.95;
		var speedAngle:Number=0.2;
		var range:Number=4;
		var angle:Number=0;
		var xpos:Number=0;
		var ypos:Number=0;
		var centerY:Number=50;
		var heapreversearray:Array=new Array();
		var heapcreation_array:Array=new Array();
		

		var space:Number;
		var scale1_X=1;
		var intscale1_X;
		var sound_velocity=5130;
		var density=7.87E+03;
		var velocity_air=343;
		var frequency=2565;
		var aircolumn_len=.95;
		var heap_number:Number=14;
		var heap1=12;
		var heap_distance=0;
		var youngs_modulus=2.07E+11;
		var xval=-980;
		var yval=80;
		var heapflag:Boolean=false;
		var heapflag1:Boolean=false;
		var soundflag:Boolean=false;
		var startflag:Boolean=false;
		var vibrateflag:Boolean=false;
		var muteflag:Boolean=false;
		var unmuteflag:Boolean=false;
		var heapnumber:Number=0;
		var temp:MovieClip;
		var temp_mc1:MovieClip;
		var interval;
		var intervalid;
		var count:Number=0;
		var pistonvalue=0;
		var h1=13;
		var Xposition:Number=186.85;
		var pos:Number=186.85;
		var id;
		var xx=0;
		var count1=0;
		var heapcount;
		var heaps=.8;
		var increment=31.4;
		var scalevalue:Number;
		var EIndex:Number;
		/************************************************/


		public function KundtsTubeView(model:KundtsTubeModel,controller:KundtsTubeController,holder:Object, positionX:Number, positionY:Number,loadFont:Object,FontName:String,fullmovie:MovieClip,lan:String,Embedded_Font_Format:TextFormat) {
			this.model=model;
			this.controller=controller;
			this.objStage=holder;
			this.loadFont=loadFont;
			this.FontName=FontName;
			this.fullmovie=fullmovie;
			this.lan=lan;
			this.positionX=positionX;
			this.positionY=positionY;
			format=Embedded_Font_Format;
			
			Locale.addXMLPath(lan, "KundtsTube_"+lan+".xml");
			Locale.setLoadCallback(onLoaded);
			Locale.loadLanguageXML(lan);
		}
		public function update(e:Event):void {

		}

		public function PistonSlider_FN(e:SliderEvent) {
			
			RodSlider.enabled=false;
			count=count+1;
			if (count==1) {
				if (vibrateflag==true) {
					clearInterval(id);
				}
			}
	
			if (heapflag==false) {
				heapflag=true;
			}
			mc.x=-270;
			//objStage.Exp_Content.total.zoom1.scale1.x=intscale1_X;
			controller.PistonSlider_FN(e);
			PistonSlider.getChildAt(4).text=PistonSlider.value+" cm";
			objStage.Exp_Content.total.piston.gotoAndStop(model.getpistonLength())
			//objStage.Exp_Content.total.piston.piston_iron.iron.gotoAndStop(model.getpistonLength())
			
			aircolumn_len=(100-model.getpistonLength())/100;
			heap_number=model.number_of_HeapFN(aircolumn_len,frequency,velocity_air);
			heap_distance=model.heap_distanceFN(heap_number,aircolumn_len);
			heap_number=Math.round(heap_number);
			heapcount=model.number_of_HeapFN(heaps,frequency,velocity_air);
			heapcount=Math.round(heapcount);
			if ((model.getpistonLength()<16)||(model.getpistonLength()>26)) {

				if (heapcreation_array.length!=0) {
					objStage.Exp_Content.total.zoom1.scale1.removeChild(temp_mc1);
					heapflag1=false;
					heapcreation_array=new Array();
				}

				if (Start_btn.enabled==false) {
					objStage.addEventListener(Event.ENTER_FRAME,vibration_Fn);
				}

			} else if (Start_btn.enabled==false) {

				objStage.removeEventListener(Event.ENTER_FRAME,vibration_Fn);
				objStage.Exp_Content.total.zoom1.heap_vibrate.visible=false;
				objStage.Exp_Content.total.zoom1.heap_vibrate.stop();
			}
			if (! Start_btn.enabled) {
				if (heapcreation_array.length==0) {
					if ((model.getpistonLength()>15)&&(model.getpistonLength()<27)) {
						temp_mc1=new MovieClip();
						objStage.Exp_Content.total.zoom1.scale1.addChild(temp_mc1);
						for (var j:Number=0; j<heapcount; j++) {
							HeapCreation_FN(j);

						}
					}
				}
			}

			if (model.getpistonLength()<15) {
				if(muteflag==false){
	
				volumeControl(.5);
				}
			}

			if (model.getpistonLength()>15) {

			
				if (model.getpistonLength()==16) {
					for (var i:Number=0; i<heapcreation_array.length; i++) {
						heapcreation_array[i].gotoAndPlay(1);
						
						}
						if(muteflag==false){
	
						volumeControl(.5);
						}

				} else if (model.getpistonLength()==17) {
					for (var i:Number=0; i<heapcreation_array.length; i++) {
						heapcreation_array[i].gotoAndPlay(10);
						
					}
					if(muteflag==false){
					volumeControl(.5);
					}
				} else if (model.getpistonLength()==18) {
					for (var i:Number=0; i<heapcreation_array.length; i++) {
						heapcreation_array[i].gotoAndPlay(14);
						
					}
					if(muteflag==false){
					volumeControl(1);
					}
				} else if (model.getpistonLength()==19) {
					for (var i:Number=0; i<heapcreation_array.length; i++) {
						heapcreation_array[i].gotoAndPlay(22);
						
					}
					if(muteflag==false){
					volumeControl(1.5);
					}
				} else if (model.getpistonLength()==20) {
					for (var i:Number=0; i<heapcreation_array.length; i++) {
						heapcreation_array[i].gotoAndPlay(26);
						
					}
					if(muteflag==false){
					volumeControl(2);
					}
				} else if (model.getpistonLength()==21) {
					for (var i:Number=0; i<heapcreation_array.length; i++) {
						heapcreation_array[i].gotoAndPlay(34);
						
					}
					if(muteflag==false){
					volumeControl(1.5);
					}
				} else if (model.getpistonLength()==22) {
					for (var i:Number=0; i<heapcreation_array.length; i++) {
						heapcreation_array[i].gotoAndPlay(38);
						
					}
					if(muteflag==false){
					volumeControl(1.5);
					}
				} else if (model.getpistonLength()==23) {
					for (var i:Number=0; i<heapcreation_array.length; i++) {
						heapcreation_array[i].gotoAndPlay(42);
						
					}
					if(muteflag==false){
					volumeControl(1);
					}
				} else if (model.getpistonLength()==24) {
					for (var i:Number=0; i<heapcreation_array.length; i++) {
						heapcreation_array[i].gotoAndPlay(48);
						
					}
					if(muteflag==false){
					volumeControl(1);
					}
				} else if (model.getpistonLength()==25) {
					for (var i:Number=0; i<heapcreation_array.length; i++) {
						heapcreation_array[i].gotoAndPlay(52);
						
					}
					if(muteflag==false){
					volumeControl(1);
					}
				} else if (model.getpistonLength()==26) {
					for (var i:Number=0; i<heapcreation_array.length; i++) {
						heapcreation_array[i].gotoAndPlay(58);
						
					}
					if(muteflag==false){
					volumeControl(.5);
					}
				} else {
					if(muteflag==false){
					volumeControl(.5);
					}
				}

			}
			
		}
		function sound() {
			count1=count1+1;
			
			if (! Start_btn.enabled) {
				soundFile.addEventListener(SampleDataEvent.SAMPLE_DATA,tfSoundGenerator);
				someChannel=soundFile.play();
				someChannel.addEventListener(Event.SOUND_COMPLETE, doSoundComplete);
			} else {
				soundFile.removeEventListener(SampleDataEvent.SAMPLE_DATA,tfSoundGenerator);
				someChannel.removeEventListener(Event.SOUND_COMPLETE, doSoundComplete);
			}

		}
		function tfSoundGenerator(event:SampleDataEvent):void {
			for (var c:int=0; c<8192; c++) {

				event.data.writeFloat(Math.sin((Number(c+event.position)/Math.PI/2))*0.25);
				event.data.writeFloat(Math.sin((Number(c+event.position)/Math.PI/2))*0.25);
			}
		}
		function doSoundComplete(event:Event):void {
			sound();
		}

		function volumeControl(vol:Number) {
			someTransform.volume=vol;
			someChannel.soundTransform=someTransform;
		}
		function HeapCreation_FN(j:Number) {
			if (heapflag1==false) {
				heapflag1=true;
			}
			heapmc=new heap();
			temp_mc1.addChild(heapmc);

			heapmc.gotoAndStop(1);
			heapcreation_array.push(heapmc);
			heapcreation_array[j].x=xval+(j*Xposition);
			heapcreation_array[j].y=yval;
			/*if (j==heap_number-1) {
			heapflag=false;
			}*/

		}

		function vibrate() {

			objStage.Exp_Content.total.zoom1.heap_vibrate.visible=true;
			objStage.Exp_Content.total.zoom1.heap_vibrate.play();
			if ((PistonSlider.value>15)&&(PistonSlider.value<27)) {
				if (Start_btn.enabled==false) {
					clearInterval(interval);
					objStage.Exp_Content.total.zoom1.heap_vibrate.visible=false;
					objStage.Exp_Content.total.zoom1.heap_vibrate.stop();
				}
			}
		}
		function vibration_Fn(e:Event) {
			objStage.Exp_Content.total.zoom1.heap_vibrate.visible=true;
			objStage.Exp_Content.total.zoom1.heap_vibrate.play();
		}
		function remove() {

			heapflag1=false;
			objStage.Exp_Content.total.zoom1.scale1.removeChild(temp_mc1);
			heapcreation_array = new Array();
		}

		function RodSlider_FN(e:SliderEvent) {
			controller.RodSlider_FN(e);
			RodSlider.getChildAt(4).text=RodSlider.value+" m";
			frequency=model.frequency_FN(model.getrodLength(),sound_velocity);
			heap_number=model.number_of_HeapFN(aircolumn_len,frequency,velocity_air);
			heap_distance=model.heap_distanceFN(heap_number,aircolumn_len);
			Xposition=pos;
			Xposition=Xposition*model.getrodLength();
			
			objStage.Exp_Content.total.ironrod_ani.gotoAndStop((model.getrodLength()-1)*12)
			objStage.Exp_Content.total.aluminium_ani.gotoAndStop((model.getrodLength()-1)*12)
			objStage.Exp_Content.total.brass_ani.gotoAndStop((model.getrodLength()-1)*12)
			//objStage.Exp_Content.total.aluminium_rod.gotoAndStop(model.getrodLength()*5)
			//objStage.Exp_Content.total.brass_rod.gotoAndStop(model.getrodLength()*5)
			
		}
		public function forward_FN(e:MouseEvent) {
			
			if((scaleSlider.value>=0)&&(scaleSlider.value<100)){
			scale1_X=objStage.Exp_Content.total.zoom1.scale1.x-35.95
			objStage.Exp_Content.total.zoom1.scale1.x=scale1_X;
			scaleSlider.value=scaleSlider.value+1;
			scaleSlider.getChildAt(4).text=scaleSlider.value+" cm";
			
			}
		}
		public function backward_FN(e:MouseEvent) {
			
			if((scaleSlider.value>0)&&(scaleSlider.value<=100)){
			scale1_X=objStage.Exp_Content.total.zoom1.scale1.x+35.95
			objStage.Exp_Content.total.zoom1.scale1.x=scale1_X;
			scaleSlider.value=scaleSlider.value-1;
			scaleSlider.getChildAt(4).text=scaleSlider.value+" cm";
			
			}
					}
		function scaleslider_FN(e:SliderEvent){
			controller.scaleSlider_FN(e);
			scaleSlider.getChildAt(4).text=scaleSlider.value+" cm";
			scale1_X=1156.7-((model.getscaleLength()/.1)*3.59)//607
			objStage.Exp_Content.total.zoom1.scale1.x=scale1_X
			
		}

		public function materialComboboxSelect(e:Event) {
			clearInterval(id);
			controller.materialComboboxSelect(e);
			if (materialCombobox.selectedIndex==0) {
				Xposition=186.85;
				pos=186.85;
				heap1=12;
				density=7.87E+03;
				sound_velocity=5130;
				frequency=2565;
				
				objStage.Exp_Content.total.iron_rod.visible=true;
				objStage.Exp_Content.total.ironrod_ani.visible=true;
				objStage.Exp_Content.total.aluminium_rod.visible=false;
				objStage.Exp_Content.total.aluminium_ani.vsible=false;
				objStage.Exp_Content.total.brass_rod.visible=false;
				objStage.Exp_Content.total.brass_ani.visible=false;


			} else if (materialCombobox.selectedIndex==1) {
				Xposition=150;
				pos=150;
				heap1=15;
				density=2.71E+03;
				sound_velocity=6420;
				frequency=3210;
				
				objStage.Exp_Content.total.iron_rod.visible=false;
				objStage.Exp_Content.total.ironrod_ani.visible=false;
				objStage.Exp_Content.total.aluminium_rod.visible=true;
				objStage.Exp_Content.total.aluminium_ani.visible=true;
				objStage.Exp_Content.total.brass_rod.visible=false;
				objStage.Exp_Content.total.brass_ani.visible=false;


			} else if (materialCombobox.selectedIndex==2) {
				Xposition=276.5;
				pos=276.5;
				heap1=8;
				density=8.40E+03;
				sound_velocity=3475;
				frequency=1737.5;
				
				objStage.Exp_Content.total.iron_rod.visible=false;
				objStage.Exp_Content.total.ironrod_ani.visible=false;
				objStage.Exp_Content.total.aluminium_rod.visible=false;
				objStage.Exp_Content.total.aluminium_ani.visible=false;
				objStage.Exp_Content.total.brass_rod.visible=true;
				objStage.Exp_Content.total.brass_ani.visible=true;

			}
			youngs_modulus=model.youngs_modulusFN(density,sound_velocity);
			
			if (Start_btn.enabled==false) {
			result1txt.text=Locale.loadString("IDS_VELOCITY")+": "+sound_velocity;
			result1_1txt.text=sound_velocity+" ms¯¹";
			result2txt.text=Locale.loadString("IDS_YOUNGS")+": "+youngs_modulus.toExponential(2);
			result2_1txt.text=youngs_modulus.toExponential(2)+" Nm¯²";
			
			}
		}
		function Start_btn_FN(e:MouseEvent) {
			if (startflag==false) {
				startflag=true;
			}
			Start_btn.enabled=false;
			materialCombobox.enabled=false;
			//objStage.Exp_Content.total.rubbing.visible=true;
			//objStage.Exp_Content.total.rubbing.gotoAndPlay(1);
			id=setInterval(ctrlenable,5);
		}
		function ctrlenable() {
			xx=xx+1;
			if (xx==5) {
				sound();
				
				if(muteflag==false){
				volumeControl(.5);
				}else{
					volumeControl(0);
				}
				if (vibrateflag==false) {
					vibrateflag=true;
				}
				interval=setInterval(vibrate,0);
				clearInterval(id);
				
				PistonSlider.enabled=true;
				
			}
		}
		function reset_FN(e:MouseEvent) {
			muteflag=false;
			if (heapflag1==true) {
				remove();
			}
			if (startflag==true) {
				clearInterval(interval);
				xx=0;
				//objStage.Exp_Content.total.rubbing.visible=false;
				//objStage.Exp_Content.total.rubbing.gotoAndStop(1);
			}
			objStage.removeEventListener(Event.ENTER_FRAME,vibration_Fn);
			volumeControl(0);
			someChannel = new SoundChannel();
			someTransform = new SoundTransform();
			soundFile.removeEventListener(SampleDataEvent.SAMPLE_DATA,tfSoundGenerator);
			someChannel.removeEventListener(Event.SOUND_COMPLETE, doSoundComplete);
			Xposition=186.85;
			pos=186.85;
			density=7.87E+03;
			sound_velocity=5130;
			frequency=2565;
			materialCombobox.selectedIndex=0;
			Start_btn.enabled=true;
			materialCombobox.enabled=true;
			PistonSlider.enabled=false;
			RodSlider.enabled=true;
			showResultChk.enabled=true;
			scaleSlider.value=32;
			scaleSlider.getChildAt(4).text=scaleSlider.value+" cm";
			PistonSlider.value=5;
			PistonSlider.getChildAt(4).text=PistonSlider.value+" cm";
			RodSlider.value=1;
			RodSlider.getChildAt(4).text=RodSlider.value+" m";
			showResultChk.selected=false;
			result1txt.defaultTextFormat=format;
			result2txt.defaultTextFormat=format;
			result1txt.text=Locale.loadString("IDS_VELOCITY")+": ";
			result1_1txt.text="";
			result2txt.text=Locale.loadString("IDS_YOUNGS")+": ";
			result2_1txt.text="";
			youngs_modulus=2.07E+11;
			objStage.Exp_Content.total.zoom1.heap_vibrate.visible=true;
			objStage.Exp_Content.total.zoom1.heap_vibrate.stop();
			objStage.Exp_Content.total.zoom1.scale1.x=9.65;
			objStage.Exp_Content.total.iron_rod.visible=true;
			//objStage.Exp_Content.total.aluminium_rod.visible=false;
			//objStage.Exp_Content.total.brass_rod.visible=false;
			objStage.Exp_Content.unmute.visible=false;
			objStage.Exp_Content.mutesymbol.visible=true;
			objStage.Exp_Content.total.piston.gotoAndStop(1);
			objStage.Exp_Content.total.ironrod_ani.gotoAndStop(1)
			objStage.Exp_Content.total.aluminium_ani.gotoAndStop(1)
			objStage.Exp_Content.total.brass_ani.gotoAndStop(1)
			
		}
		function showResult(e:MouseEvent) {
			if (showResultChk.selected==true) {
				if (Start_btn.enabled==false) {
					result1txt.defaultTextFormat=format;
					result2txt.defaultTextFormat=format;
					result1_1txt.defaultTextFormat=format;
					result2_1txt.defaultTextFormat=format;
					result1txt.text=Locale.loadString("IDS_VELOCITY")+": ";
					result1_1txt.text=sound_velocity+" ms¯¹";
					result2txt.text=Locale.loadString("IDS_YOUNGS")+": ";
					
					var rslt=youngs_modulus.toExponential(2);
					
			var IString:String=rslt;
			trace(IString+" IString")
			var EString="e";
			//trace("Index of:"+IString.indexOf("e"));
			if (IString.indexOf("e")!=-1) {
				var SplitedIArry:Array=IString.split("e+");
				var a:Number=SplitedIArry[0];
				trace(a+" a")
				var b:String=SplitedIArry[1];
				trace(b+" b")
				var IStr:String=a.toFixed(2)+" x 10¹¹";
				
			}
					result2_1txt.text=IStr+"  Nm¯²";
				}
				
			}else{
					result1txt.defaultTextFormat=format;
					result2txt.defaultTextFormat=format;
					result1txt.text=Locale.loadString("IDS_VELOCITY")+": ";
					result1_1txt.text="";
					result2txt.text=Locale.loadString("IDS_YOUNGS")+": ";
					result2_1txt.text="";
			}
		}
		function mute_FN(e:MouseEvent){
			if(muteflag==false){
				muteflag=true;
			}
			volumeControl(0);
			objStage.Exp_Content.mutesymbol.visible=false;
			objStage.Exp_Content.unmute.visible=true;
		}
		function unmute_FN(e:MouseEvent){
			if(muteflag==true){
				muteflag=false;
			}
			//volumeControl(.5)
			objStage.Exp_Content.mutesymbol.visible=true;
			objStage.Exp_Content.unmute.visible=false;
			
				if (model.getpistonLength()==16) {
					if(muteflag==false){
						volumeControl(.5);}
				} else if (model.getpistonLength()==17) {
					if(muteflag==false){
						volumeControl(.5);}
				} else if (model.getpistonLength()==18) {
					if(muteflag==false){
						volumeControl(1);}
					
				} else if (model.getpistonLength()==19) {
					if(muteflag==false){
						
						volumeControl(1.5);}

					
				} else if (model.getpistonLength()==20) {
					if(muteflag==false){
						volumeControl(2);}

					
				} else if (model.getpistonLength()==21) {
					if(muteflag==false){
						volumeControl(1.5);}

				} else if (model.getpistonLength()==22) {
					if(muteflag==false){
						volumeControl(1.5);}

					
				} else if (model.getpistonLength()==23) {
					if(muteflag==false){
						volumeControl(1);}

					
				} else if (model.getpistonLength()==24) {
					if(muteflag==false){
						volumeControl(1);}

					
				} else if (model.getpistonLength()==25) {
					if(muteflag==false){
						volumeControl(1);}

					
				} else if (model.getpistonLength()==26) {
					if(muteflag==false){
						volumeControl(.5);}

					} else {
						if(muteflag==false){
					volumeControl(.5);}
				}

		}
		function onLoaded(success:Boolean):void {
			
			objStage.Exp_Content.total.zoom1.heap.visible=false;
			//objStage.Exp_Content.total.rubbing.visible=false;
			objStage.Exp_Content.total.zoom1.heap_vibrate.visible=true;
			objStage.Exp_Content.total.piston.piston_iron.visible=true;
			
			objStage.Exp_Content.total.iron_rod.visible=true;
				objStage.Exp_Content.total.ironrod_ani.visible=true;
				objStage.Exp_Content.total.aluminium_rod.visible=false;
				objStage.Exp_Content.total.aluminium_ani.visible=false;
				objStage.Exp_Content.total.brass_rod.visible=false;
				objStage.Exp_Content.total.brass_ani.visible=false;
			mbMc_view.createTextField(objStage.Menu_Content1,Locale.loadString("IDS_CHOOSEMATERIAL"),false,positionX,positionY-45,165,format);
			materialCombobox = new ComboBox();
			materialComboboxLabels=new Array(Locale.loadString("IDS_IRON"),Locale.loadString("IDS_ALUMINIUM"),Locale.loadString("IDS_BRASS"));//making a label array for the choose type
			materialCombobox=mbMc_view.createComboBox(materialComboboxLabels,"materialCombobox",positionX,positionY-25,157);
			objStage.Menu_Content1.addChild(materialCombobox);
			materialCombobox.enabled=true;
			materialCombobox.addEventListener(Event.CHANGE,materialComboboxSelect);
			
			Start_btn = new Button();
			Start_btn=mbMc_view.createButton(Locale.loadString("IDS_START"),positionX+30,materialCombobox.y+50,90,true);
			objStage.Menu_Content1.addChild(Start_btn);
			Start_btn.addEventListener(MouseEvent.MOUSE_DOWN,Start_btn_FN);
			
			//RodSlider
			RodSlider=new Slider();
			RodSlider=fullmovie.makeSlider(materialCombobox.x+5,Start_btn.y+50,1,5,135,50,Locale.loadString("IDS_RODPOSITION"),1,0);
			objStage.Menu_Content1.addChild(RodSlider);
			//RodSlider.value=RodSlider.minimum;
			RodSlider.name="RodSlider";
			RodSlider.value=1;
			RodSlider.getChildAt(2).visible=false;
			RodSlider.getChildAt(4).text=RodSlider.value+" m";
			RodSlider.getChildAt(4).x=120;
			RodSlider.enabled=true;
			RodSlider.addEventListener(SliderEvent.CHANGE, RodSlider_FN);
			
			PistonSlider = new Slider();
			PistonSlider=fullmovie.makeSlider(materialCombobox.x+5,RodSlider.y+50,1,50,135,50,Locale.loadString("IDS_PISTONPOSITION"),1,0);
			objStage.Menu_Content1.addChild(PistonSlider);
			PistonSlider.name="PistonSlider";
			PistonSlider.value=5;
			PistonSlider.getChildAt(2).visible=false;
			PistonSlider.getChildAt(4).text=PistonSlider.value+" cm";
			PistonSlider.enabled=false;
			PistonSlider.addEventListener(SliderEvent.CHANGE, PistonSlider_FN);
			
			scaleSlider=new Slider();
			scaleSlider=fullmovie.makeSlider(materialCombobox.x+5,PistonSlider.y+50,0,100,135,50,Locale.loadString("IDS_SCALE"),.1,0);
			objStage.Menu_Content1.addChild(scaleSlider);
			scaleSlider.name="PistonSlider";
			scaleSlider.value=32;
			scaleSlider.getChildAt(2).visible=false;
			scaleSlider.getChildAt(4).text=scaleSlider.value+" cm";
			//scaleSlider.enabled=false;
			scaleSlider.addEventListener(SliderEvent.CHANGE, scaleslider_FN);

			result1txt=new TextField();
			result1txt=mbMc_view.createTextField(objStage.Menu_Content2,Locale.loadString("IDS_VELOCITY"),false,positionX,positionY+10,165,format);
			result1txt.visible=true;
			result1_1txt=new TextField();
			result1_1txt=mbMc_view.createTextField1(objStage.Menu_Content2,false,positionX,result1txt.y+15,165,format);
			result1_1txt.visible=true;
			result2txt=new TextField();
			result2txt=mbMc_view.createTextField(objStage.Menu_Content2,Locale.loadString("IDS_YOUNGS"),false,positionX,result1_1txt.y+20,165,format);
			result2txt.visible=true;
			result2_1txt=new TextField();
			result2_1txt=mbMc_view.createTextField1(objStage.Menu_Content2,false,positionX,result2txt.y+20,200,format);
			result2_1txt.visible=true;
			
			showResultChk=mbMc_view.createCheckBox(Locale.loadString("IDS_SHOWRESULT"),Start_btn.x,scaleSlider.y+50,150);
			objStage.Menu_Content1.addChild(showResultChk);
			showResultChk.enabled=true;
			showResultChk.addEventListener(MouseEvent.CLICK,showResult);
			reset_btn = new Button();
			reset_btn=mbMc_view.createButton(Locale.loadString("IDS_RESET"),Start_btn.x,showResultChk.y+40,90,true);
			objStage.Menu_Content1.addChild(reset_btn);
			reset_btn.addEventListener(MouseEvent.MOUSE_DOWN,reset_FN);
			reset_FN(null);

			intscale1_X=objStage.Exp_Content.total.zoom1.scale1.x;
			objStage.Exp_Content.forwardArrow.addEventListener(MouseEvent.MOUSE_DOWN,forward_FN);
			objStage.Exp_Content.backwardArrow.addEventListener(MouseEvent.MOUSE_DOWN,backward_FN);
			objStage.Exp_Content.mutesymbol.x=objStage.Exp_Content.unmute.x;
			objStage.Exp_Content.unmute.visible=false;
			objStage.Exp_Content.mutesymbol.buttonMode=true;
			objStage.Exp_Content.unmute.buttonMode=true;
			objStage.Exp_Content.mutesymbol.addEventListener(MouseEvent.CLICK,mute_FN);
			objStage.Exp_Content.unmute.addEventListener(MouseEvent.CLICK,unmute_FN);
			
		}

	}
}