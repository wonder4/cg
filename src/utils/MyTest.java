package utils;

/**
 * @author Hui,Gang
 * @version Build 2010-8-23 下午01:53:17
 */

public class MyTest {
	private String username;

	private String password;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		System.out.println("===============>username:" + username);
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		System.out.println("===============>password:" + password);
		this.password = password;
	}

}
