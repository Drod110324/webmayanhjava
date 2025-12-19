<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Main Content -->
    <div class="content-wrapper">
        <div class="container-fluid py-4">
            <c:choose>
                <c:when test="${param.tab == 'product' || param.tab == null}">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">
                                <i class="bi bi-box-seam"></i> Danh sách s?n ph?m
                            </h5>
                            <a href="${pageContext.request.contextPath}/admin/product-edit.jsp" 
                               class="btn btn-primary">
                                <i class="bi bi-plus-circle"></i> Thêm s?n ph?m
                            </a>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên s?n ph?m</th>
                                            <th>giá</th>
                                            <th>Danh m?cc</th>
                                            <th>Tr?ng thái</th>
                                            <th>Hành ??ng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${productList}">
                                            <tr>
                                                <td>${product.id}</td>
                                                <td>${product.name}</td>
                                                <td>
                                                    <fmt:formatNumber value="${product.price}" 
                                                                    type="currency" 
                                                                    currencySymbol="?"/>
                                                </td>
                                                <td>${product.categoryName}</td>
                                                <td>
                                                    <span class="badge ${product.active ? 'bg-success' : 'bg-secondary'}">
                                                        ${product.active ? 'Ho?t ??ng' : 'Ng?ng bï¿½n'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/admin/product-edit.jsp?id=${product.id}" 
                                                       class="btn btn-sm btn-warning btn-action">
                                                        <i class="bi bi-pencil"></i> S?a
                                                    </a>
                                                    <button type="button" 
                                                            class="btn btn-sm btn-danger"
                                                            onclick="confirmDelete('product', ${product.id}, '${fn:escapeXml(product.name)}')">
                                                        <i class="bi bi-trash"></i> Xóa
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty productList}">
                                            <tr>
                                                <td colspan="6" class="text-center text-muted">
                                                    Không có s?n ph?m nào
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:when>

                <!-- Qu?n lï¿½ danh m?c -->
                <c:when test="${param.tab == 'category'}">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">
                                <i class="bi bi-tags"></i> Danh sách danh m?c
                            </h5>
                            <a href="${pageContext.request.contextPath}/admin/category-edit.jsp" 
                               class="btn btn-primary">
                                <i class="bi bi-plus-circle"></i> Thêm danh m?c
                            </a>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên danh m?c</th>
                                            <th>Mï¿½ t?</th>
                                            <th>S? s?n ph?m</th>
                                            <th>tTr?ng thái</th>
                                            <th>Hành ??ng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="category" items="${categoryList}">
                                            <tr>
                                                <td>${category.id}</td>
                                                <td>${category.name}</td>
                                                <td>${category.description}</td>
                                                <td>
                                                    <span class="badge bg-info">${category.productCount}</span>
                                                </td>
                                                <td>
                                                    <span class="badge ${category.active ? 'bg-success' : 'bg-secondary'}">
                                                        ${category.active ? 'Ho?t ??ng' : 'Khï¿½ng ho?t ??ng'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/admin/category-edit.jsp?id=${category.id}" 
                                                       class="btn btn-sm btn-warning btn-action">
                                                        <i class="bi bi-pencil"></i> S?a
                                                    </a>
                                                    <button type="button" 
                                                            class="btn btn-sm btn-danger"
                                                            onclick="confirmDelete('category', ${category.id}, '${fn:escapeXml(category.name)}')">
                                                        <i class="bi bi-trash"></i> Xóa
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty categoryList}">
                                            <tr>
                                                <td colspan="6" class="text-center text-muted">
                                                    Không có danh m?c nào
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:when>

                <!-- Qu?n lï¿½ ng??i dï¿½ng -->
                <c:when test="${param.tab == 'user'}">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">
                                <i class="bi bi-people"></i> Danh sách ng??i dùng
                            </h5>
                            <a href="${pageContext.request.contextPath}/admin/user-edit.jsp" 
                               class="btn btn-primary">
                                <i class="bi bi-plus-circle"></i> Thêm ng??i dùng
                            </a>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Username</th>
                                            <th>H? tên</th>
                                            <th>Email</th>
                                            <th>Vai trò</th>
                                            <th>Tr?ng thái</th>
                                            <th>hành ??ng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="user" items="${userList}">
                                            <tr>
                                                <td>${user.id}</td>
                                                <td>${user.username}</td>
                                                <td>${user.fullName}</td>
                                                <td>${user.email}</td>
                                                <td>
                                                    <span class="badge ${user.role == 'ADMIN' ? 'bg-danger' : 'bg-primary'}">
                                                        ${user.role}
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class="badge ${user.active ? 'bg-success' : 'bg-secondary'}">
                                                        ${user.active ? 'Ho?t ??ng' : 'Khï¿½a'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/admin/user-edit.jsp?id=${user.id}" 
                                                       class="btn btn-sm btn-warning btn-action">
                                                        <i class="bi bi-pencil"></i> S?a
                                                    </a>
                                                    <c:if test="${user.id != sessionScope.currentUser.id}">
                                                        <button type="button" 
                                                                class="btn btn-sm btn-danger"
                                                                onclick="confirmDelete('user', ${user.id}, '${fn:escapeXml(user.username)}')">
                                                            <i class="bi bi-trash"></i> Xóa
                                                        </button>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty userList}">
                                            <tr>
                                                <td colspan="7" class="text-center text-muted">
                                                    Không có ng??i dùng nào
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:when>
            </c:choose>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <script>
        function confirmDelete(type, id, name) {
            var nameEl = document.getElementById('deleteItemName');
            if (nameEl) nameEl.textContent = name || '';
            var btn = document.getElementById('confirmDeleteBtn');
            if (btn) btn.dataset.href = (type === 'category' ? 'category' : (type === 'user' ? 'admin/user' : 'product')) + '?action=delete&id=' + id;
            var modalEl = document.getElementById('deleteModal');
            if (modalEl) {
                var modal = new bootstrap.Modal(modalEl);
                modal.show();
            }
        }
        document.addEventListener('DOMContentLoaded', function(){
            var btn = document.getElementById('confirmDeleteBtn');
            if(btn){
                btn.addEventListener('click', function(){
                    var href = this.dataset.href;
                    if(href) window.location.href = href;
                });
            }
        });
    </script>
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">
                        <i class="bi bi-exclamation-triangle text-danger"></i> Xï¿½c nh?n xï¿½a
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>B?n cï¿½ ch?c ch?n mu?n xï¿½a <strong id="deleteItemName"></strong> khï¿½ng?</p>
                    <p class="text-danger">
                        <i class="bi bi-exclamation-circle"></i> 
                        Hï¿½nh ??ng nï¿½y khï¿½ng th? hoï¿½n tï¿½c!
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">H?y</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">
                        <i class="bi bi-trash"></i> Xï¿½a
                    </button>
                </div>
            </div>
        </div>
    </div>

    
    