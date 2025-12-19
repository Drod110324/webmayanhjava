<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container mt-4">
    <h2>Quản lý sản phẩm</h2>
    
    <div class="d-flex justify-content-between align-items-center mb-3">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#productModal" 
                onclick="openAddModal();">
            <i class="bi bi-plus-circle"></i> Thêm sản phẩm
        </button>

        <form action="product" method="get" class="d-flex" style="max-width: 400px;">
            <input type="hidden" name="action" value="search">
            
            <input class="form-control me-2" type="search" name="keyword" 
                   placeholder="Nhập tên sản phẩm..." aria-label="Search" 
                   value="${param.keyword}">
            
            <button class="btn btn-success" type="submit">Tìm</button>
        </form>
    </div>

    <table class="table table-bordered table-hover">
        <thead class="table-light">
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Giá</th>
            <th>Số lượng</th>
            <th>Ảnh</th>
            <th>Danh mục (ID)</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty listProduct}">
            <tr>
                <td colspan="7" class="text-center text-muted">Không tìm thấy sản phẩm nào.</td>
            </tr>
        </c:if>
        <c:forEach var="product" items="${listProduct}">
            <tr>
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td>${product.price}</td>
                <td>${product.quantity}</td>
                <td><img src="assets/images/${product.image}" width="50"></td>
                <td>${product.id_category}</td>
                <td>
                    <button class="btn btn-sm btn-warning" 
                            onclick="openEditModal(${product.id}, '${product.name}', ${product.price}, ${product.quantity}, '${product.image}', ${product.id_category});">
                        Sửa
                    </button>
                    <a href="product?action=delete&id=${product.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?');">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="product" method="post" >
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productModalLabel">Thêm sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="id" id="productId">
                    
                    <div class="mb-3">
                        <label class="form-label">Tên sản phẩm</label>
                        <input type="text" class="form-control" name="name" id="productName" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Giá</label>
                        <input type="number" class="form-control" name="price" id="productPrice" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số lượng</label>
                        <input type="number" class="form-control" name="quantity" id="productQuantity" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ảnh (tên file)</label>
                        <input type="text" class="form-control" name="image" id="productImage" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Danh mục (ID)</label>
                        <input type="number" class="form-control" name="id_category" id="productCategory" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Lưu</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="modal fade" id="updateProductModal" tabindex="-1">
  <div class="modal-dialog">
    <form action="updateProduct" method="post">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Cập nhật sản phẩm</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <input type="hidden" name="id" id="update-id">

          <label class="form-label">Tên sản phẩm</label>
          <input type="text" name="name" id="update-name" class="form-control mb-2" required>
          
          <label class="form-label">Giá</label>
          <input type="number" name="price" id="update-price" class="form-control mb-2" required>
          
          <label class="form-label">Số lượng</label>
          <input type="number" name="quantity" id="update-quantity" class="form-control mb-2" required>
          
          <label class="form-label">Ảnh</label>
          <input type="text" name="image" id="update-image" class="form-control mb-2">
          
          <label class="form-label">Danh mục (ID)</label>
          <input type="number" name="id_category" id="update-idcategory" class="form-control mb-2">
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Cập nhật</button>
        </div>
      </div>
    </form>
  </div>
</div>

<script>
    function openEditModal(id, name, price, quantity, image, idCategory) {
        // Javascript tìm thẻ theo ID và gán giá trị
        document.getElementById('update-id').value = id; // Quan trọng nhất
        document.getElementById('update-name').value = name;
        document.getElementById('update-price').value = price;
        document.getElementById('update-quantity').value = quantity;
        document.getElementById('update-image').value = image;
        document.getElementById('update-idcategory').value = idCategory;

        var modal = new bootstrap.Modal(document.getElementById('updateProductModal'));
        modal.show();
    }
</script>