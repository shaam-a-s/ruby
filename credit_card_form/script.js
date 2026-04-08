document.addEventListener('DOMContentLoaded', () => {
    // === 1. DOM generated Expiry Dropdowns ===
    const expMonth = document.getElementById('expMonth');
    const expYear = document.getElementById('expYear');

    // Populate Months (01 to 12)
    for (let i = 1; i <= 12; i++) {
        let option = document.createElement('option');
        let val = i < 10 ? '0' + i : String(i);
        option.value = val;
        option.textContent = val;
        expMonth.appendChild(option);
    }

    // Populate Years (Current Year to +15)
    const currentYear = new Date().getFullYear();
    for (let i = 0; i < 15; i++) {
        let option = document.createElement('option');
        option.value = currentYear + i;
        option.textContent = currentYear + i;
        expYear.appendChild(option);
    }

    // === 2. Elements to validate ===
    const cardName = document.getElementById('cardName');
    const cardNumber = document.getElementById('cardNumber');
    const cvv = document.getElementById('cvv');
    const submitBtn = document.getElementById('submitBtn');

    // Error elements
    const nameError = document.getElementById('nameError');
    const ccError = document.getElementById('ccError');
    const cvvError = document.getElementById('cvvError');
    const dateError = document.getElementById('dateError');

    // Helper functions for UI
    function setSuccess(inputElement, errorElement) {
        inputElement.classList.remove('input-error');
        inputElement.classList.add('input-success');
        if (errorElement) errorElement.style.display = 'none';
        return true;
    }

    function setError(inputElement, errorElement) {
        inputElement.classList.remove('input-success');
        inputElement.classList.add('input-error');
        if (errorElement) errorElement.style.display = 'block';
        return false;
    }

    function resetStyles(inputElement, errorElement) {
        inputElement.classList.remove('input-success', 'input-error');
        if (errorElement) errorElement.style.display = 'none';
    }

    // === 3. Validation Logic ===

    // 3.1 Validate Name (Alphabetic letters and spaces only)
    function validateName() {
        const val = cardName.value.trim();
        const regex = /^[A-Za-z\s]+$/;
        if (val.length === 0) return false;

        if (regex.test(val)) {
            return setSuccess(cardName, nameError);
        } else {
            return setError(cardName, nameError);
        }
    }

    // 3.2 Validate Credit Card (Start with 4 or 5, Length exactly 16)
    function validateCC() {
        // Strip out non numeric spaces if any (though regex here requires straight digits)
        const val = cardNumber.value.trim().replace(/\s+/g, '');
        // Starts with 4 or 5 and total length is 16
        const regex = /^[45]\d{15}$/;
        if (val.length === 0) return false;

        if (regex.test(val)) {
            return setSuccess(cardNumber, ccError);
        } else {
            return setError(cardNumber, ccError);
        }
    }

    // 3.3 Validate CVV (Numeric digits, Length 3 or 4)
    function validateCVV() {
        const val = cvv.value.trim();
        const regex = /^\d{3,4}$/;
        if (val.length === 0) return false;

        if (regex.test(val)) {
            return setSuccess(cvv, cvvError);
        } else {
            return setError(cvv, cvvError);
        }
    }

    // 3.4 Validate Date
    function validateExpiry() {
        if (!expMonth.value || !expYear.value) return false;

        const selectedMonth = parseInt(expMonth.value, 10);
        const selectedYear = parseInt(expYear.value, 10);

        const currentDate = new Date();
        const curMonth = currentDate.getMonth() + 1; // 0-indexed
        const curYear = currentDate.getFullYear();

        // If the expiration year is greater than current year, it's valid
        // If it's the current year, month must be greater than or equal to current month
        let isValid = false;
        if (selectedYear > curYear) {
            isValid = true;
        } else if (selectedYear === curYear && selectedMonth >= curMonth) {
            isValid = true;
        }

        if (isValid) {
            expMonth.classList.remove('input-error');
            expYear.classList.remove('input-error');
            expMonth.classList.add('input-success');
            expYear.classList.add('input-success');
            dateError.style.display = 'none';
            return true;
        } else {
            expMonth.classList.remove('input-success');
            expYear.classList.remove('input-success');
            expMonth.classList.add('input-error');
            expYear.classList.add('input-error');
            dateError.style.display = 'block';
            return false;
        }
    }

    // === 4. User-friendly Interaction (Events & Cursor Hopping) ===

    // Name Listener
    cardName.addEventListener('blur', () => {
        if (cardName.value.length > 0) {
            if (validateName()) cardNumber.focus();
        } else {
            resetStyles(cardName, nameError);
        }
    });

    cardName.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            e.preventDefault();
            if (validateName()) cardNumber.focus();
        }
    });

    // Credit Card Listener (Jump to next instantly when 16 valid digits are typed)
    cardNumber.addEventListener('input', () => {
        // Strip spaces 
        let rawVal = cardNumber.value.replace(/\s+/g, '');
        if (rawVal.length === 16) {
            if (validateCC()) cvv.focus();
        } else if (rawVal.length > 0) {
            // Remove styles while typing
            resetStyles(cardNumber, ccError);
        }
    });

    cardNumber.addEventListener('blur', () => {
        if (cardNumber.value.length > 0) {
            validateCC();
        } else {
            resetStyles(cardNumber, ccError);
        }
    });

    // CVV Listener (Wait for blur since length could be 3 or 4)
    cvv.addEventListener('blur', () => {
        if (cvv.value.length > 0) {
            if (validateCVV()) expMonth.focus();
        } else {
            resetStyles(cvv, cvvError);
        }
    });

    cvv.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            e.preventDefault();
            if (validateCVV()) expMonth.focus();
        }
    });

    // Dropdown Listeners
    expMonth.addEventListener('change', () => {
        if (expYear.value) validateExpiry();
        if (expMonth.value && !expYear.value) expYear.focus();
    });

    expYear.addEventListener('change', () => {
        if (expMonth.value) {
            if (validateExpiry()) submitBtn.focus();
        } else {
            expMonth.focus();
        }
    });

    // Form Submission check
    document.getElementById('paymentForm').addEventListener('submit', (e) => {
        let isNameValid = validateName();
        let isCCValid = validateCC();
        let isCVVValid = validateCVV();
        let isDateValid = validateExpiry();

        let successMessage = document.getElementById('successMessage');

        if (isNameValid && isCCValid && isCVVValid && isDateValid) {
            successMessage.style.display = 'block';
            successMessage.textContent = "Payment successful! Details are fully valid.";
        } else {
            successMessage.style.display = 'none';
        }
    });
});
