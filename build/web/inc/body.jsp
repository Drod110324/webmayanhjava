<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main class="container">
    <section class="featured-products">
        <!-- Hiển thị thông báo tìm kiếm nếu có -->
        <c:if test="${not empty keyword}">
            <div class="alert alert-info d-flex align-items-center mb-4" role="alert">
                <i class="fas fa-search me-2"></i>
                <div>
                    <strong>${searchMessage}</strong>
                    <c:if test="${not empty listProduct && listProduct.size() > 0}">
                        <span class="text-muted">(${listProduct.size()} sản phẩm)</span>
                    </c:if>
                </div>
            </div>
        </c:if>
        
        <c:if test="${empty keyword}">
            <h2>Sản Phẩm Nổi Bật</h2>
        </c:if>

        <c:choose>
            <c:when test="${id_category != null}">
                <section>
                    <div class="container my-5">
                        <header class="mb-4">
                            <h3>Sản phẩm thuộc: ${selectedCategory.name}</h3>
                        </header>
                        <div class="row">
                            <c:forEach items="${listProduct}" var="p">
                                <div class="col-lg-2 col-md-4 col-sm-6 d-flex">
                                    <div class="card product-card w-100 my-3">
                                        <a href="product-profile?id=${p.id}" class="text-decoration-none text-dark">
                                            <img src="assets/images/${p.image}" class="card-img-top product-card-img" style="aspect-ratio: 1/1"/>
                                        </a>
                                        <div class="card-body product-card-body">
                                            <h5 class="product-card-title">
                                                <a href="product-profile?id=${p.id}" class="text-decoration-none text-dark">${p.name}</a>
                                            </h5>
                                            <p class="product-card-price mb-2">$${p.price}</p>
                                            
                                            <div class="mb-2">
                                               
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${p.status && p.quantity > 0}">
                                                            <span class="badge bg-success" style="font-size: 0.75rem;"><i class="fas fa-check-circle me-1"></i>Còn hàng</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-danger" style="font-size: 0.75rem;"><i class="fas fa-times-circle me-1"></i>Hết hàng</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                                            <div class="card-footer product-card-footer d-flex justify-content-center align-items-end pt-3 px-0 pb-0 mt-auto bg-white border-0">
                                                <c:choose>
                                                    <c:when test="${!p.status || p.quantity <= 0}">
                                                        <button class="btn btn-secondary shadow-0 w-100" disabled>Hết hàng</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${user==null}">
                                                                <a href="<c:url value='/login'/>" class="btn btn-primary shadow-0 w-100">Thêm vào giỏ hàng</a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="cart?action=add&id=${p.id}" class="btn btn-primary shadow-0 w-100">Thêm vào giỏ hàng</a>
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
                    </div>
                </section>
            </c:when>
            
            <c:otherwise>
                <!-- Nếu có keyword thì hiển thị tất cả kết quả tìm kiếm, không phân theo category -->
                <c:if test="${not empty keyword}">
                    <section>
                        <div class="container my-5">
                            <div class="row">
                                <c:forEach items="${listProduct}" var="p">
                                        <div class="col-lg-2 col-md-4 col-sm-6 d-flex">
                                            <div class="card product-card w-100 my-3">
                                                <a href="product-profile?id=${p.id}" class="text-decoration-none text-dark">
                                                    <img src="assets/images/${p.image}" class="card-img-top product-card-img" style="aspect-ratio: 1/1"/>
                                                </a>
                                                <div class="card-body product-card-body">
                                                    <h5 class="product-card-title">
                                                        <a href="product-profile?id=${p.id}" class="text-decoration-none text-dark">${p.name}</a>
                                                    </h5>
                                                    <p class="product-card-price mb-2">$${p.price}</p>
                                                    
                                                    <div class="mb-2">
                                                        
                                                        <div>
                                                            <c:choose>
                                                                <c:when test="${p.status && p.quantity > 0}">
                                                                    <span class="badge bg-success" style="font-size: 0.75rem;"><i class="fas fa-check-circle me-1"></i>Còn hàng</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-danger" style="font-size: 0.75rem;"><i class="fas fa-times-circle me-1"></i>Hết hàng</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>

                                                    <div class="card-footer product-card-footer d-flex justify-content-center align-items-end pt-3 px-0 pb-0 mt-auto bg-white border-0">
                                                        <c:choose>
                                                            <c:when test="${!p.status || p.quantity <= 0}">
                                                                <button class="btn btn-secondary shadow-0 w-100" disabled>Hết hàng</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:choose>
                                                                    <c:when test="${user==null}">
                                                                        <a href="<c:url value='/login'/>" class="btn btn-primary shadow-0 w-100">Thêm vào giỏ hàng</a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a href="cart?action=add&id=${p.id}" class="btn btn-primary shadow-0 w-100">Thêm vào giỏ hàng</a>
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
                            <c:if test="${empty listProduct}">
                                <div class="text-center py-5">
                                    <i class="fas fa-search fa-3x text-muted mb-3"></i>
                                    <h5 class="mb-2">Không tìm thấy sản phẩm nào</h5>
                                    <p class="text-muted mb-3">Không có sản phẩm nào khớp với từ khóa "<strong>${keyword}</strong>"</p>
                                    <a href="home" class="btn btn-primary">
                                        <i class="fas fa-arrow-left me-1"></i> Về trang chủ
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </section>
                </c:if>
                
                <!-- Nếu không có keyword thì hiển thị theo category như bình thường -->
                <c:if test="${empty keyword}">
                    <c:forEach items="${listCategory}" var="c">
                        <section>
                            <div class="container my-5">
                                <header class="mb-4"><h3>${c.name}</h3></header>
                                <div class="row">
                                    <c:forEach items="${listProduct}" var="p">
                                        <c:if test="${c.id == p.id_category}">
                                            <div class="col-lg-2 col-md-4 col-sm-6 d-flex">
                                                <div class="card product-card w-100 my-3">
                                                    <a href="product-profile?id=${p.id}" class="text-decoration-none text-dark">
                                                        <img src="assets/images/${p.image}" class="card-img-top product-card-img" style="aspect-ratio: 1/1"/>
                                                    </a>
                                                    <div class="card-body product-card-body">
                                                        <h5 class="product-card-title">
                                                            <a href="product-profile?id=${p.id}" class="text-decoration-none text-dark">${p.name}</a>
                                                        </h5>
                                                        <p class="product-card-price mb-2">$${p.price}</p>
                                                        
                                                        <div class="mb-2">
                                                            <div>
                                                                <c:choose>
                                                                    <c:when test="${p.status && p.quantity > 0}">
                                                                        <span class="badge bg-success" style="font-size: 0.75rem;"><i class="fas fa-check-circle me-1"></i>Còn hàng</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-danger" style="font-size: 0.75rem;"><i class="fas fa-times-circle me-1"></i>Hết hàng</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>

                                                        <div class="card-footer product-card-footer d-flex justify-content-center align-items-end pt-3 px-0 pb-0 mt-auto bg-white border-0">
                                                            <c:choose>
                                                                <c:when test="${!p.status || p.quantity <= 0}">
                                                                    <button class="btn btn-secondary shadow-0 w-100" disabled>Hết hàng</button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:choose>
                                                                        <c:when test="${user==null}">
                                                                            <a href="<c:url value='/login'/>" class="btn btn-primary shadow-0 w-100">Thêm vào giỏ hàng</a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a href="cart?action=add&id=${p.id}" class="btn btn-primary shadow-0 w-100">Thêm vào giỏ hàng</a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </section>
                    </c:forEach>
                </c:if>
            </c:otherwise>
        </c:choose>
    </section>
</main>