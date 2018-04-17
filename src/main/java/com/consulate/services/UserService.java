package com.consulate.services;

import com.consulate.dao.User;

public interface UserService {
	
	public void addUser(User user);
	public void updatePassword(User user,String password);

}
