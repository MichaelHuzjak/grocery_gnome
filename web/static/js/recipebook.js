$(document).ready(function () {

	$("#bookEmpty").hide();
	$("#bookHeader").hide();
	$("#refreshButton").hide();
	$("#allHeader").show();
	
	
	//toggle bookmark

	$('.star').on('click', function () {
      $(this).toggleClass('star-checked');
      var classList = $(this).attr('class').split(/\s+/);


	//bookmark toggle

	if (classList.length == 2) {$(this).parent().parent().attr("data-status", "cancelado");}
	else {$(this).parent().parent().attr("data-status", "pagado");}
    
      
    });

    	//bookmark empty

	$("#bButton").on('click', function () {
	  $("#bookHeader").show();
	  $("#allHeader").hide();
	  $("#addButton").hide();
	  $("#refreshButton").show();
	  var $bookmarkCount = $('.table tr[data-status="' + "cancelado" + '"]').length;
	  if ($bookmarkCount == 0) {$("#bookEmpty").show();}

	});

	$("#aButton").on('click', function () {
		
	  $("#allHeader").show();
	  $("#bookEmpty").hide();
	  $("#bookHeader").hide();
	  $("#refreshButton").hide();
	  $("#addButton").show();
	  
	});


	//refresh button

    $("#refreshButton").on('click', function () {
      var $target = 'cancelado';
      if ($target != 'all') {
        $('.table tr').css('display', 'none');
        $('.table tr[data-status="' + $target + '"]').fadeIn('slow');
      } else {
        $('.table tr').css('display', 'none').fadeIn('slow');
      }
    });


	//create recipe


	$("#cButton").on('click', function () {


	        var table = document.getElementById("rTable");
    		var row = table.insertRow(table.rows.length);


    		var cell1 = row.insertCell(0);
   	 	var cell2 = row.insertCell(1);
    		var cell3 = row.insertCell(2);
    		var cell4 = row.insertCell(3);
    		var cell5 = row.insertCell(4);
    		var cell6 = row.insertCell(5);

		/*

		var nameValue = document.getElementById("name").value;
		var cText = document.forms[1].elements[0];
		var text_val = cText.value;

		*/

		cell1.innerHTML = '<a href="javascript:;" class="star"><i class="glyphicon glyphicon-star"></i></a>';
		cell2.innerHTML = document.forms[1].elements[0].value;
		cell3.innerHTML = document.forms[1].elements[1].value;
		cell4.innerHTML = document.forms[1].elements[2].value;
		cell5.innerHTML = '<input type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#editModal"onclick="passRowButton(this)" value="Edit/View"/>';
		cell6.innerHTML = '<input type="button" class="btn btn-danger btn-sm" value="Delete" onclick="deleteRow(this)"/>';

		document.forms[1].reset();
		 

	});

	
	//save edited recipe


	$("#sButton").on('click', function () {


	        var table = document.getElementById("rTable");
		var rowIndex = Number(document.forms[0].id);
		
    		
    		var rCell = table.rows[rowIndex].cells[1];
   	 	var iCell = table.rows[rowIndex].cells[2];
    		var pCell = table.rows[rowIndex].cells[3];

		rCell.innerHTML = document.forms[0].elements[0].value;

	/*
		var valString = document.forms[0].elements[1].value.split(" ");
		var lineString = "";
		for (i = 0; i < valString.length; i++) {lineString += valString[i] + "\n";}
	*/

		iCell.innerHTML = document.forms[0].elements[1].value;
		pCell.innerHTML = document.forms[0].elements[2].value;


		document.forms[0].reset();
		 

	});


	//update edit modal with current recipe data


	$(".btn-sm").on('click', function () {
		

		document.forms[0].reset();
		
	        var table = document.getElementById("rTable");
		var rowIndex = Number(document.forms[0].id);
		

		document.forms[0].elements[0].value = table.rows[rowIndex].cells[1].innerHTML;
		document.forms[0].elements[1].value = table.rows[rowIndex].cells[2].innerHTML;
		document.forms[0].elements[2].value = table.rows[rowIndex].cells[3].innerHTML;

		
	});

	


    $('.ckbox label').on('click', function () {
      $(this).parents('tr').toggleClass('selected');
    });

    $('.btn-filter').on('click', function () {
      var $target = $(this).data('target');
      if ($target != 'all') {
        $('.table tr').css('display', 'none');
        $('.table tr[data-status="' + $target + '"]').fadeIn('slow');
      } else {
        $('.table tr').css('display', 'none').fadeIn('slow');
      }
    });


	//search local recipes
	var $rows = $('#rTable tr');
$('#search').keyup(function() {
    var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();
    
    $rows.show().filter(function() {
        var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
        return !~text.indexOf(val);
    }).hide();
});

  

 });