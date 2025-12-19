<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container mt-4">
    <h2>Quản lý Danh mục</h2>
    
    <button type="button" class="btn btn-primary mb-3" onclick="openAddCategoryModal();">
        Thêm Danh mục
    </button>

    <table class="table table-bordered table-hover">
        <thead class="table-light">
        <tr>
            <th>ID</th>
            <th>Tên Danh mục</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="category" items="${listCategory}">
            <tr>
                <td>${category.id}</td>
                <td>${category.name}</td>
                <td>
                    <button class="btn btn-sm btn-warning" onclick="openEditCategoryModal(${category.id}, '${category.name}');">Sửa</button>
                    <a href="category?action=delete&id=${category.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa danh mục này?');">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="category" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm danh mục mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <label class="form-label">Tên danh mục <span class="text-danger">*</span></label>
                    <input type="text" name="name" id="addCategoryName" class="form-control" placeholder="Nhập tên danh mục..." required>
                    <small class="text-muted">ID sẽ được tự động tạo</small>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Lưu</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="modal fade" id="editCategoryModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="updateCategory" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Cập nhật danh mục</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <label class="form-label">ID</label>
                    <input type="number" name="id" id="editCategoryId" class="form-control" required>
                    <label class="form-label">Tên danh mục</label>
                    <input type="text" name="name" id="editCategoryName" class="form-control" required>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    function openAddCategoryModal() {
        document.getElementById('addCategoryName').value = '';
        var myModal = new bootstrap.Modal(document.getElementById('addCategoryModal'));
        myModal.show();
    }

    function openEditCategoryModal(id, name) {
        document.getElementById('editCategoryId').value = id;
        document.getElementById('editCategoryName').value = name;
        var myModal = new bootstrap.Modal(document.getElementById('editCategoryModal'));
        myModal.show();
    }
</script>