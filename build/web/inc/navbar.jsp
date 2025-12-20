<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand" href="home">
            <img src="assets/images/logo1.png" alt="Logo" class="logo-img">
        </a>  
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-3 mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active fw-bold" href="home">Trang chủ</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle fw-bold text-dark" href="#" id="categoryDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">Danh mục</a>
                    <ul class="dropdown-menu dropdown-menu-custom border-0" aria-labelledby="categoryDropdown" style="min-width: 220px;">
                        <li><a href="shoplist" class="dropdown-item dropdown-item-custom ${id_category == null ? 'active' : ''}"><i class="fas fa-layer-group"></i> Tất cả</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <c:forEach items="${listCategory}" var="category">
                            <li><a class="dropdown-item dropdown-item-custom" href="shoplist?id_category=${category.id}"><i class="fas fa-tag"></i> ${category.name}</a></li>
                        </c:forEach>
                    </ul>
                </li>
            </ul>

            <form action="search" method="get" class="d-flex flex-grow-1 mx-lg-4 my-2 my-lg-0">
                <div class="input-group">
                    <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm sản phẩm..." aria-label="Search">
                    <button class="btn btn-primary btn-search-custom d-flex align-items-center" type="submit"><i class="fas fa-search me-2"></i><span class="fw-semibold">Tìm kiếm</span></button>
                </div>
            </form>

            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item me-3">
                    <a class="nav-link position-relative" href="cart">
                        <i class="fas fa-shopping-cart fa-lg text-primary"></i>
                        <c:if test="${cart != null && cart.size() > 0}">
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem;">
                                ${cart.size()}
                            </span>
                        </c:if>
                    </a>
                </li>

                <li class="nav-item border-start ps-3 ms-2">
                    <c:choose>
                        <c:when test="${user != null}">
                            <div class="dropdown">
                                <a class="nav-link dropdown-toggle d-flex align-items-center p-0 fw-semibold text-dark" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <span class="me-2 text-dark fw-bold">${user.getName()}</span>
                                    <div class="bg-light rounded-circle d-flex align-items-center justify-content-center" style="width: 35px; height: 35px;"><i class="fas fa-user text-secondary"></i></div>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-custom border-0" aria-labelledby="userDropdown" style="min-width: 230px;">
                                    <li><a class="dropdown-item dropdown-item-custom" href="profile"><i class="fas fa-user-circle"></i> Thông tin</a></li>
                                    <c:if test="${user != null && (user.role == 'admin' || user.role == 'ADMIN')}">
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item dropdown-item-custom" href="adminproduct"><i class="fas fa-boxes"></i> Quản lý sản phẩm</a></li>
                                        <li><a class="dropdown-item dropdown-item-custom" href="admincategory"><i class="fas fa-tags"></i> Quản lý danh mục</a></li>
                                        <li><a class="dropdown-item dropdown-item-custom" href="adminuser"><i class="fas fa-users-cog"></i> Quản lý người dùng</a></li>
                                        <li><a class="dropdown-item dropdown-item-custom" href="statistics"><i class="fas fa-chart-line"></i> Thống kê báo cáo</a></li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item dropdown-item-custom dropdown-item-danger fw-semibold" href="<c:url value='/logout'/>"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="d-flex align-items-center">
                                <a href="<c:url value='/login'/>" class="text-decoration-none text-dark fw-bold me-2" style="font-size: 0.9rem;">Đăng nhập</a>
                                <span class="text-muted">/</span>
                                <a href="register" class="text-decoration-none fw-bold text-dark me-2 ms-2" style="font-size: 0.9rem;">Đăng ký</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
    </div>
</nav>