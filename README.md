# RealTime-Search-Box

This Real-Time Search app delivers instant search results as you type, powered by Ruby on Rails, PostgreSQL, and Chartkick. It also tracks popular queries in real-time, providing valuable insights into user trends.

## Features

- Search for articles using a search box.
- View search results dynamically as you type.
- Log user search activities, including queries and timestamps.
- Display most searched queries today per user.
- User authentication and tracking of individual user search history.

## Live Demo
[Live Demo Link](https://realtime-search-box.onrender.com)


## Documentation
**If you want for search analytics to count your search as successful then make sure you pay attention to case sensivity for those stored _ARTICLES_**
- Articles that are stored in DB (case-sensitive):
  - `What is Elon Musk famous for?`
  - `Jeff Bezos net worth`
  - `Best RoR developers in the world`
  - `How old is Jeff Bezos?`
  - `How is the weather in your town?`
  - `Best cars 2023`
  - `Manchester United games season 23/24`

## Screenshot
N/A


## Built With

- Ruby on Rails
- PostgreSQL
- Chartkick
- JavaScript (Importmaps Rails 7)
- SCSS

## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

- Laptop or Desktop
- Web Browser
- Ruby (installed and set up)
- IDE (preferably Visual Studio Code)

### Installation, Setup and Usage

- **Clone this [repo](https://github.com/SaidRasinlic/RealTime-Search-Box.git)**
- Navigate to the correct directory **"cd RealTime-Search-Box"** (case sensitive)
- Run **"bundle install"** in your terminal (in case you need to update the gems run **"bundle update"**)
- Run **"yarn install"**
- Setup database configuration in config/database.yml and use your correct username and password to access PostgreSQL database
- In your terminal run the following three commands:
  - `rails db:create`
  - `rails db:migrate`
  - `rails db:seed`
- **_OPTIONAL:_** Chain them all together: **"rails db:create db:migrate db:seed"**
- Run **rails s** in your terminal to start the server.
- Enter **"localhost:3000" OR "http://localhost:3000/"** in your browser to view the website
- **Congratulations! App should run successfully.**

## Author

👤 **Said Rasinlic**

- GitHub: [@GitHub/SaidRasinlic](https://github.com/SaidRasinlic)
- Twitter: [@Twitter/SaidRasinlic](https://twitter.com/SaidRasinlic)
- LinkedIn: [@LinkedIn/SaidRasinlic](https://www.linkedin.com/in/SaidRasinlic)


## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Helpjuice 

## 📝 License

This project is [MIT](LICENSE) licensed.
