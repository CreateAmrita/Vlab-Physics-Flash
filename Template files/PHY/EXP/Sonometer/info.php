<div class="post" align="left">&nbsp; <!--leave this space as such.. som wired issue-->
<?php include('breadcum.php'); 
include('book_reference.php'); 
include 'common_functions.php';
?>


  <blockquote><span class="title">A.C Sonometer</span>
    <p></p>
    
	<p style="margin-bottom: .0001pt">    <div class="postConentPadding">
	  <?php
		//@include('vlab/'.$sub.'/'.$brch.'/'.$sim.'/menu.php');
		@include('menu.php');
?>
	</p>
	
    <br/>
    <p class="contentTitle">Books</p><br />

    <table id="myTable" width="85%" border="0" class="content">
      <tr class="content">
        <td width="2%" valign="top">1.</td>
        <td width="98%"><? loadBookPreview('9788122417487'); ?></td>
      </tr>
      <tr class="content">
        <td valign="top">2.</td>
        <td><? loadBookPreview('9781406704464'); ?></td>
      </tr>
      <tr class="content">
        <td valign="top">3.</td>
        <td><?  loadBookPreview('0554902834'); ?></td>
      </tr>
     </table>
     </p>
    <!-- <body onUnload="checkEmbeddability();" ></body>-->
    <br/><br/>
    <?php
  $experiment_id=17;
   include('tagged_data_of_experiment.php'); 
    ?>
  </blockquote>
