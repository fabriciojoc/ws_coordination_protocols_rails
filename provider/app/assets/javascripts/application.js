// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require maskedinput
//= require maskmoney

$( document ).ready(function() {
  jQuery(function($){
    $('.edit_product').on('submit', function() {
       var price = document.getElementById("product_price");
       value = $('#product_price').maskMoney('unmasked')[0];
       $('#product_price').maskMoney('destroy');
       price.value = value
    });

    $('.new_product').on('submit', function() {
      var price = document.getElementById("product_price");
       value = $('#product_price').maskMoney('unmasked')[0];
       $('#product_price').maskMoney('destroy');
       price.value = value
    });

    $("#product_price").val(parseFloat($('#product_price').val()).toFixed(2));
    $('#product_price').maskMoney();
  });
});