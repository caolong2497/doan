
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
	$("#btnsub").click(function () {
	    var i = $("#total").val();
	    if (i > 1) {
	        $("#total").val(i-1);
	    }
	})
	$("#btnadd").click(function () {
	    var i = $("#total").val();
	    if (i > 1) {
	        $("#total").val(i + 1);
	    }
	})
	$('#horizontalTab').easyResponsiveTabs({
		type: 'default', //Types: default, vertical, accordion           
		width: 'auto', //auto or any width like 600px
		fit: true   // 100% fit in a container
	});
	$("#searchInput").focus(function () {
	    $('.SearchResult').css("display", "block");
	});
	$("#searchInput").focusout(function () {
	    $('.SearchResult').css("display", "none");
	});

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
    
    $scope.orderinfo = {}
    $scope.proid = [];
    $scope.price = [];
    $scope.PSearch = {};
    $scope.initProduct = function (id) {
        console.log(id);
        $scope.searchProvider($scope.providername);
        $http.get("/Product/GetProduct/"+id ).then(function (response) {
            $scope.Product = response.data;
        });
    }
    $scope.changeQuantity = function (id, flag) {
        var proid = "#total" + id;
        var value = $(proid).val();
        console.log(value + ":" + flag);
        if (value==5 && flag == 2) {
            alert("chỉ có thể mua tối đa 5 chiếc mỗi loại");
            return;
        } else if(value==1&&flag==1) {
            return;
        }else{
        $http({
            url: "/Product/UppdateQuantity/",
            method: "GET",
            params: { id: id, flag: flag }
        }).then(function (response) {
            location.reload();
        });
        }
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
    $scope.createOrder = function () {
        var data = $scope.orderinfo;
        data.Total=$("#totalMoney").val();
        console.log(data);
        $http.post("/Order/CreateOrderInfor", data).then(function (response) {
            location.href = "/Order/CheckOutOrder/"

        }, function (response) {
            alert("Add Thất Bại");
        });
    }

    $('.checkAllPrice').click(function () {
        $scope.price = [];
        var c = this.checked;
        if (c == true) {
            $scope.price.push('all');
            $('.checkElement').prop('checked', false);
        }
        $scope.SearchProduct();
    });

    $('.checkElement').click(function () {
        $scope.price = [];
        $(".checkElement").each(function () {
            if ($(this).prop('checked') == true) {
                $scope.price.push($(this).val());
                $('.checkAllPrice').prop('checked', false);
            }

        })
        $scope.SearchProduct();
    });

    $('.checkAllProvider').click(function () {
        $scope.proid = [];
        var c = this.checked;
        if (c == true) {
            $scope.proid.push('all');
            $('.providerBox').prop('checked', false);
        }
        $scope.SearchProduct();
    });
    $scope.selectProvider = function () {
        $scope.proid = [];
        $(".providerBox").each(function () {
            if ($(this).prop('checked') == true) {
                $scope.proid.push($(this).val());
                $('.checkAllProvider').prop('checked', false);

            }
        })
        $scope.SearchProduct();
    };
    $scope.SearchProduct = function () {
        if ($scope.proid.length == 0) {
            $scope.proid.push('all');
        }
        if ($scope.price.length == 0) {
            $scope.price.push('all');
        }
        //console.log($scope.proid + ":" + $scope.price);
        $http({
            url: "/Product/SearchProduct/",
            method: "GET",
            params: { Listprovider: $scope.proid.join(), ListPrice: $scope.price.join() }
        }).then(function(response){
            $scope.Product = response.data;
        });
        //$http.get("/get-list-provider-by-name?name=" + name).then(function (response) {
        //    $scope.data = response.data;
        //});
    }
    $scope.searchProductName = function () {
        if ($scope.ProductName == "") {
            $scope.PSearch = {};
            //$('.SearchResult').css("display", "none");
        }else{
            $http({
                url: "/Product/GetProductByName/",
                method: "GET",
                params: { name: $scope.ProductName }
            }).then(function (response) {
                $scope.PSearch = response.data;
            });
            
        }
       
    }

    //$scope.getSession = function () {
    //        $http({
    //            url: "/Product/getCart/",
    //            method: "GET"
    //        }).then(function (response) {
    //            $scope.cartProduct = response.data;
    //            $scope.count = $scope.cartProduct.length;
    //        });
    //}
    //$scope.getSession();
    $scope.addCart = function (Productid) {
            $http({
                url: "/Product/addCart/",
                method: "GET",
                params: { id: Productid }
            }).then(function (response) {
                alert("thêm giỏ hàng thành công");
            });
    }

    $scope.deleteCart = function (Productid) {
        $http({
            url: "/Product/deleteCart/",
            method: "GET",
            params: { id: Productid }
        }).then(function (response) {
            alert("Xóa giỏ hàng thành công");
            location.reload();
        });
    }
    });