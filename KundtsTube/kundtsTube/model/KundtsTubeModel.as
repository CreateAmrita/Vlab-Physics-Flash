/*
Developed under a Research grant from NMEICT, MHRD 
by 
Amrita CREATE (Center for Research in Advanced Technologies for Education), 
VALUE (Virtual Amrita Laboratories Universalizing Education)
Amrita University, India 2009 - 2013
http://www.amrita.edu/create
*/
package kundtsTube.model{

	import kundtsTube.model.*;
	import kundtsTube.view.*;
	//import kundtsTube.controller.*;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display.MovieClip;

	public class KundtsTubeModel extends EventDispatcher {

		public static const UPDATE:String='update';


		/*var power:Boolean = new Boolean();
		var mainvoltage:Number;
		var guardvoltage:Number;
		
		var pi:Number = 3.14;
		var material;
		var thermalConductivity:Number; 
		var Diameter:Number;
		var Thickness:Number;
		var coldTemperture:Number;
		var meteralArea:Number;
		var powerQ:Number;
		var T;
		var currentTemp;
		*/

		var pistonLength:Number;
		var material;
		var Density;
		var angleVarble;
		var rodLength;
		var frequency;
		var heap_number;
		var heap_d;
		var youngs_mod;
		var scalelength;
		public function KundtsTubeModel() {
			//create the data model
		}


		public function setpistonLength(pistonLength:Number) {
			this.pistonLength=pistonLength;

		}
		public function setrodLength(rodLength:Number) {
			this.rodLength=rodLength;
			
		}
		public function setscaleLength(scalelength:Number){
			this.scalelength=scalelength;
		}
		public function getscaleLength():Number{
			return scalelength;
		}
		public function getrodLength():Number {
			return rodLength;
		}
		public function getpistonLength():Number {
			return pistonLength;
		}
		public function setMaterial(material:String) {
			this.material=material;
		}
		public function getMaterial():String {
			return material;
		}
		public function setDensity(Density:Number) {
			this.Density=Density;
		}
		public function getDensity():Number {
			return Density;
		}
		public function setangleVarble(angleVarble:Number) {
			this.angleVarble=angleVarble;
		}
		public function getangleVarble():Number {
			return angleVarble;
		}
		public function number_of_HeapFN(air_len:Number,f:Number,v:Number):Number {
			heap_number=2*air_len*f/v;
			//trace(heap_number+"heap_number")
			return heap_number;
		}
		public function heap_distanceFN(heap_n:Number,a:Number):Number {
			heap_d=a/heap_n;
			
			return heap_d;
		}


		public function frequency_FN(len:Number,v:Number):Number {
			frequency=v/(2*len);
			//trace(frequency)
			return frequency;
		}

		public function youngs_modulusFN(d:Number,s:Number):Number {
			youngs_mod=s*s*d;
			
			return youngs_mod;
		}

		function notifyObservers():void {
			// broadcastMessage
			dispatchEvent(new Event(KundtsTubeModel.UPDATE));
		}
	}
}