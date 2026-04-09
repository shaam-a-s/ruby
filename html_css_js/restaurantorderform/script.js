document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("orderForm");
  const resultDiv = document.getElementById("result");
  const totalPriceSpan = document.getElementById("totalPrice");
  const itemCheckboxes = document.querySelectorAll("input[name='item']");
  const orderTypeRadios = document.querySelectorAll("input[name='orderType']");
  const addressSection = document.getElementById("addressSection");

  // Live update total price
  itemCheckboxes.forEach(checkbox => {
    checkbox.addEventListener("change", updateTotal);
  });

  function updateTotal() {
    let total = 0;
    itemCheckboxes.forEach(cb => {
      if (cb.checked) {
        total += parseInt(cb.dataset.price, 10);
      }
    });
    totalPriceSpan.textContent = total;
  }

  // Show address if delivery is chosen
  orderTypeRadios.forEach(radio => {
    radio.addEventListener("change", () => {
      if (radio.value === "Delivery") {
        addressSection.style.display = "block";
      } else {
        addressSection.style.display = "none";
      }
    });
  });

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    resultDiv.innerHTML = "";

    const name = document.getElementById("customerName").value.trim();
    if (!name) {
      showError("Customer name is required.");
      return;
    }

    const selectedItems = Array.from(itemCheckboxes).filter(cb => cb.checked);
    if (selectedItems.length === 0) {
      showError("Please select at least one menu item.");
      return;
    }

    const orderType = document.querySelector("input[name='orderType']:checked");
    if (!orderType) {
      showError("Please select order type.");
      return;
    }

    if (orderType.value === "Delivery") {
      const address = document.getElementById("address").value.trim();
      if (!address) {
        showError("Delivery address is required.");
        return;
      }
    }

    const totalPrice = parseInt(totalPriceSpan.textContent, 10);

    // Simulate AJAX
    simulateAjax({ name, orderType: orderType.value, totalPrice })
      .then(response => {
        showSuccess(`${response.message} | Total Price: ₹${totalPrice}`);
      })
      .catch(error => {
        showError(error.message);
      });
  });

  function showError(msg) {
    resultDiv.innerHTML = `<span class="error">${msg}</span>`;
  }

  function showSuccess(msg) {
    resultDiv.innerHTML = `<span class="success">${msg}</span>`;
  }

  function simulateAjax(data) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        // Random success/failure simulation
        if (Math.random() > 0.3) {
          resolve({ message: "Order placed successfully!" });
        } else {
          reject({ message: "Order failed. Please try again." });
        }
      }, 1000);
    });
  }
});