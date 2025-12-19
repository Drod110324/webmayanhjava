<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="stats" value="${stats}"/>

<main class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">
            <i class="fas fa-chart-line me-2 text-primary"></i>
            Thống kê & Báo cáo
        </h2>
        <span class="text-muted">
            <i class="fas fa-calendar me-1"></i>
            <fmt:formatDate value="<%=new java.util.Date()%>" pattern="dd/MM/yyyy HH:mm"/>
        </span>
    </div>

    <!-- Tổng quan -->
    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="bg-primary bg-opacity-10 rounded-circle p-3 me-3">
                            <i class="fas fa-box fa-2x text-primary"></i>
                        </div>
                        <div>
                            <p class="text-muted mb-0 small">Tổng sản phẩm</p>
                            <h3 class="mb-0 fw-bold">${stats.totalProducts}</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="bg-success bg-opacity-10 rounded-circle p-3 me-3">
                            <i class="fas fa-tags fa-2x text-success"></i>
                        </div>
                        <div>
                            <p class="text-muted mb-0 small">Danh mục</p>
                            <h3 class="mb-0 fw-bold">${stats.totalCategories}</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="bg-info bg-opacity-10 rounded-circle p-3 me-3">
                            <i class="fas fa-users fa-2x text-info"></i>
                        </div>
                        <div>
                            <p class="text-muted mb-0 small">Tổng người dùng</p>
                            <h3 class="mb-0 fw-bold">${stats.totalUsers}</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="bg-warning bg-opacity-10 rounded-circle p-3 me-3">
                            <i class="fas fa-dollar-sign fa-2x text-warning"></i>
                        </div>
                        <div>
                            <p class="text-muted mb-0 small">Tổng giá trị</p>
                            <h3 class="mb-0 fw-bold">
                                $<fmt:formatNumber value="${stats.totalProductValue}" maxFractionDigits="0"/>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <!-- Sản phẩm theo danh mục -->
        <div class="col-lg-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-bottom">
                    <h5 class="mb-0">
                        <i class="fas fa-chart-pie me-2 text-primary"></i>
                        Sản phẩm theo danh mục
                    </h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty stats.productsByCategory}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Danh mục</th>
                                        <th class="text-end">Số lượng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="entry" items="${stats.productsByCategory}">
                                        <tr>
                                            <td>${entry.key}</td>
                                            <td class="text-end">
                                                <span class="badge bg-primary">${entry.value}</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Top sản phẩm đã bán - Biểu đồ -->
        <div class="col-lg-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-bottom">
                    <h5 class="mb-0">
                        <i class="fas fa-shopping-bag me-2 text-success"></i>
                        Top 5 sản phẩm đã bán
                    </h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty stats.topSoldProducts}">
                        <div style="position: relative; height: 300px;">
                            <canvas id="topSoldProductsChart"></canvas>
                        </div>
                        <script>
                            // Dữ liệu từ JSP
                            const topSoldData = {
                                labels: [
                                    <c:forEach var="entry" items="${stats.topSoldProducts}" varStatus="loop">
                                    '${entry.key}'<c:if test="${!loop.last}">,</c:if>
                                    </c:forEach>
                                ],
                                values: [
                                    <c:forEach var="entry" items="${stats.topSoldProducts}" varStatus="loop">
                                    ${entry.value}<c:if test="${!loop.last}">,</c:if>
                                    </c:forEach>
                                ]
                            };

                            // Vẽ biểu đồ cột
                            const ctx = document.getElementById('topSoldProductsChart').getContext('2d');
                            new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: topSoldData.labels,
                                    datasets: [{
                                        label: 'Số lượng đã bán',
                                        data: topSoldData.values,
                                        backgroundColor: [
                                            'rgba(40, 167, 69, 0.8)',
                                            'rgba(40, 167, 69, 0.7)',
                                            'rgba(40, 167, 69, 0.6)',
                                            'rgba(40, 167, 69, 0.5)',
                                            'rgba(40, 167, 69, 0.4)'
                                        ],
                                        borderColor: [
                                            'rgba(40, 167, 69, 1)',
                                            'rgba(40, 167, 69, 1)',
                                            'rgba(40, 167, 69, 1)',
                                            'rgba(40, 167, 69, 1)',
                                            'rgba(40, 167, 69, 1)'
                                        ],
                                        borderWidth: 2,
                                        borderRadius: 8
                                    }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    plugins: {
                                        legend: {
                                            display: false
                                        },
                                        tooltip: {
                                            backgroundColor: 'rgba(0, 0, 0, 0.8)',
                                            padding: 12,
                                            titleFont: {
                                                size: 14,
                                                weight: 'bold'
                                            },
                                            bodyFont: {
                                                size: 13
                                            },
                                            callbacks: {
                                                label: function(context) {
                                                    return 'Đã bán: ' + context.parsed.y + ' sản phẩm';
                                                }
                                            }
                                        }
                                    },
                                    scales: {
                                        y: {
                                            beginAtZero: true,
                                            ticks: {
                                                stepSize: 1,
                                                font: {
                                                    size: 11
                                                }
                                            },
                                            grid: {
                                                color: 'rgba(0, 0, 0, 0.05)'
                                            }
                                        },
                                        x: {
                                            ticks: {
                                                font: {
                                                    size: 10
                                                },
                                                maxRotation: 45,
                                                minRotation: 45
                                            },
                                            grid: {
                                                display: false
                                            }
                                        }
                                    }
                                }
                            });
                        </script>
                    </c:if>
                    <c:if test="${empty stats.topSoldProducts}">
                        <div class="text-center py-5">
                            <i class="fas fa-info-circle fa-3x text-muted mb-3"></i>
                            <p class="text-muted mb-0">Chưa có dữ liệu sản phẩm đã bán</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Thống kê người dùng -->
        <div class="col-lg-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-bottom">
                    <h5 class="mb-0">
                        <i class="fas fa-user-shield me-2 text-danger"></i>
                        Phân loại người dùng
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-6">
                            <div class="text-center p-3 bg-danger bg-opacity-10 rounded">
                                <i class="fas fa-user-shield fa-2x text-danger mb-2"></i>
                                <p class="mb-0 small text-muted">Quản trị viên</p>
                                <h4 class="mb-0 fw-bold">${stats.totalAdmins}</h4>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="text-center p-3 bg-success bg-opacity-10 rounded">
                                <i class="fas fa-user fa-2x text-success mb-2"></i>
                                <p class="mb-0 small text-muted">Người dùng</p>
                                <h4 class="mb-0 fw-bold">${stats.totalRegularUsers}</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sản phẩm sắp hết hàng -->
        <div class="col-lg-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-bottom">
                    <h5 class="mb-0">
                        <i class="fas fa-exclamation-triangle me-2 text-warning"></i>
                        Sản phẩm sắp hết hàng
                    </h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty stats.lowStockProducts}">
                        <div class="table-responsive">
                            <table class="table table-hover table-sm">
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th class="text-end">Số lượng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="entry" items="${stats.lowStockProducts}">
                                        <tr>
                                            <td>${entry.key}</td>
                                            <td class="text-end">
                                                <span class="badge bg-warning text-dark">${entry.value}</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    <c:if test="${empty stats.lowStockProducts}">
                        <p class="text-muted text-center mb-0">
                            <i class="fas fa-check-circle me-2 text-success"></i>
                            Tất cả sản phẩm đều đủ hàng
                        </p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</main>

