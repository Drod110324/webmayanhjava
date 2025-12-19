<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<main class="py-5" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 80vh;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="card shadow-lg border-0">
                    <div class="card-header bg-primary text-white text-center py-4">
                        <h3 class="mb-0">
                            <i class="fas fa-user-plus me-2"></i>
                            Đăng ký tài khoản
                        </h3>
                        <p class="mb-0 mt-2 opacity-75">Tạo tài khoản mới để mua sắm</p>
                    </div>
                    <div class="card-body p-5">
                        
                        <c:if test="${not empty exist_user}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                ${exist_user}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <form action="register" method="post" id="registerForm" novalidate>
                            
                            <div class="mb-3">
                                <label for="lastName" class="form-label">
                                    <i class="fas fa-user text-muted me-1"></i>
                                    Họ và tên <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="lastName" name="name" 
                                       placeholder="Nhập họ tên của bạn" required value="${param.name}">
                                <div class="text-danger small">${err_name}</div>
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">
                                    <i class="fas fa-phone text-muted me-1"></i>
                                    Số điện thoại <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="phone" name="phone" 
                                       placeholder="Nhập số điện thoại (10 số)" required value="${param.phone}">
                                <div class="text-danger small">${err_phone}</div>
                            </div>  
                            
                            <div class="mb-3">
                                <label for="email" class="form-label">
                                    <i class="fas fa-envelope text-muted me-1"></i>
                                    Email <span class="text-danger">*</span>
                                </label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       placeholder="Nhập địa chỉ email" required value="${param.email}">
                                <div class="text-danger small">${err_email}</div>
                            </div>                             

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="password" class="form-label">
                                        <i class="fas fa-lock text-muted me-1"></i>
                                        Mật khẩu <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="password" name="password" 
                                               placeholder="Nhập mật khẩu" required minlength="6">
                                    </div>
                                    <div class="form-text">Tối thiểu 6 ký tự</div>
                                    <div class="text-danger small">${err_password}</div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="confirmPassword" class="form-label">
                                        <i class="fas fa-lock text-muted me-1"></i>
                                        Xác nhận mật khẩu <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="confirmPassword" name="repassword" 
                                               placeholder="Nhập lại mật khẩu" required>
                                    </div>
                                    <div class="text-danger small">${err_repassword}</div>
                                </div>
                            </div>                           

                            <div class="d-grid mb-4">
                                <button type="submit" class="btn btn-primary btn-lg" id="registerBtn">
                                    <i class="fas fa-user-plus me-2"></i>
                                    Đăng ký
                                </button>
                            </div>
                        </form>

                        <div class="text-center">
                            <span class="text-muted">Đã có tài khoản?</span>
                            <a href="login" class="text-primary text-decoration-none fw-bold">
                                Đăng nhập ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>