package test.prop;

import java.io.IOException;
import java.net.URL;
import java.util.Properties;

public class ReadProperties {
	public static void main(String[] args) throws Exception {
		ReadProperties r = new ReadProperties();
		r.doit();

	}

	public void doit() {
		// properties in the classpath
		Properties props = new Properties();
		URL url = ClassLoader.getSystemResource("config.properties");
		try {
			props.load(url.openStream());
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println(props);
	}
}
