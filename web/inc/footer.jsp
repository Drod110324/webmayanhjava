<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="chatbox.jsp" />
<footer class="site-footer">
    <div class="container py-4">
        <div class="row gy-4">
            <div class="col-md-4">
                <h5 class="mb-3">Camera Store</h5>
                <p class="mb-2">Chuyên máy ảnh, ống kính và phụ kiện chính hãng cho nhiếp ảnh gia từ mới bắt đầu đến chuyên nghiệp.</p>
                <p class="mb-0"><i class="fas fa-location-dot me-2"></i>Thành Phố Huế</p>
                <p class="mb-0"><i class="fas fa-phone me-2"></i>0123 456 789</p>
                <p class="mb-0"><i class="fas fa-envelope me-2"></i>22T1020796@husc.edu.vn</p>
            </div>

            <div class="col-md-4">
                <h5 class="mb-3">Liên kết nhanh</h5>
                <ul class="list-unstyled mb-0">
                    <li><a href="home">Trang chủ</a></li>
                    <li><a href="home?id_category=1">Máy ảnh</a></li>
                    <li><a href="home?id_category=2">Ống kính</a></li>
                    <li><a href="cart">Giỏ hàng</a></li>
                </ul>
            </div>

            <div class="col-md-4">
                <h5 class="mb-3">Kết nối</h5>
                <p class="mb-2">Theo dõi chúng tôi để cập nhật khuyến mãi và mẹo chụp ảnh hay.</p>
                <div class="footer-social mb-3">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
                <p class="mb-0 text-muted small">Giờ làm việc: 8:00 - 21:00 (T2 - CN)</p>
            </div>
        </div>

        <div class="footer-bottom d-flex flex-column flex-md-row justify-content-between align-items-center mt-3">
            <span>&copy; 2025 Camera Store. Mọi quyền được bảo lưu.</span>
            <span class="mt-2 mt-md-0">Thiết kế bởi Camera Store Team</span>
        </div>
    </div>
</footer>

</body>
</html>