window.addEventListener('load', () => {
 
 const priceInput = document.getElementById("item-price")
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    
    const addTaxDom = document.getElementById("add-tax-price");
    a = Math.floor(inputValue / 10)
    addTaxDom.innerHTML = a

    const profitDom = document.getElementById("profit");
    profitDom.innerHTML = Math.floor(inputValue - a)

  })


});