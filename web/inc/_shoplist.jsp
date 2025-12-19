<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main class="container py-5">
    <div class="row">
        <div class="col-lg-3 mb-4">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-list me-2"></i>Danh mục sản phẩm</h5>
                </div>
                <div class="card-body p-0">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item ${id_category == null ? 'active' : ''}">
                            <a href="shoplist" class="text-decoration-none d-flex align-items-center">
                                <i class="fas fa-th-large me-2"></i><span>Tất cả sản phẩm</span>
                            </a>
                        </li>
                        <c:forEach items="${listCategory}" var="category">
                            <li class="list-group-item ${id_category == category.id ? 'active' : ''}">
                                <a href="shoplist?id_category=${category.id}" class="text-decoration-none d-flex align-items-center">
                                    <i class="fas fa-tag me-2"></i><span>${category.name}</span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="mb-1">
                        <c:choose>
                            <c:when test="${id_category != null && selectedCategory != null}">${selectedCategory.name}</c:when>
                            <c:otherwise>Tất cả sản phẩm</c:otherwise>
                        </c:choose>
                    </h3>
                    <p class="text-muted mb-0">
                        <c:choose>
                            <c:when test="${listProduct != null && listProduct.size() > 0}">Tìm thấy ${listProduct.size()} sản phẩm</c:when>
                            <c:otherwise>Không có sản phẩm nào</c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <div>
                    <select class="form-select form-select-sm" id="sortSelect">
                        <option value="default">Sắp xếp mặc định</option>
                        <option value="price-asc">Giá: Thấp đến cao</option>
                        <option value="price-desc">Giá: Cao đến thấp</option>
                        <option value="name-asc">Tên: A-Z</option>
                        <option value="name-desc">Tên: Z-A</option>
                    </select>
                </div>
            </div>

            <c:choose>
                <c:when test="${listProduct != null && listProduct.size() > 0}">
                    <div class="row g-4" id="productGrid">
                        <c:forEach items="${listProduct}" var="p">
                            <div class="col-lg-4 col-md-6 d-flex product-item" data-price="${p.price}" data-name="${p.name}">
                                <div class="card product-card w-100">
                                    <a href="product-profile?id=${p.id}">
                                        <img src="assets/images/${p.image}" class="card-img-top product-card-img" style="aspect-ratio: 1/1" alt="${p.name}">
                                    </a>
                                    <div class="card-body product-card-body">
                                        <h5 class="product-card-title"><a href="product-profile?id=${p.id}" class="text-decoration-none text-dark">${p.name}</a></h5>
                                        <p class="product-card-price mb-2">$${p.price}</p>
                                        
                                        <div class="mb-2">
                                            
                                            <div>
                                                <c:choose>
                                                    <c:when test="${p.status && p.quantity > 0}">
                                                        <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i>Còn hàng</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger"><i class="fas fa-times-circle me-1"></i>Hết hàng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <div class="card-footer product-card-footer d-flex justify-content-center align-items-end pt-3 px-0 pb-0 mt-auto bg-white border-0">
                                            <c:choose>
                                                <%-- Trường hợp 1: Hết hàng hoặc Ngừng bán --%>
                                                <c:when test="${!p.status || p.quantity <= 0}">
                                                     <button class="btn btn-secondary shadow-0 w-100" disabled>Hết hàng</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:choose>
                                                        <c:when test="${user==null}">
                                                            <a href="<c:url value='/login'/>" class="btn btn-primary shadow-0 w-100"><i class="fas fa-cart-plus me-1"></i>Thêm vào giỏ hàng</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="cart?action=add&id=${p.id}" class="btn btn-primary shadow-0 w-100"><i class="fas fa-cart-plus me-1"></i>Thêm vào giỏ hàng</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card border-0 shadow-sm">
                        <div class="card-body text-center py-5">
                            <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                            <h5 class="mb-2">Không tìm thấy sản phẩm</h5>
                            <p class="text-muted mb-3">Danh mục này hiện chưa có sản phẩm nào.</p>
                            <a href="shoplist" class="btn btn-primary"><i class="fas fa-arrow-left me-1"></i>Xem tất cả sản phẩm</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>
<script>
    document.getElementById('sortSelect').addEventListener('change', function() {
        const sortValue = this.value;
        const productGrid = document.getElementById('productGrid');
        const products = Array.from(productGrid.querySelectorAll('.product-item'));
        products.sort((a, b) => {
            if (sortValue === 'price-asc') return parseFloat(a.dataset.price) - parseFloat(b.dataset.price);
            else if (sortValue === 'price-desc') return parseFloat(b.dataset.price) - parseFloat(a.dataset.price);
            else if (sortValue === 'name-asc') return a.dataset.name.localeCompare(b.dataset.name);
            else if (sortValue === 'name-desc') return b.dataset.name.localeCompare(a.dataset.name);
            return 0;
        });
        products.forEach(product => product.remove());
        products.forEach(product => productGrid.appendChild(product));
    });
</script>
<style>
    .list-group-item.active { background-color: #0d6efd; color: white; border-color: #0d6efd; }
    .list-group-item.active a { color: white; }
    .list-group-item:not(.active) a { color: #333; }
    .list-group-item:not(.active) a:hover { color: #0d6efd; }
</style>