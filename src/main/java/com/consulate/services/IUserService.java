package com.consulate.services;

import com.consulate.dao.User;

public interface IUserService {
	
	public void addUser(User user);
	public void updatePassword(User user,String password);
	public String cryptPassword(String p);


}
