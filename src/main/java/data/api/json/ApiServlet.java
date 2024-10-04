package data.api.json;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//ctrl+shift+f => 정렬
@WebServlet("/data.do")
public class ApiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ApiServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		// CORS 헤더 추가
//		response.setHeader("Access-Control-Allow-Origin", "http://localhost:8080");
//		response.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
//		response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
//		response.setHeader("Access-Control-Allow-Credentials", "true");
//		
//		response.setStatus(HttpServletResponse.SC_OK); // 200 OK 응답


		String command = request.getParameter("command");
		
		if(command.equals("list")) {
			response.sendRedirect("dataList.jsp");
		}
		else if (command.equals("condition")) {
			response.sendRedirect("safeDivingCondition.jsp");
		}
				
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
