package kh.mclass.Igre.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 1. preHandle : DispatcherServlet -> Handler 호출 전
 * 2. postHandle : Handler -> DispatcherServlet 리턴 후(ModelAndView 접근 가능)
 * 3. afterCompletion : view단 처리가 모두 끝난 후
 *
 */
public class LoggerInterceptor extends HandlerInterceptorAdapter {

	private static Logger logger = LoggerFactory.getLogger(LoggerInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		logger.debug("====PreHandler====");
		logger.debug(request.getRequestURI());
		logger.debug("==================");
		
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
		
		logger.debug("==================");
		logger.debug("mav={}", modelAndView);
		logger.debug("=======View=======");
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
		
		logger.debug("=======End=======");
	}
	
}
