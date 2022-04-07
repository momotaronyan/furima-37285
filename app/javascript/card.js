const pay = () => {
  Payjp.setPublicKey("pk_test_f0da511cbb364bb4d3734d6a");
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("order_shipping[number]"),
      exp_month: formData.get("order_shipping[exp_month]"),
      exp_year: `20${formData.get("order_shipping[exp_year]")}`,
      cvc: formData.get("order_shipping[cvc]"),
    };
  });
};

window.addEventListener("load", pay);