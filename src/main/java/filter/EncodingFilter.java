package filter;

import javax.servlet.*;
import java.io.IOException;

public class EncodingFilter implements Filter{
	FilterConfig config;
	
	@Override
	public void init(FilterConfig config) throws ServletException {
		System.out.print("Encoding Filter 초기화");
		this.config=config;
	}
	
	@Override
	public void doFilter (ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("Encoding Filter 실행");
		request.setCharacterEncoding(config.getInitParameter("encoding"));
		chain.doFilter(request, response);
	}
	
	@Override
	public void destroy () { }

}
