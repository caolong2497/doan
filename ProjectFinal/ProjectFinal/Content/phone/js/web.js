
$(document).ready(function () {
    var text = [];
    var id = $('#id').val();

    $(".dropdown").hover(
		function () {
		    $('.dropdown-menu', this).stop(true, true).slideDown("fast");
		    $(this).toggleClass('open');
		},
		function () {
		    $('.dropdown-menu', this).stop(true, true).slideUp("fast");
		    $(this).toggleClass('open');
		}
	);
    $("#btnsub").click(function () {
        var i = $("#total").val();
        if (i > 1) {
            $("#total").val(i - 1);
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
    var flag = false;
    $("#searchInput").focus(function () {
        $('.SearchResult').css("display", "block");
    });
    $('.SearchResult').mouseenter(function () {
        flag = true;
    });
    $('.SearchResult').mouseleave(function () {
        flag = false;
    });
    $("#searchInput").focusout(function (e) {
        if (flag == false) {
            $('.SearchResult').css("display", "none");
        }
        
    });

});
$(window).load(function () {
    $("#flexiselDemo1").flexisel({
        visibleItems: 4,
        animationSpeed: 1000,
        autoPlay: false,
        autoPlaySpeed: 3000,
        pauseOnHover: true,
        enableResponsiveBreakpoints: true,
        responsiveBreakpoints: {
            portrait: {
                changePoint: 480,
                visibleItems: 1
            },
            landscape: {
                changePoint: 640,
                visibleItems: 2
            },
            tablet: {
                changePoint: 768,
                visibleItems: 3
            }
        }
    });

});
var app = angular.module('myApp', []);
app.controller('MobileController', function ($scope, $http) {
    $scope.email = "";
    $scope.password = "";
    $scope.error = "";
    $scope.orderinfo = {};
    $scope.proid = [];
    $scope.price = [];
    $scope.PSearch = {};
    $scope.fullname = "";
    $scope.email = "";
    $scope.phone = "";
    $scope.address = "";
    $scope.passWord = "";
    $scope.passWordConfirm = "";
    $scope.Customer = {};
    $scope.oldPassword="";
    $scope.newPassword="";
    $scope.newPasswordConfirm = "";
    $scope.error_forgetEmail = "";
    $scope.initProduct = function (id) {
        $scope.searchProvider($scope.providername);
        $http.get("/Product/GetProduct/" + id).then(function (response) {
            $scope.Product = response.data;
        });
    }
    $scope.searchProductbyName = function (name) {

        if (name == null) {
            alert("Bạn chưa nhập từ khóa tìm kiếm");
        } else {
            $http({
                url: "/Product/getListProductByName/",
                method: "GET",
                params: { name: $scope.ProductName }
            }).then(function (response) {
                location.href = "/Product/GetListProduct/?id=0";
            });

        }
    }
    $scope.changeQuantity = function (id, flag) {
        var proid = "#total" + id;
        var value = $(proid).val();
        console.log(value + ":" + flag);
        if (value == 5 && flag == 2) {
            alert("chỉ có thể mua tối đa 5 chiếc mỗi loại");
            return;
        } else if (value == 1 && flag == 1) {
            return;
        } else {
            $http({
                url: "/Product/UppdateQuantity/",
                method: "GET",
                params: { id: id, flag: flag }
            }).then(function (response) {
                $scope.getProductInSession();
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
        data.Total = $("#totalMoney").val();
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
        $http({
            url: "/Product/SearchProduct/",
            method: "GET",
            params: { Listprovider: $scope.proid.join(), ListPrice: $scope.price.join() }
        }).then(function (response) {
            $scope.Product = response.data;
        });
    }
    $scope.searchProductName = function () {
        if ($scope.ProductName == "") {
            $scope.PSearch = {};
        } else {
            $http({
                url: "/Product/GetProductByName/",
                method: "GET",
                params: { name: $scope.ProductName }
            }).then(function (response) {
                $scope.PSearch = response.data;
            });

        }

    }
    $scope.addCart = function (Productid) {
        $http({
            url: "/Product/addCart/",
            method: "GET",
            params: { id: Productid }
        }).then(function (response) {
            alert("Thêm  Vào giỏ Hàng Thành Công");
            $scope.getCountProduct();

        });
    };
    $scope.getCountProduct = function () {
        $http({
            url: "/Product/countProductinCart/",
            method: "GET",
        }).then(function (response) {
            $scope.count = response.data;
            if ($scope.count == 0) {
                $(".countProduct").text("");
                $(".countProduct").css("background", "rgba(255, 255, 255, 0.075)");
            } else {
                $(".countProduct").text($scope.count);
                $(".countProduct").css("background", "#497290");
            }
        });
    }
    $scope.getProductInSession = function () {
        $http({
            url: "/Product/getProductInSession/",
            method: "GET",
        }).then(function (response) {
            $scope.productS = response.data;
            if ($scope.productS != "0") {
                $http({
                    url: "/Product/getTotal/",
                    method: "GET",
                }).then(function (response) {
                    $scope.total = response.data;
                });
            }
            $scope.getCountProduct();

        });
    }
    $scope.loginform = function () {
        var regex = "/[a-b]/";
        if ($scope.email == "") {
            $scope.error = "Email Không Được Để Trống";
        } else if ($scope.password == "") {
            $scope.error = "Mật khẩu Không Được Để Trống";
        } else if (!/[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+.+.[A-Za-z]{2,4}/.test($scope.email)) {
            $scope.error = "Email Không Đúng Định Dạng";
            console.log("false");
        } else {
            $http({
                url: "/Customer/Login/",
                method: "Post",
                params: { email: $scope.email, password: $scope.password }
            }).then(function (response) {
                result = response.data;
                console.log(result);
                if (result == 1) {
                    location.href = "/Home/index";
                    $scope.error = "";
                } else {
                    $scope.error = "Email hoặc Mật Khẩu không đúng";
                }
            }, function (response) {
                alert("Có lỗi xảy ra");
            });
        }
    }
    $scope.deleteCart = function (Productid) {
        $http({
            url: "/Product/deleteCart/",
            method: "GET",
            params: { id: Productid }
        }).then(function (response) {
            alert("Xóa giỏ hàng thành công");
            $scope.getProductInSession();
        });
    }
    $scope.registerCustomer = function () {
        var check = 1;
        var data = $scope.Customer;
        console.log(data.FullName);
        if (data.FullName == "" || data.FullName == null) {
            $scope.error_fullname = "FullName không được để trống";
            check=0;
        } else {
            $scope.error_fullname = "";
        }
        if (data.Phone == "" || data.Phone == null) {
            $scope.error_phone = "Số Điện Thoại  không được để trống";
            check = 0;
        } else if (!/(\+84|0)\d{9,10}/.test(data.Phone)) {
            check = 0;
            $scope.error_phone = "Số điện thoại không đúng định dạng";
        } else {
            $scope.error_phone = "";
        }
        if (data.Address == "" || data.Address == null) {
            $scope.error_address = "Địa chỉ không được để trống";
            check = 0;
        } else {
            $scope.error_address = "";
        }
        if (data.PassWord == "" || data.PassWord == null) {
            check = 0;
            $scope.error_password = "Mật Khẩu không được để trống";
        } else if (6 > data.PassWord.length || data.PassWord.length > 20) {
            $scope.error_password = "Mật khẩu có độ dài từ 6-20 kí tự";
            check = 0;
        } else {
            $scope.error_password = "";
        }
        if (data.PassWordConfirm == "" || data.PassWordConfirm == null) {
            $scope.error_passWordConfirm = "Mật khẩu xác nhận không được để trống";
            check = 0;
        } else if (data.PassWordConfirm != data.PassWord) {
            $scope.error_passWordConfirm = "Mật khẩu xác nhận sai";
            check = 0;
        } else {
            $scope.error_passWordConfirm = "";
        }

        if (data.Email == "" || data.Email == null) {
            $scope.error_email = "Email không được để trống";
            check=0;
        } else if (!/[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+.+.[A-Za-z]{2,4}/.test(data.Email)) {
            $scope.error_email = "Địa chỉ Email không đúng định dạng";
            check=0;
        } else {
            $http({
                url: "/Customer/checkEmail/",
                method: "GET",
                params: { email: data.Email }
            }).then(function (response) {
                result = response.data;
                if (result == 1) {
                    $scope.error_email = "";
                    if (check == 1) {
                        $http.post("/Customer/CreateCustomer/", data).then(function (response) {
                            result = response.data;
                            if (result) {
                                alert("Đăng Ký Thành Công");
                                location.href = "/Home/index";
                            } else {
                                alert("Đăng Ký thất bại");
                            }
                        }, function (response) {
                            alert("Đăng Ký Thất Bại Thất Bại");
                        });
                    }
                } else {
                    $scope.error_email = "Địa chỉ email đã tồn tại .Hãy chọn địa chỉ khác";
                    check = 0;
                }
            });
        }
        
        console.log(check+"ngoai");

    }
    $scope.getCustomer = function (email) {
        $http({
            url: "/Customer/getCustomer/",
            method: "GET",
            params: { email: email }
        }).then(function (response) {
            $scope.Customer = response.data;
        });
    }
    $scope.updateCustomer = function () {
        alert("hello");
        var data = $scope.Customer;
        var check = 1;
        if (data.FullName == "" || data.FullName == null) {
            $scope.error_fullname = "FullName không được để trống";
            check = 0;
        } else {
            $scope.error_fullname = "";
        }
        if (data.Phone == "" || data.Phone == null) {
            $scope.error_phone = "Số Điện Thoại  không được để trống";
            check = 0;
        } else if (!/(\+84|0)\d{9,10}/.test(data.Phone)) {
            check = 0;
            $scope.error_phone = "Số điện thoại không đúng định dạng";
        } else {
            $scope.error_phone = "";
        }
        if (data.Address == "" || data.Address == null) {
            $scope.error_address = "Địa chỉ không được để trống";
            check = 0;
        } else {
            $scope.error_address = "";
        }
        if (check == 1) {
            $http.post("/Customer/editCustomer/", data).then(function (response) {
                result = response.data;
                if (result) {
                    alert("Update Thành Công");
                    location.href = "/Customer/getCustomerInfor?email="+data.Email;
                } else {
                    alert("Update thất bại");
                }
            }, function (response) {
                alert("Update Thất Bại");
            });
        }
    }
    $scope.changePassword = function () {
        if ($scope.oldPassword == "" || $scope.newPassword == "" || $scope.newPasswordConfirm=="") {
            $scope.error_Pass = "Các Trường Không Được Để Trống";
        } else if(6 > $scope.newPassword.length || $scope.newPassword.length > 20){
            $scope.error_Pass = "Mật khẩu  phải trong khoản từ 6 đến 20 kí tự";
        }else if($scope.newPassword != $scope.newPasswordConfirm ) {
            $scope.error_Pass = "Mật Khẩu Mới Và Mật Khẩu Xác Nhận Không Trùng Khớp";
        }else{
            $http({
                url: "/Customer/checkPass/",
                method: "GET",
                params: { oldPassword: $scope.oldPassword }
            }).then(function (response) {
                result = response.data;
                if (result == 0) {
                    $scope.error_Pass = "Mật Khẩu không đúng";
                } else {
                    $scope.error_Pass = "";
                    $http({
                        url: "/Customer/changePass/",
                        method: "GET",
                        params: { newPassword: $scope.newPassword }
                    }).then(function (response) {
                        kq = response.data;
                        if (kq == 1) {
                            alert("Đổi Mật Khẩu thành công");
                            location.href = "/Home/index";
                        } else {
                            alert("Đổi Mật Khẩu Thất Bại");
                        }
                    });
                }
            });
        }

    }
    $scope.forgetPassword = function () {
        if($scope.email==""){
            $scope.error_forgetEmail="Hãy Điền Email Của Bạn";
        } else if (!/[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+.+.[A-Za-z]{2,4}/.test($scope.email)) {
            $scope.error_forgetEmail = "Địa chỉ Email không đúng định dạng";
            check=0;
        }else{
            $http({
                url: "/Customer/checkEmail/",
                method: "GET",
                params: { email: $scope.email }
            }).then(function (response) {
                result=response.data;
                if(result==1){
                    $scope.error_forgetEmail = "Địa chỉ Email không đúng";
                }else{
                    $http({
                        url: "/Customer/resetPassWord/",
                        method: "GET",
                        params: { email: $scope.email }
                    }).then(function (response) {
                        result = response.data;
                        if (result == 1) {
                            $scope.error_forgetEmail = "";
                            alert("Reset Mật Khẩu Thành công,Hãy Check Lại Hòm Thư Của Bạn");
                            location.href = "/Customer/Login";
                        } else {
                            $scope.error_forgetEmail = "Đang có lỗi,hãy thử lại sau";
                        }
                    })
                }
            })
         }
    }
    $scope.getCountProduct();
});