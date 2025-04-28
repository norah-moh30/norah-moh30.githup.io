// scripts/script.js

// جلب السلة من localStorage أو تهيئتها
let cart = JSON.parse(localStorage.getItem('cart')) || [];

// إضافة عنصر للسلة
function addToCart(product) {
cart.push(product);
localStorage.setItem('cart', JSON.stringify(cart));
updateCartCount();
alert(`تم إضافة "${product.name}" إلى السلة.`);
}

// تحديث عداد السلة في الواجهة
function updateCartCount() {
const count = cart.length;
const badge = document.getElementById('cartCount');
if (badge) badge.textContent = count;
}

// رسم محتوى السلة في cart.html
function renderCart() {
const container = document.getElementById('cartContainer');
container.innerHTML = '';
if (cart.length === 0) {
container.innerHTML = '<p>السلة فارغة.</p>';
return;
}

let total = 0;
cart.forEach((item, index) => {
total += item.price;
const div = document.createElement('div');
div.classList.add('cart-item');
div.innerHTML = `
<img src="${item.image}" alt="${item.name}">
<div class="cart-item-info">
<h4>${item.name}</h4>
<p>المقاس: ${item.size}</p>
<p>السعر: ${item.price} ريال</p>
</div>
<button class="remove-btn" onclick="removeFromCart(${index})">حذف</button>
`;
container.appendChild(div);
});

const totalDiv = document.createElement('div');
totalDiv.classList.add('cart-total');
totalDiv.textContent = `الإجمالي: ${total} ريال`;
container.appendChild(totalDiv);
}

// حذف عنصر من السلة
function removeFromCart(index) {
cart.splice(index, 1);
localStorage.setItem('cart', JSON.stringify(cart));
renderCart();
updateCartCount();
}

// عند تحميل أي صفحة
document.addEventListener('DOMContentLoaded', () => {
updateCartCount();
if (document.getElementById('cartContainer')) {
renderCart();
}
});
