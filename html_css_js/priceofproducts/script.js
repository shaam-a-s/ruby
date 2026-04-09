// Calculate total price dynamically
document.querySelectorAll('.product').forEach(checkbox => {
    checkbox.addEventListener('change', updateTotal);
});

function updateTotal() {
    let total = 0;
    document.querySelectorAll('.product:checked').forEach(item => {
        total += parseFloat(item.value);
    });
    document.getElementById('totalPrice').textContent = total.toFixed(2);
}

// Validate credit card details
function validatePayment() {
    const cardNumber = document.getElementById('cardNumber').value.trim();
    const expiryDate = document.getElementById('expiryDate').value;
    const cvv = document.getElementById('cvv').value.trim();
    const errorMsg = document.getElementById('errorMsg');

    errorMsg.textContent = '';

    if (!/^\d{16}$/.test(cardNumber)) {
        errorMsg.textContent = 'Invalid card number. Must be 16 digits.';
        return false;
    }
    if (!expiryDate) {
        errorMsg.textContent = 'Please select expiry date.';
        return false;
    }
    if (!/^\d{3}$/.test(cvv)) {
        errorMsg.textContent = 'Invalid CVV. Must be 3 digits.';
        return false;
    }
    return true;
}

// Handle form submission via AJAX
document.getElementById('orderForm').addEventListener('submit', function(e) {
    e.preventDefault();

    if (!validatePayment()) return;

    const selectedProducts = [];
    document.querySelectorAll('.product:checked').forEach(item => {
        selectedProducts.push(item.nextSibling.textContent.trim());
    });

    const formData = {
        products: selectedProducts,
        total: document.getElementById('totalPrice').textContent,
        cardNumber: document.getElementById('cardNumber').value,
        expiryDate: document.getElementById('expiryDate').value,
        cvv: document.getElementById('cvv').value
    };

    // Simulated AJAX request
    fetch('https://httpbin.org/post', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
    })
    .then(res => res.json())
    .then(data => {
        alert('Payment submitted successfully!');
        console.log('Server Response:', data);
    })
    .catch(err => {
        alert('Error submitting payment.');
        console.error(err);
    });
});