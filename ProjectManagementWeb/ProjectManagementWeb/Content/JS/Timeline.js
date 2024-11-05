let myChart;

function convertNetDate(netDate) {
    if (!netDate) return null;
    const timestamp = parseInt(netDate.replace(/\/Date\((\d+)\)\//, '$1'), 10);
    return new Date(timestamp);
}

function showTimeline(duAnID) {
    // Kiểm tra canvas element tồn tại
    const canvas = document.getElementById('myChart');
    if (!canvas) {
        console.error('Không tìm thấy element canvas với id "myChart"');
        return;
    }

    fetch(`/Timeline/GetDuAnTimeline?duAnID=${duAnID}`)
        .then(response => response.json())
        .then(result => {
            console.log('Dữ liệu từ server:', result);

            if (result.success) {
                const { NgayBatDau, NgayKetThuc, MoTa } = result.data;

                const startDate = convertNetDate(NgayBatDau);
                const endDate = convertNetDate(NgayKetThuc);

                console.log('Ngày sau khi chuyển đổi:', { startDate, endDate });

                if (myChart) {
                    myChart.destroy();
                }

                const ctx = canvas.getContext('2d');
                myChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        datasets: [{
                            label: 'Timeline Dự Án',
                            data: [
                                { x: startDate, y: 0 },
                                { x: endDate, y: 0 }
                            ],
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 2,
                            pointRadius: 6,
                            pointHoverRadius: 8,
                            tension: 0.1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            x: {
                                type: 'time',
                                time: {
                                    unit: 'month',
                                    displayFormats: {
                                        month: 'MM/yyyy'
                                    }
                                },
                                title: {
                                    display: true,
                                    text: 'Thời gian'
                                }
                            },
                            y: {
                                display: false,
                                min: -0.5,
                                max: 0.5
                            }
                        },
                        plugins: {
                            title: {
                                display: true,
                                text: MoTa
                            },
                            legend: {
                                display: true,
                                position: 'top'
                            },
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        const date = new Date(context.parsed.x);
                                        return `Ngày: ${date.toLocaleDateString('vi-VN')}`;
                                    }
                                }
                            }
                        }
                    }
                });
            } else {
                console.error('Lỗi:', result.message);
                alert(result.message);
            }
        })
        .catch(error => {
            console.error('Lỗi khi gọi API:', error);
            alert('Có lỗi xảy ra khi tải dữ liệu');
        });
}

// Thêm event listener khi document đã load xong
document.addEventListener('DOMContentLoaded', function () {
    console.log('Document loaded');
    const canvas = document.getElementById('myChart');
    console.log('Canvas element:', canvas);
});