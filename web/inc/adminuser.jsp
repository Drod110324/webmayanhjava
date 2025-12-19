<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-4">
    <h2><i class="bi bi-people-fill"></i> Quản lý người dùng</h2>
    
    <table class="table table-bordered table-hover mt-3">
        <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Email</th>
                <th>SĐT</th>
                <th>Vai trò</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${listUsers}">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.name}</td>
                    <td>${u.email}</td>
                    <td>${u.phone}</td>
                    <td>
                        <span class="badge ${u.role == 'ADMIN' ? 'bg-danger' : 'bg-success'}">
                            ${u.role}
                        </span>
                    </td>
                    <td>
                        <button class="btn btn-sm btn-warning" 
                                onclick="openEditModal(${u.id}, '${u.name}', '${u.email}', '${u.phone}', '${u.role}')">
                            <i class="bi bi-pencil-square"></i> Sửa
                        </button>
                        
                        <a href="users?action=delete&id=${u.id}" class="btn btn-sm btn-danger" 
                           onclick="return confirm('Bạn có chắc muốn xóa user này?');">
                            <i class="bi bi-trash"></i> Xóa
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<div class="modal fade" id="editUserModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="users" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Cập nhật thông tin người dùng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="update_user">
                    <input type="hidden" name="id" id="editId">
                    
                    <div class="mb-3">
                        <label class="form-label">Họ tên:</label>
                        <input type="text" name="name" id="editName" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email:</label>
                        <input type="email" name="email" id="editEmail" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Số điện thoại:</label>
                        <input type="text" name="phone" id="editPhone" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Vai trò:</label>
                        <select name="role" id="editRole" class="form-select">
                            <option value="USER">USER (Người dùng)</option>
                            <option value="ADMIN">ADMIN (Quản trị)</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    function openEditModal(id, name, email, phone, role) {
        document.getElementById('editId').value = id;
        document.getElementById('editName').value = name;
        document.getElementById('editEmail').value = email;
        document.getElementById('editPhone').value = phone;
        document.getElementById('editRole').value = role;
        new bootstrap.Modal(document.getElementById('editUserModal')).show();
    }
</script>