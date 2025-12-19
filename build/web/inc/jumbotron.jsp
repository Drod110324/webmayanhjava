<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    #heroCarousel {
        max-height: 500px;
        overflow: hidden;
    }

    .slider-image-container {
        position: relative;
        height: 500px;
    }

    .slider-image-container img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center;
    }

    .slider-overlay {
        position: absolute;
        inset: 0;
        background: linear-gradient(90deg, rgba(15,23,42,0.85) 0%, rgba(15,23,42,0.5) 40%, transparent 100%);
    }

    .hero-caption h1 {
        text-shadow: 0 4px 12px rgba(0,0,0,0.6);
    }

    .hero-caption p {
        max-width: 520px;
    }
</style>

<div id="heroCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel">
    <!-- Indicators -->
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"
                aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"
                aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2"
                aria-label="Slide 3"></button>
    </div>

    <!-- Carousel Items -->
    <div class="carousel-inner">
        <!-- Slide 1 -->
        <div class="carousel-item active">
            <div class="slider-image-container">
                <img src="assets/images/slider1.jpg"
                     class="d-block w-100" alt="Banner 1">
                <div class="slider-overlay"></div>
            </div>
            <div class="carousel-caption d-none d-md-block text-start hero-caption">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-7">
                            <h1 class="display-5 fw-bold mb-3">Khám phá thế giới máy ảnh</h1>
                            <p class="lead mb-4">
                                Bộ sưu tập máy ảnh mirrorless, DSLR và lens chính hãng, phù hợp từ người mới đến chuyên nghiệp.
                            </p>
                            <a href="shoplist?id_category=1" class="btn btn-primary btn-lg px-5">
                                Mua ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Slide 2 -->
        <div class="carousel-item">
            <div class="slider-image-container">
                <img src="assets/images/slide2.jpg"
                     class="d-block w-100" alt="Banner 2">
                <div class="slider-overlay"></div>
            </div>
            <div class="carousel-caption d-none d-md-block text-start hero-caption">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-7">
                            <h1 class="display-5 fw-bold mb-3">Ưu đãi phụ kiện độc quyền</h1>
                            <p class="lead mb-4">
                                Giảm giá đến 30% cho tripod, thẻ nhớ, balo máy ảnh và nhiều phụ kiện khác trong tháng này.
                            </p>
                            <a href="shoplist?id_category=2" class="btn btn-danger btn-lg px-5">
                                Xem ưu đãi
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Slide 3 -->
        <div class="carousel-item">
            <div class="slider-image-container">
                <img src="assets/images/slider3.jpg"
                     class="d-block w-100" alt="Banner 3">
                <div class="slider-overlay"></div>
            </div>
            <div class="carousel-caption d-none d-md-block text-start hero-caption">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-7">
                            <h1 class="display-5 fw-bold mb-3">Giao hàng nhanh, an toàn</h1>
                            <p class="lead mb-4">
                                Miễn phí vận chuyển cho đơn hàng từ $500, đóng gói chống sốc bảo vệ tối đa thiết bị của bạn.
                            </p>
                            <a href="cart" class="btn btn-warning btn-lg px-5">
                                Đặt hàng ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>