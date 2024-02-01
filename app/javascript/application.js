// Import necessary libraries and modules
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

// JavaScript: application.js
document.addEventListener('turbo:load', () => {
  let nextPage = 2;
  let isLoading = false;

  window.addEventListener('scroll', () => {
    const { innerHeight, pageYOffset } = window;
    const { offsetHeight } = document.body;

    // Trigger loading new chefs when scrolled near the bottom of the page
    if (innerHeight + pageYOffset >= offsetHeight - 100 && !isLoading) {
      isLoading = true;

      fetch(`/infinite_scroll?page=${nextPage}`)
        .then(response => response.json())
        .then(chefs => {
          const chefsContainer = document.getElementById('chefs-container');
          chefs.forEach(chef => {
            // Construct the chef card
            const chefCol = document.createElement('div');
            chefCol.className = 'col-md-4 chef-card-col';
            chefCol.innerHTML = `
              <a href="${chef.profile_path}" class="chef-card-link">
                <div class="chef-card">
                  <div class="chef-card-image" style="background-image: url('${chef.image_url}');"></div>
                  <div class="chef-card-info">
                    <h4 class="chef-name">${chef.name}</h4>
                    <p class="chef-specialty">${chef.specialty}</p>
                    <p class="chef-price">${chef.price_per_day} per day</p>
                    <div class="chef-rating">
                      <span class="stars">★★★★☆</span>
                      <span class="rating-number">(${chef.review_count})</span>
                    </div>
                  </div>
                </div>
              </a>
            `;
            // Append the new chef card to the container
            chefsContainer.appendChild(chefCol);
          });

          // Prepare for next page and allow loading again
          nextPage++;
          isLoading = false;
        })
        .catch(error => {
          console.error('Error fetching chefs:', error);
          isLoading = false;
        });
    }
  });
});

