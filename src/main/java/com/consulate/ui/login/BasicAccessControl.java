package com.consulate.ui.login;

import java.io.Serializable;
import java.util.List;

import com.consulate.dao.Dao;
import com.consulate.dao.DaoService;
import com.consulate.dao.User;

/**
 * Default mock implementation of {@link AccessControl}. This implementation
 * accepts any string as a password, and considers the user "admin" as the only
 * administrator.
 */
public class BasicAccessControl implements AccessControl, Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7465050742840857545L;
	private DaoService dao = new Dao();

	@Override
	public boolean signIn(String username, String password) {
		if (checkUser(username, password)) {
			CurrentUser.set(username);
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean isUserSignedIn() {
		return !CurrentUser.get().isEmpty();
	}

	@Override
	public boolean isUserInRole(String role) {
		// TODO Auto-generated method stub
		return false;
	}
	/*
	 * @Override public String getPrincipalName() { // TODO Auto-generated method
	 * stub return null; }
	 */

	// @Override
	// public boolean signIn(String username, String password) {
	// // TODO Auto-generated method stub
	// return true;
	// }

	/*
	 * @Override public boolean isUserInRole(String role) {
	 * 
	 * @SuppressWarnings("unchecked") List<Role> roles = (List<Role>) dao
	 * .getByProperty(User.class, "username", getPrincipalName())
	 * .get(0).getRoles(); int i = 0; for (Role r : roles) { if
	 * (r.getRole().equals(role)) { i++; } } if (i == 0) { return false; } else {
	 * return true; } }
	 */
	@Override
	public String getPrincipalName() {
		return CurrentUser.get();
	}

	public Boolean checkUser(String username, String password) {
		User user = null;
		if (username == null || username.isEmpty()) {
			return false;
		}
		try {
			user = (User) dao.getByProperty(User.class, "username", username).get(0);
		} catch (Exception e) {
			// TODO: handle exception
			System.err.println(e.getMessage());
			return false;
		}
		if (!user.getEnabled()) {
			return false;
		}
		// if (BCrypt.checkpw(password, user.getPassword())) {
		//
		// return true;
		// }
		if (user.getPassword().equals(cryptPassword(password))) {
			return true;
		}

		else {
			return false;
		}
	}

	public String cryptPassword(String p) {
		return getHash(p, "SHA-512");
	}

	public static String getHash(String txt, String hashType) {
		try {
			java.security.MessageDigest md = java.security.MessageDigest.getInstance(hashType);
			byte[] array = md.digest(txt.getBytes());
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < array.length; ++i) {
				sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
			}
			return sb.toString();
		} catch (java.security.NoSuchAlgorithmException e) {
			// error action
		}
		return null;
	}

	public static void main(String[] args) {
		BasicAccessControl accessControl = new BasicAccessControl();
		System.out.println(accessControl.checkUser("amine", "Amine"));
	}
}
