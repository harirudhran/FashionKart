package com.fashionkart.model;

public class Product {
    private int productId;
    private int categoryId;
    private String name;
    private String description;
    private double price;
    private int stockQuantity;
    private String imageUrl;
    private String availableSizes;
    private String availableColors;

    // Default constructor
    public Product() {
    }

    // Constructor without productId (used if we want to add new products later)
    public Product(int categoryId, String name, String description, double price, int stockQuantity, String imageUrl, String availableSizes, String availableColors) {
        this.categoryId = categoryId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.imageUrl = imageUrl;
        this.availableSizes = availableSizes;
        this.availableColors = availableColors;
    }

    // --- Getters and Setters ---
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getAvailableSizes() { return availableSizes; }
    public void setAvailableSizes(String availableSizes) { this.availableSizes = availableSizes; }

    public String getAvailableColors() { return availableColors; }
    public void setAvailableColors(String availableColors) { this.availableColors = availableColors; }
}