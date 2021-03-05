/*
Developed under a Research grant from NMEICT, MHRD 
by 
Amrita CREATE (Center for Research in Advanced Technologies for Education), 
VALUE (Virtual Amrita Laboratories Universalizing Education)
Amrita University, India 2009 - 2013
http://www.amrita.edu/create
*/
package kundtsTube{

	public class KundtsTube {

		import kundtsTube.model.*;
		import kundtsTube.view.*;
		import kundtsTube.controller.*;
		import flash.display.MovieClip;
		import flash.text.TextFormat;

		private var mb_model:KundtsTubeModel;
		private var mb_controller:KundtsTubeController;
		private var mb_view:KundtsTubeView;
		
		public function KundtsTube(holder:Object, positionX:Number, positionY:Number,loadFont:Object,FontName:String,fullmovie:MovieClip,lan:String,Embedded_Font_Format:TextFormat) {

			// create the data model
			mb_model = new KundtsTubeModel();
			// create the controller
			mb_controller=new KundtsTubeController(mb_model);
			// create the view   
			mb_view=new KundtsTubeView(mb_model,mb_controller,holder,positionX,positionY,loadFont,FontName,fullmovie,lan,Embedded_Font_Format);


			// add mb_view as a listener to the mb_model
			//mb_model.addEventListener(NaturalConvectionModel.UPDATE, mb_view.update);

		}

	}
}