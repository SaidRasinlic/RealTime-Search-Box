import consumer from "./channels/consumer";

document.addEventListener("DOMContentLoaded", () => {

  consumer.subscriptions.create("SearchCountsChannel", {
    connected() {
    },
    received(data) {
      const mostSearchedGlobally = data.most_searched_data_globally;
      console.log(mostSearchedGlobally);
      if (mostSearchedGlobally) {
        const query = mostSearchedGlobally.query;
        const count = mostSearchedGlobally.count;
        const globalMostSearched = document.getElementById("global-most-searched");
        globalMostSearched.textContent = `${query} ${count}`;
        // Now you can update your UI or perform any actions with the received data
        console.log(`Most searched globally: Query: ${query}, Count: ${count}`);
    }
    }
  });

  const searchBox = document.getElementById("search-box");
  const searchResults = document.getElementById("search-results");
  const searchLog = document.getElementById("search-log"); // Element to update
  const searchQueryCounts = {}; // Object to store search query counts

  // Debounce function to delay input event handler
  function debounce(func, delay) {
    let timer;
    return function (...args) {
      clearTimeout(timer);
      timer = setTimeout(() => {
        func.apply(this, args);
      }, delay);
    };
  }

  // Function to update search counts via AJAX
  function updateSearchCounts() {
    fetch('/update_search_counts', {
      method: 'GET',
    })
    .then(response => (response.json()))
    .then(counts => {
      const matchingCount = document.getElementById("matching-count");
      const nonMatchingCount = document.getElementById("non-matching-count");
      // const globalMostSearched = document.getElementById("global-most-searched");
      const localMostSearched = document.getElementById("local-most-searched");
      const localMostSearchedToday = document.getElementById("local-most-searched-today");
      matchingCount.textContent = `${counts.matching_count}`;
      nonMatchingCount.textContent = `${counts.non_matching_count}`;
      // globalMostSearched.textContent = `${counts.most_searched_data_globally.query} ${counts.most_searched_data_globally.count}`;
      localMostSearched.textContent = `${counts.most_searched_query_per_user} ${counts.most_searched_query_per_user_count}`;
      localMostSearchedToday.textContent = `${counts.most_searhed_query_today.query} ${counts.most_searhed_query_today.count}`;

      // const chatChannel = consumer.subscriptions.create("SearchCountsChannel", {
      //   connected() {
      //     console.log("Connected to ChatChannel");
      //   },
      //   received(data) {
      //     console.log("Received data:", data);

      //     const mostSearchedGlobally = data.most_searched_data_globally;
      //     console.log(mostSearchedGlobally);
      //     if (mostSearchedGlobally) {
      //       const query = mostSearchedGlobally.query;
      //       const count = mostSearchedGlobally.count;
      //       const globalMostSearched = document.getElementById("global-most-searched");
      //       globalMostSearched.textContent = `${query} ${count}`;
      //       // Now you can update your UI or perform any actions with the received data
      //       console.log(`Most searched globally: Query: ${query}, Count: ${count}`);
      //   }
      //   }
      // });

      // chatChannel.perform("subscribed");
    });
  }

  // Input event handler with debounce
  const delayedSearchHandler = debounce(query => {
    if (query.length >= 3) {
      fetch(`/articles/search?q=${query}`)
        .then(response => response.json())
        .then(data => {
          searchResults.innerHTML = "";
          data.forEach(article => {
            const result = document.createElement("div");
            result.textContent = article.title;
            result.classList.add("search-result"); // Add a class for styling
            searchResults.appendChild(result);
            
            // Add click event listener to search results
            result.addEventListener("click", () => {
              searchBox.value = result.textContent; // Set search box value
              query = searchBox.value
              searchResults.innerHTML = ""; // Clear search results
              delayedSearchHandler(query)
            });
          });

          // Update search log dynamically
          // ... (your existing code)
          if (!searchQueryCounts[query]) {
            searchQueryCounts[query] = 1;
            const searchLogItem = document.createElement("tr");
            searchLogItem.dataset.query = query;
            searchLogItem.innerHTML = `
              <td>${query}</td>
              <td>1</td>
            `;
            searchLog.appendChild(searchLogItem);
          } else {
            searchQueryCounts[query]++;
            const existingItem = searchLog.querySelector(`tr[data-query="${query}"]`);
            if (existingItem) {
              const countCell = existingItem.querySelector("td:last-child");
              countCell.textContent = searchQueryCounts[query];
            }
          }

          // Fetch and update search counts
          updateSearchCounts();
        });
    } else {
      searchResults.innerHTML = "";
      updateSearchCounts();
    }
  }, 1000); // Delay of 300 milliseconds

  // Add debounced input event handler
  searchBox.addEventListener("input", event => {
    const query = event.target.value;
    delayedSearchHandler(query);
  });

});