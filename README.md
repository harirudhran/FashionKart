# 🛍️ Fashion Kart - Full-Stack E-Commerce Application

Fashion Kart is a premium, responsive full-stack e-commerce web application built using **Java Servlets, JSP, and MySQL**. It provides a complete customer journey, from browsing a dynamically generated catalog to managing a shopping cart and securely checking out.

## 🚀 Features

### Customer Journey
* **Secure Authentication:** User registration and login system with encrypted credential validation.
* **Dynamic Storefront:** Product catalog dynamically fetched from the database, featuring category filtering (Men, Women, Kids, Accessories).
* **Session-Based Cart:** Optimized shopping cart built using HTTP Sessions to temporarily store items and calculate totals without hitting the database on every click.
* **Seamless Checkout:** Converts temporary session carts into permanent order histories, automatically updating inventory and generating Order IDs.
* **User Dashboard:** Personalized account page displaying user profiles and past order history.

### Admin & Backend
* **Catalog Management:** Admin capabilities to add new products directly into the database, which instantly updates the storefront.
* **MVC Architecture:** Strict separation of concerns (Model-View-Controller) for scalable and maintainable code.
* **DAO Pattern:** Database interactions are abstracted into Data Access Objects (DAO), cleanly separating SQL queries from core Java business logic.

---

## 💻 Tech Stack

**Frontend:**
* HTML5 & CSS3 (Custom premium styling, Flexbox/Grid layouts)
* JSP (JavaServer Pages) for dynamic content rendering
* FontAwesome (Iconography)

**Backend:**
* Java (JDK 11+)
* Java Servlets (Controller logic & HTTP request handling)
* JDBC (Java Database Connectivity)

**Database & Server:**
* MySQL (Relational database)
* Apache Tomcat (Web server & Servlet container)

---

## 🏗️ System Architecture

The project follows a standard **MVC + DAO** architecture:
1. **View (JSP):** Captures user inputs and displays dynamic data.
2. **Controller (Servlets):** Handles routing, manages `HttpSession`, and acts as the middleman between the UI and database.
3. **Model (Java Beans):** Represents entities like `User`, `Product`, and `Order`.
4. **DAO (Data Access Object):** Executes raw SQL queries and maps the ResultSet to Java Models.

---

## 🛠️ Local Setup & Installation

Follow these steps to run Fashion Kart on your local machine.

### Prerequisites
* Java Development Kit (JDK) 11 or higher
* Eclipse IDE for Enterprise Java / IntelliJ IDEA Ultimate
* Apache Tomcat Server (v9.0 or higher)
* MySQL Server & MySQL Workbench

### 1. Database Configuration
Create a new MySQL database named `fashion_kart_db` and run the following setup script to create the necessary tables:

```sql
CREATE DATABASE fashion_kart_db;
USE fashion_kart_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    role VARCHAR(20) DEFAULT 'customer'
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    description TEXT,
    category_id INT,
    image_url VARCHAR(255)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_amount DECIMAL(10,2),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);



2. Project Setup
Clone this repository:
git clone https://github.com/harirudhran/Fashion-Kart.git

Import the project into your IDE (Eclipse/IntelliJ) as a Dynamic Web Project or Maven Project.

Add the MySQL JDBC Connector JAR to your WEB-INF/lib folder (or configure it in your pom.xml if using Maven).

Update the database connection credentials (username and password) inside your DAO classes (e.g., DBConnection.java).

Add the project to your Apache Tomcat Server and start the server.

Open your browser and navigate to http://localhost:8080/FashionKart/ (URL may vary based on your server configuration).

📸 Screenshots
(Note: Replace these with actual image links once you upload screenshots to your repository)

Homepage: ![Homepage](https://drive.google.com/file/d/1v5H4LHmnCwmb8SjaAYdqWQufCaypaEVl/view?usp=sharing)

Dynamic Shop Page: ![Shop Page](https://drive.google.com/file/d/1vwJSRGuSyfKMzkr9EDCkwELQbfP7C3ck/view?usp=sharing)(https://drive.google.com/file/d/1BPCyXqqOzQIoRPQDgRp1ZmNskGNJ8uzC/view?usp=sharing)

Cart & Checkout: ![Cart](https://drive.google.com/file/d/1s-Mcb_1AiNFpNHxXeTAPXzCH84JygKAJ/view?usp=sharing)

Login/Register: ![Authentication](https://drive.google.com/file/d/1U0VZd2cV4K_ZXbPmq31fmRucCo3aRgvt/view?usp=sharing)

👨‍💻 Author
Hari Rudhran M

GitHub: @harirudhran

LinkedIn: Hari Rudhran
