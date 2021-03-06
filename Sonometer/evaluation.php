<script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
<script src="Scripts/swfobject_modified.js" type="text/javascript"></script>

<div class="post" align="left">&nbsp; <!--leave this space as such.. som wired issue-->
  <?php include('breadcum.php'); ?>
  
  
  <blockquote> 
    <span class="title">A.C Sonometer</span>
    <p></p>
    
    <p>    <div class="postConentPadding">
    <?php
		//@include('vlab/'.$sub.'/'.$brch.'/'.$sim.'/menu.php');
		@include('menu.php');
?>
    </p>
    
    
    
    <p align="center">
      <object id="FlashID" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="800" height="600">
        <param name="movie" value="vlab/Question/assignment.swf" />
        <param name="quality" value="high" />
        <param name="wmode" value="opaque" />
        <param name="swfversion" value="6.0.65.0" />
        <!-- This param tag prompts users with Flash Player 6.0 r65 and higher to download the latest version of Flash Player. Delete it if you don’t want users to see the prompt. -->
        <param name="expressinstall" value="Scripts/expressInstall.swf" />
        <param name="flashVars" value="file=vlab/Data/ACSonometer.xml" />
        <!-- Next object tag is for non-IE browsers. So hide it from IE using IECC. -->
        <!--[if !IE]>-->
        <object type="application/x-shockwave-flash" data="vlab/Question/assignment.swf" width="800" height="600">
          <!--<![endif]-->
          <param name="quality" value="high" />
          <param name="wmode" value="opaque" />
          <param name="swfversion" value="6.0.65.0" />
          <param name="expressinstall" value="Scripts/expressInstall.swf" />
          <param name="flashVars" value="file=vlab/Data/ACSonometer.xml" />
          <!-- The browser displays the following alternative content for users with Flash Player 6.0 and older. -->
          <div>
            <h4>Content on this page requires a newer version of Adobe Flash Player.</h4>
            <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" width="112" height="33" /></a></p>
          </div>
          <!--[if !IE]>-->
        </object>
        <!--<![endif]-->
      </object>
      <br />
    </p>
  </blockquote>
&nbsp; <!--leave this space as such.. som wired issue--></div>
<script type="text/javascript">
<!--
swfobject.registerObject("FlashID");
//-->
</script>
