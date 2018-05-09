package com.consulate.services;

import com.consulate.dao.User;

public class UserService implements IUserService {

	@Override
	public void addUser(User user) {
		// TODO Auto-generated method stub

	}

	@Override
	public void updatePassword(User user, String password) {
		// TODO Auto-generated method stub

	}

	@Override
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
		IUserService service = new UserService();
		System.out.println(service.cryptPassword("moh"));
	}

}
