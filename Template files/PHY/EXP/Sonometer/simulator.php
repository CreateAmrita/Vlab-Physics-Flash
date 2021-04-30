<!--<script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>-->
<div class="post" align="left">&nbsp; <!--leave this space as such.. som wired issue-->
<?php include('breadcum.php'); ?>


  <blockquote><span class="title">A.C Sonometer</span>
  <p>    <div class="postConentPadding">
	   <?php
	  	$defTemp="vlab";
		//@include('vlab/'.$sub.'/'.$brch.'/'.$sim.'/menu.php');
		@include('menu.php');
		if($_GET['temp']!="")
		{
			$temp=$_GET['temp'];
		}else
		{
			$temp=$defTemp;
		}
		$lan=$_GET['lan']; 
		if($lan==""){
			$lan="en-US";
		}

?>
</p>
<p align="center">
  
  
  <p align="center">
  <iframe src="<?php  echo 'vlab/'.$sub.'/'.$brch.'/'.$sim.'/'.'Sonometer.php?lan='.$lan.'&temp='.$temp; ?>" frameborder="0" height="600" width="810" scrolling="no"></iframe></p>
 <!--<p class="content">This   simulation   is also available in <a href="?sub=PHY&amp;brch=ACS&amp;sim=Sonometer&amp;cnt=simulator&amp;temp=vlab">vlab</a>, <a href="?sub=PHY&amp;brch=ACS&amp;sim=Sonometer&amp;cnt=simulator&amp;temp=Olab">olab</a> </p>-->
</div>
