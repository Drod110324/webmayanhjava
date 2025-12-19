<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row">
        <div class="col-12 mb-4">
            <h3 class="fw-bold">Hồ sơ của tôi</h3>
            <p class="text-muted">Quản lý thông tin hồ sơ để bảo mật tài khoản</p>
        </div>

        <c:if test="${not empty successMessage}">
            <div class="col-12">
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="fas fa-check-circle me-2"></i>${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="col-12">
                <div class="alert alert-danger alert-dismissible fade show">
                    <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </div>
        </c:if>

        <div class="col-lg-7 mb-4">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fas fa-user-edit me-2 text-primary"></i>Thông tin chung</h5>
                </div>
                <div class="card-body p-4">
                    <form action="profile" method="post">
                        <input type="hidden" name="action" value="update_info">
                        
                        <div class="mb-3">
                            <label class="form-label text-muted small">Họ và tên</label>
                            <input type="text" name="name" class="form-control" value="${user.name}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label text-muted small">Email (Không thể thay đổi)</label>
                            <input type="email" class="form-control bg-light" value="${user.email}" readonly>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label text-muted small">Số điện thoại</label>
                            <input type="text" name="phone" class="form-control" value="${user.phone}" required pattern="[0-9]{10}">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label text-muted small">Vai trò</label>
                            <span class="badge bg-info text-dark">${user.role}</span>
                        </div>
                        
                        <button type="submit" class="btn btn-primary mt-2">
                            <i class="fas fa-save me-2"></i>Lưu thay đổi
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-5 mb-4">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fas fa-key me-2 text-warning"></i>Đổi mật khẩu</h5>
                </div>
                <div class="card-body p-4">
                    <form action="profile" method="post">
                        <input type="hidden" name="action" value="change_pass">
                        
                        <div class="mb-3">
                            <label class="form-label text-muted small">Mật khẩu hiện tại</label>
                            <div class="input-group">
                                <input type="password" name="old_pass" class="form-control" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label text-muted small">Mật khẩu mới</label>
                            <div class="input-group">
                                <input type="password" name="new_pass" class="form-control" required minlength="6">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label text-muted small">Xác nhận mật khẩu mới</label>
                            <div class="input-group">
                                <input type="password" name="confirm_pass" class="form-control" required>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-warning text-dark mt-2">
                            <i class="fas fa-sync-alt me-2"></i>Cập nhật mật khẩu
                        </button>
                    </form>
                </div>
            </div>
        </div>

    </div>
</div>

