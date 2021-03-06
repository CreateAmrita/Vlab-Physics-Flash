//*--Ready function---------
var gt,c,ctx,waveY=74,waveY2=74,waveHeight=true;
var controlLabel,InsArray,opt1,opt2,combo_2val=0;
var Q=0.5,Q1=0.1,color_arr;
var minAB=0,maxAB=100;
var scaleAlft,bridgeAlft;
var materialColor=["#ce6f59","#d9e3ec","#cfcfc3","#988076"];
var g,density;
var envioIndx=0;
var material=0;
var distance,bridgeDist=100,prevBriDist=100;
var frqcy=300;
var bridgeAlft,bridgeBlft;
var valueA=0,valueB=100;
var paperLft,clrvibratePaper;
var clrWavelft,clrWaveRgt;
var m,M=0.5,T,diameter=0.1,r;
var clr,vibrating=false,amplitude=4;
var prevVal,paperFall=false,paperTop=163,paperLmt=false;
var preValA=1,preValB=100;
var vibrSpeed=7;
var resonacLengths=[],tempDist;
var distancePre,distancePost;
var popMSG,vibrating=false;
var hited=false,waveYtemp;
function setMaterial(val){
	Q1=val;
	$("#sliderspan1").html(Q1+' mm');
	$("#wire").css({'height':val*5+'px'});
}
function setDiameter(val){
	diameter=Q1=val;
	$("#sliderspan1").html(Q1+' mm');
	$("#wire").css({'height':val*5+'px'});
	$("#wireInWeight").css({'width':val*5+'px'});
	calculateDistance();
}
function setWeight(val){
	M=val;
	calculateDistance();
	for(i=10;i<=val*10;i=i+5){
			$("#weight_"+i).show();
	}
	for(i=(val*10)+5;i<=50;i=i+5){
		$("#weight_"+i).hide();
	}
	Q=val;
	$("#rightVal,#arrow_txt").html(Q+' kg');
	
}
function setFrequency(val){
	frqcy=val;
	calculateDistance();
	$("#sliderspan").html(frqcy+' Hz');
}
function setAmplitude(){
	if(amplitude<=2){amplitude=amplitude+2}
	if(amplitude>=62){amplitude=amplitude-2}
	if(bridgeDist+1<resonacLengths[resonacLengths.length-2] && bridgeDist-2>resonacLengths[0]){	
		if(prevBriDist>=bridgeDist){
			distance=distancePre;
		}else{
			distance=distancePost;
		}
	}
	var shortestDistPre=bridgeDist-distancePre;
	if(shortestDistPre<0){
		shortestDistPre=shortestDistPre*-1;
	}
	var shortestDistPost=bridgeDist-distancePost;
	if(shortestDistPost<0){
		shortestDistPost=shortestDistPost*-1;
	}
	distance=shortestDistPre<=shortestDistPost?distancePre:distancePost;
/*	if(prevBriDist>=bridgeDist){
		distance=distancePre;
	}else{
		distance=distancePost;
	}*/
	
	if(bridgeDist<(distance+30) && amplitude<62 && amplitude>2){
		
		if(bridgeDist<=(distance+2) && bridgeDist>=(distance-2)&& !vibrating && hited){
			startVibration();
		}else{
			if(vibrating && (bridgeDist>=(distance+2) || bridgeDist<=(distance-2))){
				clearInterval(clr);
				clearInterval(clrvibratePaper);
				waveYtemp=waveY;
				waveY=74;
				ctx.clearRect(0,0,160,150);
				ctx.beginPath();
				ctx.moveTo(0, 74);
				ctx.strokeStyle=materialColor[material];
				ctx.bezierCurveTo(80, waveY, 80, waveY, 160, 74);
				ctx.stroke();
				if(!paperFall){
					$("#paperSmall").css({'top':'163px'});
					ctx.beginPath();
					ctx.fillStyle="#FFFFFF";
					ctx.fillRect(74,72,14,14);
					ctx.stroke();
				}
				vibrating=false;
			}
			
		}
		if(prevBriDist>=bridgeDist){
			amplitude=amplitude+((distance+30)-bridgeDist);
			if(amplitude<10){
				vibrSpeed=7
			}else{
				vibrSpeed=7-(parseInt(amplitude/10));
			}
			if(vibrating){
				clearInterval(clr);
				clr=setInterval(function(){drawWave();},vibrSpeed);
			}
		}else{
			amplitude=amplitude-((distance+30)-bridgeDist);
			if(amplitude<10){
				vibrSpeed=7
			}else{
				vibrSpeed=(parseInt(amplitude/10));
			}
			if(vibrating){
				clearInterval(clr);
				clr=setInterval(function(){drawWave();},vibrSpeed);
			}
			
		}
		
	}else{
		/*if(vibrating){
			clearInterval(clr);
			clr=setInterval(function(){drawWave();},6);
		}*/
	}
	
}
function vibratePaper(){// -----------vibrating paper on sonometer------------
    $('#paperSmall').css({
        'top': paperTop+'px',
    });
	$('#paperSmall').css({
		'top': paperTop+'px',
	});
	if(paperTop<=161){
		paperLmt=false;
	}
	if(paperTop>=165){
		paperLmt=true;
	}
	if(paperLmt){
		paperTop--;
	}else{
		paperTop++;
	}
    
}
function scaleAmotion(val){
	valueA=parseFloat(val);console.log(valueA)
	//valueA=valueA.toFixed(1);console.log(valueA)
	if(valueA>(valueB-5) && preValA!=valueA){
		$("#slide_val4").prop('value',preValA);
	}
	$("#bridgeA_ctrl_val").html(val+' cm');
	scaleAlft=$('#scaleA').position().left;
	bridgeBlft=$('#bridgeB').position().left;
	paperLft=$('#paperSmall').position().left;
	$("#scaleA").css({'left':-39-(val*38)+'px'});
	$("#zoomBridgeA").css({'left':(val*2)+'px'});	
	if(valueA>valueB-5){
		$("#slide_val4").prop('disabled',true);
		$("#slide_val4").prop('disabled',false);
		$("#slide_val4").attr('value',valueB-5);
		$("#bridgeA_ctrl_val").html(valueB-5);
		$("#scaleA").css({'left':-39-((valueB-5)*38)+'px'});
		$("#zoomBridgeA").css({'left':((valueB-5)*2)+'px'});
	}else{
		$("#bridgeA").css({'left':96+(val*3.5)+'px'});
	}
	bridgeAlft=$('#bridgeA').position().left;
	if(bridgeAlft>paperLft-15 && !paperFall){
		$("#paperSmall").css({'left':(bridgeAlft+15)+'px'});
	}
	prevBriDist=bridgeDist;
	bridgeDist=valueB-valueA;
	setAmplitude();
	preValA=valueA;
}
function scaleBmotion(val){
	valueB=parseFloat(val);
/*valueB=valueB.toFixed(1);*/
	if(valueB<(valueA+5) && preValB!=valueB){
		$("#slide_val5").prop('value',preValB);
	}
	
	scaleAlft=$('#scaleB').position().left;
	bridgeAlft=$('#bridgeA').position().left;
	paperLft=$('#paperSmall').position().left;
	
	if(valueB<(valueA+5) && valueB!=100){console.log(valueB+"<:"+valueA+5);
		$("#slide_val5").prop('disabled',true);
		$("#slide_val5").prop('disabled',false);
		$("#slide_val5").attr('value',valueA+6);
		$("#bridgeB_ctrl_val").html(valueA+6);
		$("#scaleB").css({'left':-39-((valueA+6)*38)+'px'});
		$("#zoomBridgeB").css({'left':((valueA+6)*2)+'px'});
		$("#bridgeB").css({'left':467-((100-(valueA+6))*3.5)+'px'});
	}else{
		$("#bridgeB_ctrl_val").html(val+' cm');
		$("#scaleB").css({'left':-3839+((100-val).toPrecision(3)*38)+'px'});
		$("#zoomBridgeB").css({'left':(val*2)+'px'});
		$("#bridgeB").css({'left':467-((100-val)*3.5)+'px'});
	}
	bridgeBlft=$('#bridgeB').position().left;
	if(bridgeBlft<paperLft+15 && !paperFall){
		$("#paperSmall").css({'left':(bridgeBlft-15)+'px'});
	}
	prevBriDist=bridgeDist;
	bridgeDist=valueB-valueA;
	setAmplitude();
	preValB=valueB;
}
function waveGenerator(ID,lft,tp){
	$(ID).animate({'left':lft-1,'top':tp+1},function(){
		$(ID).animate({'left':lft,'top':tp});
	});
}
function startVibration(){
	clr=setInterval(function(){drawWave();},6);
	clrvibratePaper=setInterval(function(){vibratePaper();},10);
	vibrating=true;
	
}
function hitFork(){
	$("#forkWavesLft, #forkWavesRgt").show();
	clrWavelft=setInterval(function(){waveGenerator('#forkWavesLft',2,-22)},1000);
	clrWaveRgt=setInterval(function(){waveGenerator('#forkWavesRgt',-22,2)},1000);
	$("#tFork").animate({'top':'125px'});
}
function stopVibration(){
	clearInterval(clrWaveRgt);
	clearInterval(clrWavelft);
	$("#forkWavesLft, #forkWavesRgt").hide();
	$("#tFork").animate({'top':'55px'});
	$("#popup").hide();
	clearInterval(clr);
	clearInterval(clrvibratePaper);
	waveYtemp=waveY;
	waveY=74;
	ctx.clearRect(0,0,160,150);
	ctx.beginPath();
	ctx.moveTo(0, 74);
	ctx.strokeStyle=materialColor[material];
	ctx.bezierCurveTo(80, waveY, 80, waveY, 160, 74);
	ctx.stroke();
	if(!paperFall){
		ctx.beginPath();
		ctx.fillStyle="#FFFFFF";
		ctx.fillRect(74,72,14,14);
		ctx.stroke();
	}
}
function drawWave(){			
	ctx.clearRect(0,0,160,150);
	ctx.beginPath();
	ctx.moveTo(0, 74);
	ctx.bezierCurveTo(80, waveY, 80, waveY, 160, 74);
	ctx.stroke();
	ctx.beginPath();
	if((bridgeDist.toPrecision(3)!=distance.toFixed(1)) && !paperFall){
		ctx.fillStyle="#FFFFFF";
		ctx.fillRect(74,waveY-8,14,14);
		ctx.stroke();
	}else{
		paperFall=true;
		clearInterval(clrvibratePaper);
		$("#paperSmall").css({'top':'182px'});
		$("#replacePaper").attr("disabled",false);
		if(resonacLengths.length>1){
			for(i=0;i<resonacLengths.length;i++){
				if(distance==resonacLengths[i]){
					if($("#popup").css('display')=='none'){
						$("#popupMsg").html(popMSG[i]);
					}
					
				}
			}

		}else{
			$("#popupMsg").html(popMSG[0]);	
		}
		//$("#popupMsg").html(popMSG[0]);
		$("#popup").css({'left':$("#paperSmall").css('left')});
		$("#popup").show();
		//$( "popupMsg" ).detach();
	}
	if(waveY>80 || waveY<68){
		waveY==79;
	}
	if(waveY>=80){
		waveHeight=false;
	}
	if(waveY<=68){
		waveHeight=true;
	}
	if(waveHeight){
		waveY++;
	}else{
		waveY--;
	}	
/*	if(bridgeDist<(distance+30)){
		nearTo=true;
		if(waveHeight){
			waveY++;
		}else{
			waveY--;
		}
		if(waveY>=74+amplitude){
			waveHeight=false;
		}
		if(waveY<=74-amplitude){
			waveHeight=true;
		}
	}else{
		if(waveY>80 || waveY<68){
			waveY==79;
		}
		if(waveY>=80){
			waveHeight=false;
		}
		if(waveY<=68){
			waveHeight=true;
		}
		if(waveHeight){
			waveY++;
		}else{
			waveY--;
		}		
	}*/
}
function calculateDistance(){
	r=diameter/2;
	r=r/1000;
	m=3.14*r*r*density[material];
	T=M*g[envioIndx];
	distance=Math.sqrt(T/m)/(2*frqcy);
	distance=distance*100;
	tempDist=distance;
	resonacLengths=[];
	for(i=1;tempDist<100;i++){
		if(i*distance<100){
			resonacLengths.push(i*distance);
		}
		
		tempDist=i*distance;
	}
	distancePre=resonacLengths[0];
	distancePost=resonacLengths[resonacLengths.length-1];
	if(resonacLengths.length>1){
		for(i=0;i<resonacLengths.length-1;i++){
			if(bridgeDist>resonacLengths[i]){
				distancePre=resonacLengths[i];
				distancePost=resonacLengths[i+1];
			}
		}
		if(bridgeDist>=resonacLengths[resonacLengths.length-1]){
			distance=resonacLengths[resonacLengths.length-1];
		}
		if(bridgeDist<=resonacLengths[0]){
			distance=resonacLengths[0];
		}
	}
}
window.onload = function() { 
	gt = new Gettext({ 'domain' : 'messages' });
	document.getElementById("expName").innerHTML=gt.gettext("Sonometer");
	controlLabel=[gt.gettext("Reset"),gt.gettext("Hit tuning fork"),gt.gettext("Place paper rider"),gt.gettext("Stop vibration")];
	InsArray=[gt.gettext('Select the environment: '),gt.gettext("Add weighs(kg)"),gt.gettext("Select the wire material:"),gt.gettext("Diameter of the wire:"),gt.gettext('Frequency:'),gt.gettext('Weight hanger weight:'),0.5,5,0.1,600,300,gt.gettext('Position of bridge A:'),gt.gettext('Position of bridge B:')];	
	opt2=[gt.gettext("Copper"),gt.gettext("Steel"),gt.gettext("Nichrome"),gt.gettext("Constantan")];
	opt1=[gt.gettext("Earth (g=9.8 m/s&#178;)"),gt.gettext("Moon (g=1.6 m/s&#178;)"),gt.gettext("Uranus (g=8.69 m/s&#178;)"),gt.gettext("Saturn (g=10.14 m/s&#178;)"),gt.gettext("Jupiter (g=24.79 m/s&#178;)"),gt.gettext("Mars (g=3.7111 m/s&#178;)"),gt.gettext("Venus (g=8.83 m/s&#178;)"),gt.gettext("Mercury (g=3.7 m/s&#178;)"),gt.gettext("Neptune (g=11.15 m/s&#178;)")];
	popMSG=[gt.gettext("First resonance length"),gt.gettext("Second resonance length"),gt.gettext("Third resonance length"),gt.gettext("Fourth resonance length"),]
	color_arr=['#000000','#a8624a','#9d9d9d','#b6916d'];
	g=[9.8,1.6,8.69,10.44,24.79,3.711,8.83,3.7,11.15];
	density=[8940,7769,8400,8900];
	$(document).ready(function() {
		mainTop=$('#mainDiv').position().top;
		mainLeft=$('#mainDiv').position().left;	
		$('#mainDiv').mousedown(function(event){event.preventDefault();});	
		addLabel();			
		addintoDropDown( $('#Combo1'),opt1);
		addintoDropDown( $('#materialCombo'),opt2);
		c = document.getElementById("zoomCanvas");
		ctx = c.getContext("2d");
		function plotLine(){
			ctx.clearRect(0,0,160,150);
			ctx.beginPath();
			ctx.moveTo(0, 74);
			ctx.strokeStyle=materialColor[material];
			ctx.bezierCurveTo(80, waveY, 80, waveY, 160, 74);
			ctx.stroke();
			ctx.beginPath();
			ctx.fillStyle="#FFFFFF";
			ctx.fillRect(74,72,14,14);
			ctx.stroke();
		}
		plotLine();
		
		//combo_sliderchange();
		function addLabel(){//Function for adding label for all controls---	
			$('#reload').attr('value',controlLabel[0]);
			$('#hitTfork').attr('value',controlLabel[1]);
			$('#replacePaper').attr('value',controlLabel[2]);
			$('#Ins1').html(InsArray[0]);
			$('#Ins2').html(InsArray[2]);
			$('#Ins01').html(InsArray[5]);
			$('#rightminvals,#rightmaxvals2').html(InsArray[6]);
			$('#rightmaxvals').html(InsArray[7]);
			$("#rightVal").html(Q+' kg');
			$('#slidertxt').html(InsArray[4]);	
			$('#sliderspan').html(frqcy+' Hz');
			$('#slidertxt1').html(InsArray[3]);	
			$('#sliderspan1').html(Q1+' mm');
			$('#rightminvals2').html(InsArray[8]);
			$('#rightmaxvals1').html(InsArray[9]);
			$('#rightminvals1').html(InsArray[10]);
			$("#bridgeA_ctrl_lbl").html(InsArray[11]);
			$("#bridgeA_ctrl_val").html(minAB+' cm');
			$("#bridgeA_lbl_min").html(minAB);
			$("#bridgeA_lbl_max").html(maxAB);
			$("#bridgeB_ctrl_lbl").html(InsArray[12]);
			$("#bridgeB_ctrl_val").html(maxAB+' cm');
			$("#bridgeB_lbl_min").html(minAB);
			$("#bridgeB_lbl_max").html(maxAB);
		}
		function addintoDropDown(getId,valueSet){//Function for adding option in combo box---		
			var selected = getId;
			$.each(valueSet, function(val, text) {
			selected.append($('<option></option>').val(val).html(text));});			
		}
		$("#Combo1").change(function(){	//on change function of combo box. 
			envioIndx=$(this).find('option:selected').val();
			calculateDistance();
			Resetitems();
		});
		$("#materialCombo").change(function(){
			material=$(this).find('option:selected').val();
			$("#wire, #wireInWeight").css({'background-color':materialColor[material]});
			plotLine();
			calculateDistance();
			setAmplitude();
			Resetitems();
			
		});
		$(".rangeSlider").on('input', function() {//on change function of slider. 	
			//changeRightWeight(this.id,this.value);
		});
		$("#replacePaper").click(function(){
			paperFall=false;
			//bridgeDist=100;
			$("#popup").hide();
			clearInterval(clr);
			waveY=74;
			ctx.clearRect(0,0,160,150);
			ctx.beginPath();
			ctx.moveTo(0, 74);
			ctx.strokeStyle=materialColor[material];
			ctx.bezierCurveTo(80, waveY, 80, waveY, 160, 74);
			ctx.stroke();
			ctx.beginPath();
			ctx.fillStyle="#FFFFFF";
			ctx.fillRect(74,72,14,14);
			ctx.stroke();
			//$("#slide_val4").val(0);
			//$("#slide_val5").val(100);
			//valueA=0;valueB=100;
			vibrating=false;
			//$("#bridgeA_ctrl_val").html('0 cm');
			//$("#bridgeB_ctrl_val").html('100 cm');
			//$("#bridgeA").css({'left':'96px'});
			//$("#bridgeB").css({'left':'467px'});
			//$("#scaleA").css({'left':'-39px'});
			//$("#scaleB").css({'left':'-3839px'});
			//$("#zoomBridgeA").css({'left':'1px'});
			//$("#zoomBridgeB").css({'left':'200px'});
			$("#paperSmall").css({'top':'163px'});//,'left':'276px'
			$("#replacePaper").attr("disabled",true);
			setAmplitude();
		});
		$("#hitTfork").click(function(){
			bridgeDist=valueB-valueA;
			var text=$('#hitTfork').attr('value');
			if(text==controlLabel[1]){
				hited=true;
				calculateDistance();
				hitFork();
				bridgeDist=valueB-valueA;
				
				setAmplitude();
				$("#Combo1, #materialCombo").prop("disabled", true);
				$("#slide_val2,#slide_val1,#slide_val3").prop('disabled',true);
				$('#hitTfork').attr('value',controlLabel[3]);
			}else{
				hited=false;
				$("#slide_val2,#slide_val1,#slide_val3").prop('disabled',false);
				$('#hitTfork').attr('value',controlLabel[1]);
				stopVibration();
			}
			
			
		});
		function Resetitems(){//resetting slider value and appartus position
			Q=0.5,Q1=0.1,frqcy=300;
			$("#slide_val1").val(Q);
			$("#slide_val2").val(Q1);
			$("#slide_val3").val(frqcy);
			$('#sliderspan1').html(Q1+' mm');
			$("#rightVal").html(Q+' kg');
			$("#sliderspan").html(frqcy+' kg');
			$("#Hanging_right").css({height:12+'px'});
			vibrating=false
			$("#popup").hide();
		}
		$("#reload").click(function(){//*--Function to click reload button to reset all events---
			window.location.reload();	   
		});
	});	 			
};

