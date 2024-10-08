package web;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EmployeeDAO;
import model.Employee;

@WebServlet(value = "/", loadOnStartup = 1)
public class EmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private EmployeeDAO employeeDAO;

	public void init() {
		employeeDAO = new EmployeeDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getServletPath();

		try {
			switch (action) {
			case "/new":
				showNewForm(request, response);
				break;
			case "/insert":
				insertEmployee(request, response);
				break;
			case "/delete":
				deleteEmployee(request, response);
				break;
			case "/edit":
				showEditForm(request, response);
				break;
			case "/update":
				updateEmployee(request, response);
				break;
			default:
				listEmployee(request, response);
				break;
			}
		} catch (SQLException ex) {
			throw new ServletException(ex);
		}
	}

	private void listEmployee(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		List<Employee> listEmployee = employeeDAO.selectAllEmployees();
		request.setAttribute("listEmployee", listEmployee);
		RequestDispatcher dispatcher = request.getRequestDispatcher("employee-list.jsp");
		dispatcher.forward(request, response);
	}

	private void showNewForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("employee-form.jsp");
		dispatcher.forward(request, response);
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Employee existingEmployee = employeeDAO.selectEmployee(id);
		RequestDispatcher dispatcher = request.getRequestDispatcher("employee-form.jsp");
		request.setAttribute("employee", existingEmployee);
		dispatcher.forward(request, response);

	}

	private void insertEmployee(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		int gender = request.getParameter("gender") == null ? 0 : Integer.valueOf(request.getParameter("gender"));
		LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String departmentName = request.getParameter("departmentName");
		String remark = request.getParameter("remark");
		Employee newEmployee = new Employee(firstName, lastName, gender, dateOfBirth, phone, address, departmentName,
				remark);
		employeeDAO.insertEmployee(newEmployee);
		response.sendRedirect("list");
	}

	private void updateEmployee(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		int gender = Integer.valueOf(request.getParameter("gender"));
		LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String departmentName = request.getParameter("departmentName");
		String remark = request.getParameter("remark");

		Employee book = new Employee(id, firstName, lastName, gender, dateOfBirth, phone, address, departmentName,
				remark);
		employeeDAO.updateEmployee(book);
		response.sendRedirect("list");
	}

	private void deleteEmployee(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		employeeDAO.deleteEmployee(id);
		response.sendRedirect("list");
	}
}