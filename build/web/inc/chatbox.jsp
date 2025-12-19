<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    .chat-btn {
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 60px;
        height: 60px;
        background: linear-gradient(135deg, #0d6efd, #0a58ca);
        color: white;
        border-radius: 50%;
        text-align: center;
        line-height: 60px;
        font-size: 24px;
        cursor: pointer;
        box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        z-index: 9999;
        transition: transform 0.3s;
    }
    .chat-btn:hover {
        transform: scale(1.1);
    }
    .chat-box {
        position: fixed;
        bottom: 100px;
        right: 30px;
        width: 350px;
        height: 500px; /* Tăng chiều cao xíu để chứa nút */
        background: white;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        z-index: 9999;
        display: none;
        flex-direction: column;
        overflow: hidden;
        border: 1px solid #ddd;
    }
    .chat-header {
        background: #0d6efd;
        color: white;
        padding: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-weight: bold;
    }

    .chat-body {
        flex: 1;
        padding: 15px;
        overflow-y: auto;
        background: #f8f9fa;
        display: flex;
        flex-direction: column;
        gap: 10px;
    }
    .message {
        max-width: 80%;
        padding: 10px 15px;
        border-radius: 15px;
        font-size: 14px;
        line-height: 1.4;
        word-wrap: break-word;
    }
    .bot-message {
        background: #e9ecef;
        color: #333;
        align-self: flex-start;
        border-bottom-left-radius: 2px;
    }
    .user-message {
        background: #0d6efd;
        color: white;
        align-self: flex-end;
        border-bottom-right-radius: 2px;
    }
    .chat-options {
        display: flex;
        flex-wrap: wrap;
        gap: 5px;
        margin-top: 5px;
    }
    .option-btn {
        background-color: white;
        border: 1px solid #0d6efd;
        color: #0d6efd;
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 12px;
        cursor: pointer;
        transition: all 0.2s;
    }
    .option-btn:hover {
        background-color: #0d6efd;
        color: white;
    }
    .chat-footer {
        padding: 10px;
        background: white;
        border-top: 1px solid #eee;
        display: flex;
        gap: 10px;
    }
    .chat-footer input {
        border-radius: 20px;
        font-size: 14px;
    }
    .chat-footer button {
        border-radius: 50%;
        width: 40px;
        height: 40px;
        padding: 0;
        display: flex;
        align-items: center;
        justify-content: center;
    }
</style>

<div class="chat-btn" onclick="toggleChat()">
    <i class="fas fa-comment-dots"></i>
</div>

<div class="chat-box" id="chatBox">
    <div class="chat-header">
        <div><i class="fas fa-robot me-2"></i>Trợ lý ảo</div>
        <button type="button" class="btn-close btn-close-white" onclick="toggleChat()"></button>
    </div>
    
    <div class="chat-body" id="chatBody">
        <div class="message bot-message">
            Xin chào! Tôi có thể giúp gì cho bạn hôm nay?
        </div>
        </div>
    
    <div class="chat-footer">
        <input type="text" id="chatInput" class="form-control" placeholder="Nhập tin nhắn..." onkeypress="handleKeyPress(event)">
        <button class="btn btn-primary" onclick="sendMessage()">
            <i class="fas fa-paper-plane"></i>
        </button>
    </div>
</div>

<script>
    const quickQuestions = [
        "Giá sản phẩm?",
        "Chính sách bảo hành",
        "Địa chỉ cửa hàng",
        "Phí giao hàng",
        "Tư vấn mua máy"
    ];
    let optionsShown = false;

    function toggleChat() {
        var chatBox = document.getElementById('chatBox');
        if (chatBox.style.display === 'none' || chatBox.style.display === '') {
            chatBox.style.display = 'flex';
            document.getElementById('chatInput').focus();
            if (!optionsShown) {
                showQuickOptions();
                optionsShown = true;
            }
        } else {
            chatBox.style.display = 'none';
        }
    }

    function showQuickOptions() {
        var chatBody = document.getElementById('chatBody');
        var optionsDiv = document.createElement('div');
        optionsDiv.className = 'chat-options';
        
        quickQuestions.forEach(function(question) {
            var btn = document.createElement('button');
            btn.className = 'option-btn';
            btn.innerText = question;
            btn.onclick = function() { sendOption(question); }; 
            optionsDiv.appendChild(btn);
        });

        chatBody.appendChild(optionsDiv);
        chatBody.scrollTop = chatBody.scrollHeight;
    }
    function sendOption(text) {
        addMessage(text, 'user-message');
        setTimeout(function() {
            var botResponse = getBotResponse(text);
            addMessage(botResponse, 'bot-message');
        }, 500);
    }

    function handleKeyPress(e) {
        if (e.key === 'Enter') {
            sendMessage();
        }
    }

    function sendMessage() {
        var input = document.getElementById('chatInput');
        var message = input.value.trim();
        
        if (message !== "") {
            addMessage(message, 'user-message');
            input.value = '';

            setTimeout(function() {
                var botResponse = getBotResponse(message);
                addMessage(botResponse, 'bot-message');
            }, 500);
        }
    }

    function addMessage(text, className) {
        var chatBody = document.getElementById('chatBody');
        var div = document.createElement('div');
        div.className = 'message ' + className;
        div.innerHTML = text;
        chatBody.appendChild(div);
        chatBody.scrollTop = chatBody.scrollHeight;
    }

    function getBotResponse(input) {
        input = input.toLowerCase();

        if (input.includes('xin chào') || input.includes('hi') || input.includes('hello')) {
            return "Chào bạn! Chào mừng bạn đến với cửa hàng máy ảnh.";
        } 
        else if (input.includes('giá') || input.includes('bao nhiêu')) {
            return "Giá sản phẩm được niêm yết trên từng ảnh. Bạn có thể bấm vào sản phẩm để xem chi tiết nhé!";
        } 
        else if (input.includes('bảo hành')) {
            return "Tất cả máy ảnh bên mình đều được bảo hành chính hãng 12-24 tháng ạ. Lỗi 1 đổi 1 trong 30 ngày đầu.";
        } 
        else if (input.includes('địa chỉ') || input.includes('ở đâu')) {
            return "Cửa hàng mình ở số 123 Đường ABC, Hà Nội. Mời bạn ghé chơi!";
        }
        else if (input.includes('ship') || input.includes('giao hàng') || input.includes('phí')) {
            return "Bên mình miễn phí giao hàng toàn quốc cho đơn từ 5 triệu đồng. Đơn dưới 5 triệu phí ship là 30k ạ.";
        }
        else if (input.includes('tư vấn') || input.includes('mua máy')) {
            return "Bạn muốn mua máy ảnh để chụp phong cảnh, chân dung hay quay vlog ạ? Hãy chat 'phong cảnh' hoặc 'chân dung' để mình gợi ý.";
        }
        // Logic tư vấn sâu hơn
        else if (input.includes('phong cảnh')) {
            return "Chụp phong cảnh bạn nên chọn các dòng máy có cảm biến Full-frame và ống kính góc rộng. Bạn tham khảo Sony A7III nhé.";
        }
        else if (input.includes('chân dung')) {
            return "Chụp chân dung cần xóa phông tốt. Bạn nên chọn ống kính 50mm hoặc 85mm khẩu độ lớn. Canon 6D Mark II là lựa chọn tốt.";
        }
        else if (input.includes('cảm ơn')) {
            return "Không có chi! Chúc bạn một ngày tốt lành.";
        }
        else {
            return "Xin lỗi, tôi chưa hiểu ý bạn. Bạn có thể chọn các câu hỏi có sẵn bên trên được không?";
        }
    }
</script>