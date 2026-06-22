package com.fashionkart.dao;

import com.fashionkart.model.User;
import java.util.List;

public interface UserDAO {
    // Core actions
    boolean registerUser(User user);
    User loginUser(String email, String password);
    
    // Future-proofing & Profile management
    User getUserById(int userId);
    boolean updateUser(User user);
    boolean deleteUser(int userId);
    List<User> getAllUsers(); 
}