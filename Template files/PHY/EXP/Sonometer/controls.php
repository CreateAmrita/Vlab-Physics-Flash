<ul style="right: -17px;" tabindex="0" class="overthrow content description">    
    <li> 
        <div class="varBox"> 
         <p class="varTitle" id="Ins1"></p> 
            <!---environment box1---->
            <select class="dropBox" id="Combo1" style="width:150px; margin:4px 0px 4px 20px;"></select>
            <br /> 
             <p class="varTitle" id="Ins2"></p>
             <!---wire material slider --->
            <select class="dropBox" id="materialCombo" style="width:150px; margin:4px 0px 4px 20px;"></select><br /><br />
            
            <!---wire diameter slider2---->
            <span class="varTitle" id="slidertxt1"></span>
            <span id="sliderspan1" class="varTitle"></span><br />
            
            <input style="margin:4px 0px 0px 20px;width:130px;" type="range" class="rangeSlider" min="0.1" max="0.5" id="slide_val2" name="slide_val2" value="0.1" step="0.1" onmousemove="setDiameter(this.value)" oninput="setDiameter(this.value)" /><br />
            <span id="rightminvals2" class="varTitle"></span>
            <span id="rightmaxvals2" class="varTitle"></span><br /><br /> 
            
                    	<!---weight on hanger slider---->
            <span class="varTitle" id="Ins01"></span>
            <span id="rightVal" class="varTitle"></span> 
            <input  style="margin:4px 0px 0px 20px;width:130px;" type="range" class="rangeSlider" min="0.5" max="5" id="slide_val1" name="slide_val1" value="0.5" step="0.5"  oninput="setWeight(this.value)" /><br />
            <span id="rightminvals" class="varTitle"></span>
            <span id="rightmaxvals" class="varTitle"></span><br /><br />
           
            <!---Right weight slider ---->
            <span class="varTitle" id="slidertxt" style="padding:0px 0px 0px 12px;"></span>
            <span id="sliderspan" class="varTitle"></span><br />
            <input style="margin:4px 0px 0px 20px;width:130px;" type="range" class="rangeSlider" min="300" max="600" id="slide_val3" name="slide_val3" value="300" step="10" onmousemove="setFrequency(this.value)" oninput="setFrequency(this.value)"/><br />
            <span id="rightminvals1" class="varTitle" ></span>
            <span id="rightmaxvals1" class="varTitle"></span><br /><br />
            <!---Bridge A slider ---->
            <span class="varTitle" id="bridgeA_ctrl_lbl" style="padding:0px 0px 0px 12px;"></span>
            <span id="bridgeA_ctrl_val" class="varTitle"></span><br />
            <input style="margin:4px 0px 0px 20px;width:130px;" type="range" class="rangeSlider" min="0" max="100" id="slide_val4" name="slide_val4" value="0" step=".1"  oninput="scaleAmotion(this.value)"/><br />
            <span id="bridgeA_lbl_min" class="varTitle" ></span>
            <span id="bridgeA_lbl_max" class="varTitle"></span><br /><br />
            <!---Bridge A slider ---->
            <span class="varTitle" id="bridgeB_ctrl_lbl" style="padding:0px 0px 0px 12px;"></span>
            <span id="bridgeB_ctrl_val" class="varTitle"></span><br />
            <input style="margin:4px 0px 0px 20px;width:130px;" type="range" class="rangeSlider" min="0" max="100" id="slide_val5" name="slide_val5" value="100" step=".1"  oninput="scaleBmotion(this.value)"/><br />
            <span id="bridgeB_lbl_min" class="varTitle" ></span>
            <span id="bridgeB_lbl_max" class="varTitle"></span><br /><br />
            <br />
			<p align="center"><input type="button" class="subButton" id="hitTfork" value="Xxxxxx"/></p>
            <br /><br />
            <p align="center"><input type="button" class="subButton" id="replacePaper" disabled/></p>
            <br /><br />
			<p align="center"><input type="button" class="subButton" id="reload"/></p><br/>
        </div>
    </li>
</ul>


