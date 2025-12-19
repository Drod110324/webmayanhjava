<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main class="py-5" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 80vh;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5 col-md-7">
                <div class="card shadow-lg border-0">
                    <div class="card-header bg-primary text-white text-center py-4">
                        <h3 class="mb-0">
                            <i class="fas fa-sign-in-alt me-2"></i>
                            Đăng nhập
                        </h3>
                        <p class="mb-0 mt-2 opacity-75">Đăng nhập để tiếp tục mua sắm</p>
                    </div>

                    <div class="card-body p-5">

                        <c:if test="${not empty sessionScope.login_error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                ${sessionScope.login_error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="login" method="post">

                            <div class="mb-3">
                                <label class="form-label" for="emailphone">
                                    <i class="fas fa-user text-muted me-1"></i>
                                    Email hoặc số điện thoại
                                </label>
                                <input type="text" id="emailphone" name="emailphone"
                                       class="form-control"
                                       placeholder="Nhập email hoặc số điện thoại">
                            </div>

                            <div class="mb-3">
                                <label class="form-label" for="password">
                                    <i class="fas fa-lock text-muted me-1"></i>
                                    Mật khẩu
                                </label>
                                <input type="password" id="password" name="password"
                                       class="form-control"
                                       placeholder="Nhập mật khẩu">
                            </div>

                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="" id="rememberMe" checked>
                                    <label class="form-check-label" for="rememberMe">
                                        Ghi nhớ đăng nhập
                                    </label>
                                </div>
                                <a href="#!" class="small text-decoration-none">Quên mật khẩu?</a>
                            </div>

                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-sign-in-alt me-2"></i>
                                    Đăng nhập
                                </button>
                            </div>
                        </form>

                        <div class="text-center">
                            <span class="text-muted">Chưa có tài khoản?</span>
                            <a href="register" class="text-primary text-decoration-none fw-bold">
                                Đăng ký ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>