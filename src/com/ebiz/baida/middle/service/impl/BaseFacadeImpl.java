package com.ebiz.baida.middle.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ebiz.baida.middle.service.BaseFacade;

/**
 * @author Jin,QingHua
 */
public class BaseFacadeImpl extends TemplateServiceFreeMarkerConfigurerImpl implements BaseFacade {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	protected void printMsg(String msg, String module) {
		logger.info("=====>【{}】[{}] code generate OK！", msg, module);
	}
}
