package utils;

import java.io.IOException;
import java.net.URL;
import java.util.Properties;

public class ReadPropertiesUtils {
	private String prop_path = "";

	Properties props = null;

	public ReadPropertiesUtils(String prop_path) {
		this.prop_path = prop_path;
		readProperties();
	}

	private void readProperties() {
		this.props = new Properties();
		URL url = ClassLoader.getSystemResource(prop_path);
		try {
			props.load(url.openStream());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String get(String key) {
		return props.getProperty(key);
	}
}
