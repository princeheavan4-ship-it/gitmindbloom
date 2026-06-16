// Chatbot responses
const chatbotResponses = {
    greetings: [
        "Hello! I'm here to listen and support you. How are you feeling today?",
        "Hi there! I'm GitMindBloom's support companion. Tell me how you're feeling.",
        "Welcome! I'm here to listen without judgment. What's on your mind?"
    ],
    happy: [
        "That's wonderful to hear! What's making you feel happy today?",
        "I'm so glad you're feeling good! Keep up that positive energy.",
        "That's great! Do you want to talk about what's going well for you?"
    ],
    anxious: [
        "I hear you. Anxiety can be challenging. Would you like to talk about what's triggering it?",
        "Thank you for sharing. Remember, it's okay to feel anxious. What would help you feel calmer?",
        "I'm here for you. Anxiety is a common experience. Let's talk through it together."
    ],
    sad: [
        "I'm sorry you're feeling sad. That's a valid emotion. Do you want to talk about it?",
        "It's okay to feel sad sometimes. I'm here to listen and support you.",
        "Thank you for opening up. Sadness is part of being human. How can I help?"
    ],
    symptoms: [
        "I understand that you're experiencing symptoms. Have you been able to contact your healthcare provider?",
        "That must be challenging. Remember to reach out to your support team or healthcare provider if things feel overwhelming.",
        "Thank you for sharing. It's important to track these experiences. Have you logged them in your mood tracker?"
    ],
    medication: [
        "It's great that you're thinking about your medication. Have you taken it today?",
        "Medication adherence is really important. I can help you track your doses if needed.",
        "Remember, consistent medication use is key to managing your condition. How are you doing with your current plan?"
    ],
    sleep: [
        "Sleep is so important for managing symptoms. How has your sleep been recently?",
        "Quality sleep can really help. Are you having trouble sleeping?",
        "Good sleep hygiene is crucial. Let's talk about what might help you sleep better."
    ],
    support: [
        "Remember, you're not alone. Professional support is always available when you need it.",
        "If you're in crisis, please reach out to emergency services or a crisis helpline.",
        "Your healthcare team is here to support you. Don't hesitate to reach out to them."
    ],
    default: [
        "Thank you for sharing that. How are you coping with it?",
        "I appreciate you opening up. Can you tell me more about that?",
        "That sounds important. How is it affecting you right now?",
        "I'm listening. What would help you feel better?"
    ]
};

// Get appropriate response
function getChatbotResponse(userMessage) {
    const msg = userMessage.toLowerCase();
    
    if (msg.includes('happy') || msg.includes('good') || msg.includes('great') || msg.includes('wonderful')) {
        return chatbotResponses.happy[Math.floor(Math.random() * chatbotResponses.happy.length)];
    } else if (msg.includes('anxious') || msg.includes('anxiety') || msg.includes('worried') || msg.includes('worried')) {
        return chatbotResponses.anxious[Math.floor(Math.random() * chatbotResponses.anxious.length)];
    } else if (msg.includes('sad') || msg.includes('down') || msg.includes('depressed') || msg.includes('blue')) {
        return chatbotResponses.sad[Math.floor(Math.random() * chatbotResponses.sad.length)];
    } else if (msg.includes('hallucination') || msg.includes('delusion') || msg.includes('psychotic') || msg.includes('symptoms')) {
        return chatbotResponses.symptoms[Math.floor(Math.random() * chatbotResponses.symptoms.length)];
    } else if (msg.includes('medication') || msg.includes('medicine') || msg.includes('pill') || msg.includes('dose')) {
        return chatbotResponses.medication[Math.floor(Math.random() * chatbotResponses.medication.length)];
    } else if (msg.includes('sleep') || msg.includes('insomnia') || msg.includes('tired') || msg.includes('fatigue')) {
        return chatbotResponses.sleep[Math.floor(Math.random() * chatbotResponses.sleep.length)];
    } else if (msg.includes('crisis') || msg.includes('emergency') || msg.includes('help') || msg.includes('danger')) {
        return "If you're in crisis, please contact emergency services (911 in the US) or the 988 Suicide & Crisis Lifeline. Your safety is the most important thing.";
    } else if (msg.includes('support') || msg.includes('help') || msg.includes('provider') || msg.includes('therapist')) {
        return chatbotResponses.support[Math.floor(Math.random() * chatbotResponses.support.length)];
    }
    
    return chatbotResponses.default[Math.floor(Math.random() * chatbotResponses.default.length)];
}

// Add message to chat
function addMessage(text, isUser) {
    const chatMessages = document.getElementById('chatMessages');
    const message = document.createElement('div');
    message.className = `message ${isUser ? 'user-message' : 'bot-message'}`;
    
    const avatar = document.createElement('div');
    avatar.className = 'message-avatar';
    avatar.textContent = isUser ? '👤' : '🌿';
    
    const content = document.createElement('div');
    content.className = 'message-content';
    const p = document.createElement('p');
    p.textContent = text;
    content.appendChild(p);
    
    message.appendChild(avatar);
    message.appendChild(content);
    chatMessages.appendChild(message);
    
    // Scroll to bottom
    chatMessages.scrollTop = chatMessages.scrollHeight;
}

// Handle send button
function sendMessage() {
    const input = document.getElementById('userInput');
    const message = input.value.trim();
    
    if (message === '') return;
    
    // Add user message
    addMessage(message, true);
    input.value = '';
    
    // Simulate bot thinking
    setTimeout(() => {
        const response = getChatbotResponse(message);
        addMessage(response, false);
    }, 500);
}

// Handle quick responses
function handleQuickResponse(message) {
    document.getElementById('userInput').value = message;
    sendMessage();
}

// Event listeners
document.addEventListener('DOMContentLoaded', function() {
    const sendBtn = document.getElementById('sendBtn');
    const userInput = document.getElementById('userInput');
    
    if (sendBtn) {
        sendBtn.addEventListener('click', sendMessage);
    }
    
    if (userInput) {
        userInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });
    }
});

// Smooth scrolling for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Add scroll animation for feature cards
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.animation = 'fadeInUp 0.6s ease forwards';
        }
    });
}, {
    threshold: 0.1
});

document.querySelectorAll('.feature-card').forEach(card => {
    observer.observe(card);
});

// Add fade-in animation
const style = document.createElement('style');
style.textContent = `
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .feature-card {
        opacity: 0;
    }
`;
document.head.appendChild(style);

// Add active state to navigation links based on scroll position
window.addEventListener('scroll', () => {
    const sections = document.querySelectorAll('section');
    const navLinks = document.querySelectorAll('.nav-links a');
    
    let current = '';
    sections.forEach(section => {
        const sectionTop = section.offsetTop;
        if (pageYOffset >= sectionTop - 200) {
            current = section.getAttribute('id');
        }
    });
    
    navLinks.forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href').slice(1) === current) {
            link.style.color = 'var(--accent-color)';
        } else {
            link.style.color = 'var(--text-primary)';
        }
    });
});

console.log('🌿 GitMindBloom loaded successfully! Your mental health companion is ready to support you.');