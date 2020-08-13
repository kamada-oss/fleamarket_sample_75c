$(function(){
  $("#item_price").on('input',function(){
    let price = $(this).val();
    let minPrice = 300
    let maxPrice = 9999999
    let fee = 10
    let tax = Math.floor(price / fee)
    let taxProfit = tax.toLocaleString()
    let profit = price - tax
    let kanmaProfit = profit.toLocaleString()
    if(price >= minPrice && price <= maxPrice){
      $("#tax-text").text("¥" + taxProfit);
      $("#profit-text").text("¥" + kanmaProfit);
    } else {
      $("#tax-text").text("-");
      $("#profit-text").text("-");
    }
  })
})
