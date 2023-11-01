function createStar() {
    const star = document.createElement('div');
    star.classList.add('star');
    star.style.width = `${Math.random() * 2 + 1}px`;
    star.style.height = star.style.width;

    const x = Math.random() * window.innerWidth;
    const y = Math.random() * window.innerHeight;
    star.style.left = `${x}px`;
    star.style.top = `${y}px`;

    return star;
}

function createStars() {
    const numStars = 100; // Adjust the number of stars
    const container = document.querySelector('.starry-background');
    
    for (let i = 0; i < numStars; i++) {
        const star = createStar();
        container.appendChild(star);
    }
}

function animateStars() {
    const stars = document.querySelectorAll('.star');

    stars.forEach(star => {
        star.style.animation = `twinkle ${Math.random() * 5 + 2}s linear infinite`;
    });
}

createStars();
animateStars();