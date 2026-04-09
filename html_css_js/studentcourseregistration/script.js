document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("registrationForm");
  const resultDiv = document.getElementById("result");
  const semesterRadios = document.querySelectorAll("input[name='semester']");
  const timingSection = document.getElementById("timingSection");

  // Show timing field only if Fall is selected
  semesterRadios.forEach(radio => {
    radio.addEventListener("change", () => {
      if (radio.value === "Fall") {
        timingSection.style.display = "block";
      } else {
        timingSection.style.display = "none";
      }
    });
  });

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    resultDiv.innerHTML = "";

    const name = document.getElementById("studentName").value.trim();
    if (!name) {
      showError("Name is required.");
      return;
    }

    const selectedCourses = Array.from(document.querySelectorAll("input[name='course']:checked"));
    if (selectedCourses.length === 0) {
      showError("Please select at least one course.");
      return;
    }

    const semester = document.querySelector("input[name='semester']:checked");
    if (!semester) {
      showError("Please select a semester.");
      return;
    }

    if (semester.value === "Fall") {
      const timing = document.getElementById("timing").value;
      if (!timing) {
        showError("Please select a preferred timing for Fall.");
        return;
      }
    }

    // Calculate credits
    let totalCredits = 0;
    selectedCourses.forEach(course => {
      totalCredits += parseInt(course.dataset.credits, 10);
    });

    // Simulate AJAX
    simulateAjax({ name, semester: semester.value, totalCredits })
      .then(response => {
        showSuccess(`${response.message} | Total Credits: ${totalCredits}`);
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
          resolve({ message: "Registration successful!" });
        } else {
          reject({ message: "Registration failed. Try again." });
        }
      }, 1000);
    });
  }
});