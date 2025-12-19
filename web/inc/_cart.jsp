<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:set var="total" value="0"></c:set>

<section class="cart-page py-5">
    <div class="container">
        <div class="row g-4">

            <div class="col-lg-8">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <h4 class="mb-1">Giỏ hàng</h4>
                        <p class="mb-0 text-muted">Bạn có ${cart.size()} sản phẩm trong giỏ</p>
                    </div>
                    <div class="d-flex gap-3">
                        <a href="home" class="btn btn-outline-secondary btn-sm">
                            <i class="fas fa-arrow-left me-1"></i> Tiếp tục mua sắm
                        </a>
                        <a href="cart?clear=OK" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn chắc chắn muốn xóa toàn bộ giỏ hàng?');">
                            <i class="fas fa-trash-alt me-1"></i> Xóa giỏ hàng
                        </a>
                    </div>
                </div>

                <c:if test="${empty cart}">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body text-center py-5">
                            <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                            <h5 class="mb-2">Giỏ hàng của bạn đang trống</h5>
                            <p class="text-muted mb-3">Hãy thêm sản phẩm để bắt đầu mua sắm.</p>
                            <a href="home" class="btn btn-primary">
                                <i class="fas fa-arrow-left me-1"></i> Về trang sản phẩm
                            </a>
                                                </div>
                    </div>
                </c:if>

                <c:forEach items="${cart}" var="product">
                    <c:set var="total" value="${total + product.quantity*product.price}"></c:set>

                    <div class="card border-0 shadow-sm mb-3 cart-item">
                        <div class="card-body">
                            <div class="row align-items-center g-3">
                                <div class="col-3 col-md-2 text-center">
                                    <img src="./assets/images/${product.image}"
                                         alt="${product.name}"
                                         class="img-fluid rounded cart-item-img">
                                                </div>
                                <div class="col-9 col-md-4">
                                    <h6 class="mb-1">${product.name}</h6>
                                    <p class="mb-0 text-muted">Đơn giá: $${product.price}</p>
                                            </div>
                                            
                                <div class="col-12 col-md-6 mt-3 mt-md-0">
                                    <form action="cart" method="post" class="d-flex align-items-center justify-content-md-end gap-3">
                                        <input type="hidden" name="id_product" value="${product.id}">

                                        <div class="d-flex align-items-center">
                                            <label class="me-2 mb-0 small text-muted">Số lượng</label>
                                            <input type="number"
                                                   name="quantity"
                                                   min="1"
                                                   value="${product.quantity}"
                                                   class="form-control form-control-sm text-center"
                                                   style="width: 70px;">
                                            </div>

                                        <div class="text-end">
                                            <p class="mb-0 fw-semibold">
                                                Thành tiền: $${product.quantity * product.price}
                                            </p>
                                        </div>

                                        <div class="d-flex gap-2">
                                            <button type="submit" name="action" value="update"
                                                    class="btn btn-outline-primary btn-sm" title="Cập nhật số lượng">
                                                <i class="fas fa-sync-alt"></i>
                                            </button>
                                            <button type="submit" name="action" value="delete"
                                                    class="btn btn-outline-danger btn-sm" title="Xóa khỏi giỏ"
                                                    onclick="return confirm('Xóa sản phẩm này?');">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                    </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="col-lg-4">
                <div class="card border-0 shadow-sm cart-summary-card">
                    <div class="card-body">
                        <h5 class="mb-3">Tóm tắt đơn hàng</h5>

                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Tạm tính</span>
                            <span>$${total}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">VAT (10%)</span>
                            <span>$ <fmt:formatNumber type="number" maxFractionDigits="2" value="${total * 0.1}" /></span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="fw-semibold">Tổng cộng</span>
                            <span class="fw-bold text-primary" style="font-size: 1.2rem;">
                                $ <fmt:formatNumber type="number" maxFractionDigits="2" value="${total * 1.1}" />
                                                            </span>
                                                        </div>

                        <button type="button" class="btn btn-primary w-100 mb-2" data-bs-toggle="modal" data-bs-target="#checkoutModal">
                            <div class="d-flex justify-content-between align-items-center">
                                <span>Thanh toán</span>
                                <span class="fw-semibold">$${total * 1.1}</span>
                                                    </div>
                        </button>

                        <p class="text-muted small mb-0">
                            Bằng việc tiếp tục, bạn đồng ý với các điều khoản và chính sách mua hàng của chúng tôi.
                        </p>
                                                </div>
                                            </div>
                                        </div>

                            </div>
                        </div>
                    </section>

<!-- Modal Thanh toán -->
<div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="checkoutModalLabel">
                    <i class="fas fa-shopping-bag me-2"></i>Thông tin đặt hàng
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="checkoutForm" action="checkout" method="post">
                    
                    <!-- Thông tin khách hàng -->
                    <div class="mb-4">
                        <h6 class="mb-3"><i class="fas fa-user me-2 text-primary"></i>Thông tin giao hàng</h6>
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="customerName" class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="customerName" name="customerName" 
                                       placeholder="Nhập họ và tên" required>
                            </div>
                            <div class="col-md-6">
                                <label for="customerPhone" class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="customerPhone" name="customerPhone" 
                                       placeholder="Nhập số điện thoại" required>
                            </div>
                            <div class="col-md-12">
                                <label for="customerEmail" class="form-label">Email <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="customerEmail" name="customerEmail" 
                                       placeholder="Nhập địa chỉ email" required>
                            </div>
                            <div class="col-md-12">
                                <label for="deliveryAddress" class="form-label">Địa chỉ giao hàng <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="deliveryAddress" name="deliveryAddress" rows="2" 
                                          placeholder="Nhập địa chỉ chi tiết" required></textarea>
                            </div>
                            <div class="col-md-12">
                                <label for="deliveryNote" class="form-label">Ghi chú đơn hàng</label>
                                <textarea class="form-control" id="deliveryNote" name="deliveryNote" rows="2" 
                                          placeholder="Ghi chú thêm cho đơn hàng (không bắt buộc)"></textarea>
                            </div>
                        </div>
                    </div>

                    <hr>

                    <!-- Phương thức thanh toán -->
                    <div class="mb-4">
                        <h6 class="mb-3"><i class="fas fa-credit-card me-2 text-primary"></i>Phương thức thanh toán</h6>
                        
                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="payment-method-card">
                                    <input type="radio" class="btn-check" name="paymentMethod" id="paymentCOD" value="COD" checked>
                                    <label class="btn btn-outline-primary w-100 payment-label" for="paymentCOD">
                                        <i class="fas fa-money-bill-wave fa-2x mb-2"></i>
                                        <div class="fw-semibold">Thanh toán khi nhận hàng</div>
                                        <small class="text-muted">(COD)</small>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="payment-method-card">
                                    <input type="radio" class="btn-check" name="paymentMethod" id="paymentBank" value="BANK_TRANSFER">
                                    <label class="btn btn-outline-primary w-100 payment-label" for="paymentBank">
                                        <i class="fas fa-university fa-2x mb-2"></i>
                                        <div class="fw-semibold">Chuyển khoản</div>
                                        <small class="text-muted">Ngân hàng</small>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="payment-method-card">
                                    <input type="radio" class="btn-check" name="paymentMethod" id="paymentCard" value="CREDIT_CARD">
                                    <label class="btn btn-outline-primary w-100 payment-label" for="paymentCard">
                                        <i class="fas fa-credit-card fa-2x mb-2"></i>
                                        <div class="fw-semibold">Thẻ tín dụng</div>
                                        <small class="text-muted">Visa/Mastercard</small>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Thông tin chuyển khoản (hiện khi chọn) -->
                        <div id="bankInfo" class="mt-3 p-3 bg-light rounded" style="display: none;">
                            <p class="mb-2"><strong>Thông tin chuyển khoản:</strong></p>
                            <p class="mb-1">Số tài khoản: <strong>1234567890</strong></p>
                            <p class="mb-1">Ngân hàng: <strong>Vietcombank</strong></p>
                            <p class="mb-0">Chủ tài khoản: <strong>Camera Store</strong></p>
                            <p class="mb-0 text-muted small">Nội dung chuyển khoản: Mã đơn hàng + Số điện thoại</p>
                        </div>
                    </div>

                    <hr>

                    <!-- Tóm tắt đơn hàng trong modal -->
                    <div class="mb-3">
                        <h6 class="mb-3"><i class="fas fa-receipt me-2 text-primary"></i>Tóm tắt đơn hàng</h6>
                        <div class="bg-light p-3 rounded">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Tạm tính:</span>
                                <span>$${total}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>VAT (10%):</span>
                                <span>$${total * 0.1}</span>
                            </div>
                            <hr class="my-2">
                            <div class="d-flex justify-content-between">
                                <span class="fw-bold">Tổng cộng:</span>
                                <span class="fw-bold text-primary fs-5">$${total * 1.1}</span>
                            </div>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Hủy
                </button>
                <button type="submit" form="checkoutForm" class="btn btn-primary">
                    <i class="fas fa-check me-1"></i>Xác nhận đặt hàng
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    // Hiện/ẩn thông tin chuyển khoản khi chọn phương thức thanh toán
    document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
        radio.addEventListener('change', function() {
            const bankInfo = document.getElementById('bankInfo');
            if (this.value === 'BANK_TRANSFER') {
                bankInfo.style.display = 'block';
            } else {
                bankInfo.style.display = 'none';
            }
        });
    });

    // Validate form trước khi submit
    document.getElementById('checkoutForm').addEventListener('submit', function(e) {
        const name = document.getElementById('customerName').value.trim();
        const phone = document.getElementById('customerPhone').value.trim();
        const email = document.getElementById('customerEmail').value.trim();
        const address = document.getElementById('deliveryAddress').value.trim();

        if (!name || !phone || !email || !address) {
            e.preventDefault();
            alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
            return false;
        }

        // Validate email
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            e.preventDefault();
            alert('Email không hợp lệ!');
            return false;
        }

        // Validate phone (ít nhất 10 số)
        const phoneRegex = /^[0-9]{10,11}$/;
        if (!phoneRegex.test(phone.replace(/\s+/g, ''))) {
            e.preventDefault();
            alert('Số điện thoại không hợp lệ!');
            return false;
        }
    });
</script>

<style>
    .payment-method-card {
        height: 100%;
    }
    
    .payment-label {
        height: 100%;
        padding: 1.25rem 0.75rem;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        border: 2px solid #dee2e6;
        transition: all 0.2s;
    }
    
    .payment-label:hover {
        border-color: #0d6efd;
        background-color: #f8f9fa;
    }
    
    input[type="radio"]:checked + .payment-label {
        border-color: #0d6efd;
        background-color: #e7f1ff;
        color: #0d6efd;
    }
</style>