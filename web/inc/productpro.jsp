<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.name} - Chi tiết sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .product-image {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .price-tag {
            font-size: 1.5rem;
            color: #d9534f;
            font-weight: bold;
        }
        .related-product-img {
            height: 150px;
            object-fit: cover;
        }
    </style>
</head>
<body>
<div class="container mt-5">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="home">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="shoplist">Sản phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
            </ol>
        </nav>

        <div class="row">
            <div class="col-md-6 mb-4">
                <img src="assets/images/${product.image}" alt="${product.name}" class="product-image img-fluid">
            </div>

            <div class="col-md-6">
                <h1 class="mb-3">${product.name}</h1>
                
                <div class="mb-3">
                    <span class="price-tag">
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$"/>
                    </span>
                </div>

                <div class="mb-3">
                    <c:choose>
                        <c:when test="${product.status}">
                            <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i>Còn hàng</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-danger"><i class="fas fa-times-circle me-1"></i>Hết hàng</span>
                        </c:otherwise>
                    </c:choose>
                    <span class="text-muted ms-2">Số lượng kho: ${product.quantity}</span>
                </div>

                <p class="lead mb-4">
                    Đây là mô tả chi tiết cho sản phẩm <strong>${product.name}</strong>. 
                    Sản phẩm chất lượng cao, chính hãng và được bảo hành đầy đủ.
                </p>

                <form action="cart" method="post" class="d-flex align-items-center mb-4">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="id" value="${product.id}">
                    
                    <div class="input-group me-3" style="width: 130px;">
                        <span class="input-group-text">SL</span>
                        <input type="number" class="form-control" name="quantity" value="1" min="1" max="${product.quantity}">
                    </div>
                    
                    <c:choose>
                        <c:when test="${product.status && product.quantity > 0}">
                             <button type="submit" class="btn btn-primary btn-lg flex-grow-1">
                                <i class="fas fa-cart-plus me-2"></i>Thêm vào giỏ
                            </button>
                        </c:when>
                        <c:otherwise>
                             <button type="button" class="btn btn-secondary btn-lg flex-grow-1" disabled>
                                <i class="fas fa-ban me-2"></i>Tạm hết hàng
                            </button>
                        </c:otherwise>
                    </c:choose>
                </form>

                <hr>

                <div class="mt-4">
                    <h5>Thông tin thêm:</h5>
                    <ul class="list-unstyled">
                        <li><i class="fas fa-shield-alt text-primary me-2"></i>Bảo hành chính hãng 12 tháng</li>
                        <li><i class="fas fa-truck text-primary me-2"></i>Giao hàng toàn quốc</li>
                        <li><i class="fas fa-undo text-primary me-2"></i>Đổi trả trong 7 ngày</li>
                    </ul>
                </div>
            </div>
        </div>
        
        <c:if test="${not empty relatedProducts}">
            <div class="row mt-5">
                <div class="col-12">
                    <h3 class="mb-4">Sản phẩm cùng danh mục</h3>
                </div>
                <c:forEach items="${relatedProducts}" var="p">
                    <div class="col-md-3 col-sm-6 mb-4">
                        <div class="card h-100">
                            <a href="product-profile?id=${p.id}">
                                <img src="assets/images/${p.image}" class="card-img-top related-product-img" alt="${p.name}">
                            </a>
                            <div class="card-body">
                                <h6 class="card-title">
                                    <a href="product-profile?id=${p.id}" class="text-decoration-none text-dark">${p.name}</a>
                                </h6>
                                <p class="card-text text-danger fw-bold">$${p.price}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>
