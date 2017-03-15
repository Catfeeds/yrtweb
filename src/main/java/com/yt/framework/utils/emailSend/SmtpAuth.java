package com.yt.framework.utils.emailSend;

/**
 * 
 * @author Administrator
 *
 */
public class SmtpAuth extends javax.mail.Authenticator {
	private String username, password;

	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public SmtpAuth(String auth) {
		String[] aut=auth.split(":");
		this.username = aut[0];
		this.password = aut[1];
	}

	protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
		return new javax.mail.PasswordAuthentication(username, password);
	}
}