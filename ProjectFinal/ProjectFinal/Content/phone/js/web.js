
$(document).ready(function () {
    var text = [];
    var id = $('#id').val();
	$(".dropdown").hover(            
		function() {
			$('.dropdown-menu', this).stop( true, true ).slideDown("fast");
			$(this).toggleClass('open');        
		},
		function() {
			$('.dropdown-menu', this).stop( true, true ).slideUp("fast");
			$(this).toggleClass('open');       
		}
	);

	$('#horizontalTab').easyResponsiveTabs({
		type: 'default', //Types: default, vertical, accordion           
		width: 'auto', //auto or any width like 600px
		fit: true   // 100% fit in a container
	});

	$('.checkAll').click(function () {
	    text = [];
	    var c = this.checked;
	    if (c == true) {
	        text.push('all');
	        $('.checkElement').prop('checked', false);
	    }
	});

	$('.checkElement').click(function () {
	    text = [];
	    $(".checkElement").each(function () {
	        if ($(this).prop('checked') == true) {
	            text.push($(this).val());
	            $('.checkAll').prop('checked', false);
	            // return false;
	        }
	        // text+=this.val()+",";
	    })
	    alert(text.join());
	});

	$('.cb').change(function () {
	    $.ajax({
	        url: '',
	        method: 'GET',
	        contentType: 'application/json',
	        dataType: 'json',
	        processData: false
	    }).done(function (result) {
	        console.log(result);
	    }).fail(function (err) {
	        console.error(err);
	    });
	});

	function getListProduct() {
	    $.ajax({
	        url: '/Product/GetProduct/' + id,
	        method: 'GET',
	        contentType: 'application/json',
	        dataType: 'json',
	        processData: false
	    }).done(function (result) {
	        console.log(result);
	    }).fail(function (err) {
	        console.error(err);
	    });
	}

	//getListProduct();
});
$(window).load(function() {
	$("#flexiselDemo1").flexisel({
		visibleItems: 4,
		animationSpeed: 1000,
		autoPlay: false,
		autoPlaySpeed: 3000,    		
		pauseOnHover: true,
		enableResponsiveBreakpoints: true,
		responsiveBreakpoints: { 
			portrait: { 
				changePoint:480,
				visibleItems: 1
			}, 
			landscape: { 
				changePoint:640,
				visibleItems:2
			},
			tablet: { 
				changePoint:768,
				visibleItems: 3
			}
		}
	});
	
});
var app=angular.module('myApp', []);
app.controller('MobileController', function ($scope, $http) {
    $scope.initProduct = function (id) {
        console.log(id);
        $scope.searchProvider($scope.providername);
        $http.get("/Product/GetProduct/"+id ).then(function (response) {
            $scope.Product = response.data;
        });
    }
    $scope.searchProvider = function (name) {
        if (name == null || name.length == 0) {
            $http.get("/get-list-provider").then(function (response) {
                $scope.data = response.data;
            });
        }
        else {
            $http.get("/get-list-provider-by-name?name=" + name).then(function (response) {
                $scope.data = response.data;
            });
        }
    }
    });