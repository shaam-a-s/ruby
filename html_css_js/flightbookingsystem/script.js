document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("bookingForm");
  const resultDiv = document.getElementById("result");
  const totalPriceSpan = document.getElementById("totalPrice");
  const destinationCheckboxes = document.querySelectorAll("input[name='destination']");
  const classRadios = document.querySelectorAll("input[name='class']");
  const seatSection = document.getElementById("seatSection");

  // Update price dynamically
  destinationCheckboxes.forEach(cb => cb.addEventListener("change", updatePrice));
  classRadios.forEach(radio => radio.addEventListener("change", () => {
    updatePrice();
    toggleSeatSection(radio.value);
  }));

  function updatePrice() {
    let basePrice = 0;
    destinationCheckboxes.forEach(cb => {
      if (cb.checked) basePrice += parseInt(cb.dataset.price, 10);
    });

    const selectedClass = document.querySelector("input[name='class']:checked");
    let multiplier = selectedClass ? parseFloat(selectedClass.dataset.multiplier) : 1;

    totalPriceSpan.textContent = basePrice * multiplier;
  }

  function toggleSeatSection(selectedClass) {
    if (selectedClass === "Business" || selectedClass === "First") {
      seatSection.style.display = "block";
    } else {
      seatSection.style.display = "none";
    }
  }

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    resultDiv.innerHTML = "";

    const name = document.getElementById("passengerName").value.trim();
    if (!name || name.length < 2) {
      showError("Passenger name must be at least 2 characters.");
      return;
    }

    const selectedDestinations = Array.from(destinationCheckboxes).filter(cb => cb.checked);
    if (selectedDestinations.length === 0) {
      showError("Please select at least one destination.");
      return;
    }

    const travelClass = document.querySelector("input[name='class']:checked");
    if (!travelClass) {
      showError("Please select a travel class.");
      return;
    }

    if ((travelClass.value === "Business" || travelClass.value === "First")) {
      const seatPref = document.getElementById("seatPref").value;
      if (!seatPref) {
        showError("Please select a seat preference.");
        return;
      }
    }

    const totalPrice = parseInt(totalPriceSpan.textContent, 10);

    // Simulate AJAX
    simulateAjax({ name, travelClass: travelClass.value, totalPrice })
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
        if (Math.random() > 0.3) {
          resolve({ message: "Booking successful!" });
        } else {
          reject({ message: "Booking failed. Please try again." });
        }
      }, 1000);
    });
  }
});