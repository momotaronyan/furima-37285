function back (){
  const modoru = document.getElementById("back");
  modoru.addEventListener("click", () => {
    window.location.href = 'http://localhost:3000';
  });
};

//window.addEventListener('load', back);