function calculate (){
  const price = document.getElementById("item_price");
  price.addEventListener("keyup", () => {
    const FEE = 10;
    const tax_price = (price, fee) => Math.round(price * (fee / 100));
    let kakaku = item_price.value;
    let result = tax_price(kakaku, FEE);
    let profit_price = kakaku - result;

    document.getElementById("add-tax-price").innerText = result;
    document.getElementById("profit").innerText = profit_price;
    //console.log(result);
    //console.log(profit_price)
  });
};

window.addEventListener('load', calculate);