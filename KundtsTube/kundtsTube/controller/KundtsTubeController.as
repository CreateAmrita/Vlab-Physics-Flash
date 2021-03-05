/*
Developed under a Research grant from NMEICT, MHRD 
by 
Amrita CREATE (Center for Research in Advanced Technologies for Education), 
VALUE (Virtual Amrita Laboratories Universalizing Education)
Amrita University, India 2009 - 2013
http://www.amrita.edu/create
*/
package kundtsTube.controller{
	import kundtsTube.model.*;

	import flash.events.Event;
	import fl.events.SliderEvent;
	import flash.events.MouseEvent;

	public class KundtsTubeController {
		var model:KundtsTubeModel;
		/*var length;
		var radius;
		var power:Boolean = new Boolean();
		var X;
		var resistivity;*/
		public function KundtsTubeController(model:KundtsTubeModel) {
			// attach model
			this.model=model;
		}
		public function materialComboboxSelect(e:Event):KundtsTubeModel {

			if (e==null) {
				model.setMaterial("Iorn");
				//model.setDensity(7870);
				//model.setangleVarble(1.86);
			} else {
				if (e.target.selectedIndex==0) {
					model.setMaterial("Iorn");
					//model.setDensity(7870);
					//model.setangleVarble(1.86)
				} else if (e.target.selectedIndex == 1) {
					model.setMaterial("Aluminium");
					//model.setDensity(2710);
					//model.setangleVarble(1.49)
				} else if (e.target.selectedIndex == 2) {
					model.setMaterial("Brass");
					//model.setDensity(8400);
					//model.setangleVarble(2.77)
				}
			}
			return model;

		}
		
		public function PistonSlider_FN(e:SliderEvent):void {
			if (e==null) {
				model.setpistonLength(1);
			} else {
				model.setpistonLength(e.target.value);
			}
		}
		public function scaleSlider_FN(e:SliderEvent):void {
			if (e==null) {
				model.setscaleLength(0);
			}
			 else {
				model.setscaleLength(e.target.value);
			}
		}
		public function RodSlider_FN(e:SliderEvent):void {
			if (e==null) {
				model.setrodLength(1);
			} else {
				model.setrodLength(e.target.value);
			}
		}

	}
}