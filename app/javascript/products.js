const checkStatus = () => {
  let status = 0;
  for (const productType of ["food", "drink", "souvenir"]) {
    if (d3.select(`#product-filter-${productType}`).property("checked")) {
      status += 1;
    }
  }
  return status;
};

const showProducts = (productType, checked) => {
  const products = d3.selectAll(`.product-${productType}`);
  products.style("display", checked ? "inline" : "none");
};

const checkAll = (checked) => {
  for (const productCategory of ["food", "drink", "souvenir"]) {
    d3.select(`#product-filter-${productCategory}`).property(
      "checked",
      checked
    );
    d3.select(`.product-filter-${productCategory}`).style(
      "opacity",
      checked ? "100%" : "80%"
    );
  }
};

for (const productType of ["food", "drink", "souvenir", "all"]) {
  let status = 0;
  const productFilterCheck = d3.select(`#product-filter-${productType}`);
  productFilterCheck.on("change", () => {
    const productFilterButton = d3.select(`.product-filter-${productType}`);
    if (productFilterCheck.property("checked")) {
      productFilterButton.style("outline-style", "solid");
      status = checkStatus();
      if (status === 1) {
        for (const otherProductType of ["food", "drink", "souvenir", "all"]) {
          if (otherProductType !== productType) {
            showProducts(otherProductType, false);
          }
        }
      }
      showProducts(productType, true);
      if (productType === "all") {
        checkAll(true);
      }
    } else {
      productFilterButton.style("outline-style", "none");
      status = checkStatus();
      if (status === 0) {
        for (const otherProductType of ["food", "drink", "souvenir"]) {
          showProducts(otherProductType, true);
        }
      } else {
        showProducts(productType, false);
      }
      if (productType === "all") {
        checkAll(false);
      }
    }
  });
}
